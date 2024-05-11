Class dc.irisMediCopilot.util.Setup
{

/// Production Name
Parameter PRODUCTION = "dc.irisMediCopilot.interop.Production";

ClassMethod Init(Token As %String = "", OpenAIKey As %String = "") As %Status
{
    Set sc=$$$OK
	Try {
        For item="Telegram.BusinessService","VoiceFile.BusinessOperation","Telegram.BusinessOperation" {
            Continue:(Token="")
            $$$ThrowOnError(##class(shvarov.i14y.Settings).SetValue(..#PRODUCTION, item, "Token", Token))
        }
        For item="MediCopilot.BusinessOperation","OpenAi.BusinessOperation" {
            Continue:(OpenAIKey="")
            $$$ThrowOnError(##class(shvarov.i14y.Settings).SetValue(..#PRODUCTION, item, "ApiKey", OpenAIKey))
        }

	} Catch tException {
		Set:$$$ISOK(sc) sc = tException.AsStatus()
	}

    Do ##class(%EnsembleMgr).SetAutoStart($namespace, ..#PRODUCTION)
    Job ##class(Ens.Director).StartProduction(..#PRODUCTION)

    Return sc
}

ClassMethod LoadDocsToVectorSearch() [ Language = python ]
{
    import json
    from langchain_iris import IRISVector
    from langchain_openai import ChatOpenAI, OpenAIEmbeddings
    import os

    from langchain_community.document_loaders.csv_loader import CSVLoader
    from langchain_text_splitters import RecursiveCharacterTextSplitter

    apiKey = os.getenv("OPENAI_KEY")
    model = "gpt-3.5-turbo-0125"
    collectionName = "mediCopilot-docs"

    loader = CSVLoader(file_path='/home/irisowner/dev/src/data/synthetic_data_01.csv')
    docs = loader.load()

    text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
    splits = text_splitter.split_documents(docs)
    llm = ChatOpenAI(model= model, temperature=0, api_key=apiKey)
    embeddings = OpenAIEmbeddings(openai_api_key=apiKey)

    vectorstore = IRISVector.from_documents(
        documents=splits,
        embedding=OpenAIEmbeddings(openai_api_key=apiKey),
        dimension=1536,
        collection_name=collectionName,
    )
}

}
