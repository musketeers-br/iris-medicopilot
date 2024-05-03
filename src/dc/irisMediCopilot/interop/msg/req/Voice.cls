Class dc.irisMediCopilot.interop.msg.req.Voice Extends (Ens.Request, %JSON.Adaptor)
{

/// Telgram Chat Id 
Property ChatId As %Integer(%JSONFIELDNAME = "chat_id");

/// File id of the audio voice on Telegram
Property FileId As %String(%JSONFIELDNAME = "file_id", MAXLEN = 1000);

/// Telegram Token
Property Token As %String(%JSONFIELDNAME = "token", MAXLEN = 1000);

/// File type. (flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.) Default: "ogg"
Property Type As %String(%JSONFIELDNAME = "type", MAXLEN = "", VALUELIST = ",flac,mp3,mp4,mpeg,mpga,m4a,ogg,wav,webm") [ InitialExpression = "ogg" ];

Storage Default
{
<Data name="VoiceDefaultData">
<Subscript>"Voice"</Subscript>
<Value name="1">
<Value>FileId</Value>
</Value>
<Value name="2">
<Value>Token</Value>
</Value>
<Value name="3">
<Value>ChatId</Value>
</Value>
<Value name="4">
<Value>Type</Value>
</Value>
</Data>
<DefaultData>VoiceDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
