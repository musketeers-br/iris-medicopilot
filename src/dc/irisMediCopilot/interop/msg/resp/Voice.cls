Class dc.irisMediCopilot.interop.msg.resp.Voice Extends (Ens.Request, %JSON.Adaptor)
{

/// Base64 of the audio to transcript/translate
Property Audio As %String(%JSONFIELDNAME = "audio", MAXLEN = "") [ Required ];

/// Telgram Chat Id 
Property ChatId As %Integer(%JSONFIELDNAME = "chat_id");

/// File id of the audio voice on Telegram
Property FileId As %String(%JSONFIELDNAME = "file_id", MAXLEN = "");

/// File type. (flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.) Default: "ogg"
Property Type As %String(%JSONFIELDNAME = "type", MAXLEN = "", VALUELIST = ",flac,mp3,mp4,mpeg,mpga,m4a,ogg,wav,webm") [ InitialExpression = "ogg" ];

Storage Default
{
<Data name="VoiceDefaultData">
<Subscript>"Voice"</Subscript>
<Value name="1">
<Value>Audio</Value>
</Value>
<Value name="2">
<Value>ChatId</Value>
</Value>
<Value name="3">
<Value>FileId</Value>
</Value>
<Value name="4">
<Value>Type</Value>
</Value>
</Data>
<DefaultData>VoiceDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
