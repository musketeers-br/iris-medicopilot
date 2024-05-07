Class dc.irisMediCopilot.interop.msg.resp.Prompt Extends (Ens.Response, %JSON.Adaptor)
{

Property content As %String(%JSONFIELDNAME = "content", MAXLEN = "");

Property messageId As %String(%JSONFIELDNAME = "message_id", MAXLEN = "");

Property chatId As %String(%JSONFIELDNAME = "chat_id", MAXLEN = "");

Property username As %String(%JSONFIELDNAME = "username", MAXLEN = "");

Storage Default
{
<Data name="ChatResponseDefaultData">
<Subscript>"ChatResponse"</Subscript>
<Value name="1">
<Value>Content</Value>
</Value>
<Value name="2">
<Value>content</Value>
</Value>
<Value name="3">
<Value>messageId</Value>
</Value>
<Value name="4">
<Value>chatId</Value>
</Value>
<Value name="5">
<Value>username</Value>
</Value>
</Data>
<DefaultData>ChatResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
