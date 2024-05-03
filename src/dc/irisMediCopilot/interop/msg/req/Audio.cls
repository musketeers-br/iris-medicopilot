Class dc.irisMediCopilot.interop.msg.req.Audio Extends (Ens.Request, %JSON.Adaptor)
{

/// File id of the audio voice on Telegram
Property FileId As %String(%JSONFIELDNAME = "fileId");

/// Base64 of the audio to transcript/translate
Property Audio As %String(%JSONFIELDNAME = "audio", MAXLEN = "");

/// Type of file. (flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.)
Property Type As %String(%JSONFIELDNAME = "type", MAXLEN = "", VALUELIST = ",flac,mp3,mp4,mpeg,mpga,m4a,ogg,wav,webm") [ Required ];

/// Language to translate the audio
Property Language As %String(%JSONFIELDNAME = "lang", MAXLEN = 3);

/// Retrieve all the info about the audio or only the text
Property FullInfo As %Boolean(%JSONFIELDNAME = "fullInfo");

/// Operation
Property Operation As %String(%JSONINCLUDE = "none") [ InitialExpression = "transcription" ];

Storage Default
{
<Data name="AudioRequestDefaultData">
<Subscript>"AudioRequest"</Subscript>
<Value name="1">
<Value>Audio</Value>
</Value>
<Value name="2">
<Value>Language</Value>
</Value>
<Value name="3">
<Value>FullInfo</Value>
</Value>
<Value name="4">
<Value>Operation</Value>
</Value>
<Value name="5">
<Value>FileName</Value>
</Value>
<Value name="6">
<Value>Type</Value>
</Value>
<Value name="7">
<Value>FileId</Value>
</Value>
</Data>
<DefaultData>AudioRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
