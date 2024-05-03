/// 
Class dc.irisMediCopilot.interop.bp.Voice Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Telegram.Request' response='dc.irisMediCopilot.interop.msg.resp.Voice' height='2000' width='2000' >
<context>
<property name='voiceResponse' type='dc.irisMediCopilot.interop.msg.resp.Voice' instantiate='0' />
<property name='audioRequest' type='St.OpenAi.Msg.Audio.AudioRequest' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<call name='Get Voice' target='VoiceFile.BusinessOperation' async='0' xpos='200' ypos='250' >
<request type='Telegram.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='dc.irisMediCopilot.interop.msg.resp.Voice' >
<assign property="context.voiceResponse" value="callresponse" action="set" />
</response>
</call>
<call name='Call Speech2Text' target='SpeechToText.Router' async='1' xpos='200' ypos='450' >
<request type='dc.irisMediCopilot.interop.msg.resp.Voice' >
<assign property="callrequest" value="context.voiceResponse" action="set" />
</request>
</call>
<sync name='Wait Voice' calls='Get Voice,Call Speech2Text' type='all' xpos='200' ypos='550' />
</sequence>
</process>
}

}
