Class dc.irisMediCopilot.interop.bp.Speach Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Telegram.Request' response='dc.irisMediCopilot.interop.msg.resp.Audio' height='2000' width='2000' >
<context>
<property name='audioRequest' type='St.OpenAi.Msg.Audio.AudioRequest' instantiate='0' />
</context>
<sequence xend='200' yend='650' >

<call name='Call API' target='OpenAi.BusinessOperation' async='1' xpos='200' ypos='350' >
<request type='St.OpenAi.Msg.Audio.AudioRequest' >
<assign property="callrequest" value="context.audioRequest" action="set" />
</request>
<response type='St.OpenAi.Msg.Audio.AudioResponse' >
<assign property="context.audioResponse" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait Call APi' calls='Call API' type='all' xpos='200' ypos='450' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
