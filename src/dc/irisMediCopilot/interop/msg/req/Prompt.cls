Class dc.irisMediCopilot.interop.msg.req.Prompt Extends (Ens.Request, %JSON.Adaptor)
{

Property content As %String(%JSONFIELDNAME = "content", MAXLEN = "");

Property sessionId As %Integer(%JSONFIELDNAME = "session_id");

Property messageId As %String(%JSONFIELDNAME = "message_id", MAXLEN = "");

Property chatId As %String(%JSONFIELDNAME = "chat_id", MAXLEN = "");

Property username As %String(%JSONFIELDNAME = "username", MAXLEN = "");

Storage Default
{
<Data name="PromptDefaultData">
<Subscript>"Prompt"</Subscript>
<Value name="1">
<Value>Content</Value>
</Value>
<Value name="2">
<Value>sessionId</Value>
</Value>
<Value name="3">
<Value>messageId</Value>
</Value>
<Value name="4">
<Value>username</Value>
</Value>
<Value name="5">
<Value>content</Value>
</Value>
<Value name="6">
<Value>chatId</Value>
</Value>
</Data>
<DefaultData>PromptDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
