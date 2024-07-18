Include Ensemble

Class dc.irisMediCopilot.core.MediCopilot Extends %RegisteredObject
{

Property ApiKey As %String;

Property CollectionName As %String;

Property SSLConfiguration As %String;

Property Model As %String [ InitialExpression = "gpt-3.5-turbo" ];

Property GenAi As %String(VALUELIST = "OpenAi,Gemini,Claude") [ InitialExpression = "OpenAi" ];

Property DataPath As %String [ InitialExpression = "/home/irisowner/dev/src/data/synthetic_data_02.csv" ];

Method %OnNew(collectionName As %String, apiKey As %String, ssl As %String, dataPath As %String) As %Status [ Private ]
{
	If ( (collectionName="") || (apiKey="") || (ssl="") ) {
        $$$ThrowStatus($$$ERROR($$$GeneralError, "Server, token and SSL-configuration are required"))
    }
	Set ..ApiKey = apiKey
    Set ..CollectionName = collectionName
	Set ..SSLConfiguration = ssl
    Set ..DataPath = dataPath
	Return $$$OK
}

Method Execute(question As %String, sessionId As %String = "") As %DynamicObject
{
    Set response = ..RetrieveAnswer(..ApiKey, ..CollectionName, question, sessionId, ..Model, ..DataPath)
    $$$LOGINFO("response: "_response)

    Try {
        Set response = ##class(%Library.DynamicObject).%FromJSON(response)
    } Catch ex {
        $$$LOGINFO("JSON ERROR: "_ex.AsStatus())
        Set response = {}
    }

    If (response.error '="") {
        $$$LOGINFO("API ERROR: "_response.error)
    }

	Return response
}

ClassMethod RetrieveAnswer(apiKey As %String, collectionName As %String, question As %String, sessionId As %String = "", model As %String = "gpt-3.5-turbo", dataPath As %String = "", genAi As %String = "openAI") [ Language = python ]
{
    import json
    from langchain_iris import IRISVector
    from langchain_community.chat_message_histories import ChatMessageHistory
    from langchain_core.chat_history import BaseChatMessageHistory
    from langchain_core.runnables.history import RunnableWithMessageHistory

    from langchain_community.document_loaders.csv_loader import CSVLoader
    from langchain_text_splitters import RecursiveCharacterTextSplitter

    from langchain.chains import create_history_aware_retriever
    from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
    from langchain.chains import create_retrieval_chain
    from langchain.chains.combine_documents import create_stuff_documents_chain

    if (genAi == "gemini"):
        # Google Gemini
        from langchain_google_genai import ChatGoogleGenerativeAI, GoogleGenerativeAIEmbeddings
    else:
        # OpenAI
        from langchain_openai import ChatOpenAI, OpenAIEmbeddings

    import os
    from sqlalchemy import text

    try:
        loader = CSVLoader(file_path=dataPath)
        docs = loader.load()

        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
        splits = text_splitter.split_documents(docs)

        if (genAi == "gemini"):
            # Google Gemini
            llm = ChatGoogleGenerativeAI(model= model, temperature=0, google_api_key=apiKey)
            embeddingFunction=GoogleGenerativeAIEmbeddings(model="models/embedding-001", task_type="retrieval_document", google_api_key=apiKey)
        else:
            # OpenAI
            llm = ChatOpenAI(model= model, temperature=0, api_key=apiKey)
            embeddingFunction=OpenAIEmbeddings(model=model, openai_api_key=apiKey)

        # call IRISVector using a previous collection
        vectorstore = IRISVector(
            embedding_function=embeddingFunction,
            dimension=1536,
            collection_name=collectionName,
        )
        # check if document collection exists
        conn = vectorstore.connect()
        #; sql = f"select count(*) from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'SQLUser' and TABLE_NAME = 'mediCopilot-docs'"
        sql = f'SELECT count(*) FROM SQLUser."{collectionName}"'
        result = conn.execute(text(sql))
        collection_exists = result.first()[0] > 0
        print(collection_exists)
        if not collection_exists:
            # call IRISVector passing a list of documents to be stored in a collection
            vectorstore = IRISVector.from_documents(
                documents=splits,
                embedding=embeddingFunction,
                dimension=1536,
                collection_name=collectionName,
            )

        retriever = vectorstore.as_retriever()

        contextualize_q_system_prompt = """Given a chat history and the latest user question \
        which might reference context in the chat history, formulate a standalone question \
        which can be understood without the chat history. Do NOT answer the question, \
        just reformulate it if needed and otherwise return it as is."""
        contextualize_q_prompt = ChatPromptTemplate.from_messages(
            [
                ("system", contextualize_q_system_prompt),
                MessagesPlaceholder("chat_history"),
                ("human", "{input}"),
            ]
        )
        history_aware_retriever = create_history_aware_retriever(
            llm, retriever, contextualize_q_prompt
        )

        qa_system_prompt = """You are an assistant for question-answering tasks. \
        Use the following pieces of retrieved context to answer the question. \
        If you don't know the answer, just say that you don't know. \
        Use three sentences maximum and keep the answer concise.\

        {context}"""
        qa_prompt = ChatPromptTemplate.from_messages(
            [
                ("system", qa_system_prompt),
                MessagesPlaceholder("chat_history"),
                ("human", "{input}"),
            ]
        )

        question_answer_chain = create_stuff_documents_chain(llm, qa_prompt)

        rag_chain = create_retrieval_chain(history_aware_retriever, question_answer_chain)

        store = {}

        def get_session_history(session_id: str) -> BaseChatMessageHistory:
            if session_id not in store:
                store[session_id] = ChatMessageHistory()
            return store[session_id]

        conversational_rag_chain = RunnableWithMessageHistory(
            rag_chain,
            get_session_history,
            input_messages_key="input",
            history_messages_key="chat_history",
            output_messages_key="answer",
        )

        ai_msg_1 = conversational_rag_chain.invoke(
            #; {"input": "What is Task Decomposition?"},
            {"input": question},
            config={
                "configurable": {"session_id": sessionId}
            },
        )

        return json.dumps({"answer": str(ai_msg_1['answer'])})
    except Exception as err:
        return json.dumps({"error": str(err)})
}

ClassMethod Ingest(apiKey As %String, collectionName As %String, filePath As %String, model As %String = "gpt-3.5-turbo-0125") As %String [ Language = python ]
{

    import json
    from langchain_iris import IRISVector
    from langchain_community.chat_message_histories import ChatMessageHistory
    from langchain_core.chat_history import BaseChatMessageHistory
    from langchain_core.runnables.history import RunnableWithMessageHistory
    from langchain_openai import ChatOpenAI, OpenAIEmbeddings
    from langchain_community.document_loaders.csv_loader import CSVLoader
    from langchain_core.chat_history import BaseChatMessageHistory
    from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
    from langchain_core.runnables.history import RunnableWithMessageHistory
    from langchain_text_splitters import RecursiveCharacterTextSplitter

    try:
        loader = CSVLoader(file_path=filePath)
        docs = loader.load()

        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
        splits = text_splitter.split_documents(docs)

        vectorstore = IRISVector.from_documents(
            documents=splits,
            embedding=OpenAIEmbeddings(openai_api_key=apiKey),
            dimension=1536,
            collection_name=collectionName,
        )

        # retriever = vectorstore.as_retriever()

        return json.dumps({"status": True})
    except Exception as err:
        return json.dumps({"error": str(err)})
}

}
