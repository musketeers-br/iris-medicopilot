Class dc.irisMediCopilot.interop.bp.Voice Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Telegram.Request' response='St.OpenAi.Msg.Audio.AudioResponse' height='2000' width='2000' >
<context>
<property name='voiceResponse' type='dc.irisMediCopilot.interop.msg.resp.Voice' instantiate='0' />
<property name='audioRequest' type='St.OpenAi.Msg.Audio.AudioRequest' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<call name='Get Voice' target='VoiceFile.BusinessOperation' async='1' xpos='200' ypos='250' >
<request type='Telegram.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='dc.irisMediCopilot.interop.msg.resp.Voice' >
</response>
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
