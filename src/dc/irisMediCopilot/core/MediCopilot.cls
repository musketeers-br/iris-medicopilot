Include Ensemble

Class dc.irisMediCopilot.core.MediCopilot Extends %RegisteredObject
{

Property ApiKey As %String;

Property CollectionName As %String;

Property SSLConfiguration As %String;

Property Model As %String [ InitialExpression = "gpt-3.5-turbo" ];

Method %OnNew(collectionName As %String, apiKey As %String, ssl As %String) As %Status [ Private ]
{
	If ( (collectionName="") || (apiKey="") || (ssl="") ) {
        $$$ThrowStatus($$$ERROR($$$GeneralError, "Server, token and SSL-configuration are required"))
    }
	Set ..ApiKey = apiKey
    Set ..CollectionName = collectionName
	Set ..SSLConfiguration = ssl
	Return $$$OK
}

Method ExecuteRequest(question As %String, sessionId As %String = "") As %DynamicObject
{
    Set response = ..RetrieveAnswer(..ApiKey, ..CollectionName, question, sessionId)
    If (response.error '="") {
        $$$LOGINFO("API ERROR: "_response.error)
    }
	Return ##class(%Library.DynamicObject).%FromJSON(response)
}

ClassMethod RetrieveAnswer(apiKey As %String, collectionName As %String, question As %String, sessionId As %String = "", model As %String = "gpt-3.5-turbo") [ Language = python ]
{
    import json
    from langchain_iris import IRISVector
    from langchain_community.chat_message_histories import ChatMessageHistory
    from langchain_core.chat_history import BaseChatMessageHistory
    from langchain_core.runnables.history import RunnableWithMessageHistory
    from langchain_openai import ChatOpenAI, OpenAIEmbeddings

    from langchain.chains import create_history_aware_retriever
    from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
    from langchain.chains import create_retrieval_chain
    from langchain.chains.combine_documents import create_stuff_documents_chain

    try:

        llm = ChatOpenAI(model= model, temperature=0, api_key=apiKey)
        embeddings = OpenAIEmbeddings(openai_api_key=apiKey)

        vectorstore = IRISVector.from_documents(
            embedding_function=embeddings,
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

        # Statefully manage chat history

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
            {"input": "What is Task Decomposition?"},
            config={
                "configurable": {"session_id": sessionId}
            },
        )

        return json.dumps({"answer": ai_msg_1['answer'], "context": ai_msg_1['context']})
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
        loader = CSVLoader(file_path= filePath)
        docs = loader.load()

        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
        splits = text_splitter.split_documents(docs)

        vectorstore = IRISVector.from_documents(
            documents=splits,
            embedding=OpenAIEmbeddings(openai_api_key=apiKey),
            dimension=1536,
            collection_name=collectionName,
        )

        retriever = vectorstore.as_retriever()

        return json.dumps({"status": true})
    except Exception as err:
        return json.dumps({"error": str(err)})
}

}
