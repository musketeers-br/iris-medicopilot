Class dc.irisMediCopilot.interop.bp.MediCopilot Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='dc.irisMediCopilot.interop.msg.req.Prompt' response='dc.irisMediCopilot.interop.msg.resp.Prompt' height='2000' width='2000' >
<context>
<property name='MediCopilotResponse' type='dc.irisMediCopilot.interop.msg.resp.Voice' instantiate='0' />
<property name='audioRequest' type='St.OpenAi.Msg.Audio.AudioRequest' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<call name='Get Answer' target='MediCopilot.BusinessOperation' async='0' xpos='200' ypos='250' >
<request type='dc.irisMediCopilot.interop.msg.req.Prompt' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='dc.irisMediCopilot.interop.msg.resp.Prompt' >
<assign property="context.MediCopilotResponse" value="callresponse" action="set" />
</response>
</call>
<call name='Answering' target='MediCopilot2Telegram.Router' async='1' xpos='200' ypos='450' >
<request type='dc.irisMediCopilot.interop.msg.resp.Prompt' >
<assign property="callrequest" value="context.MediCopilotResponse" action="set" />
</request>
</call>
<sync name='Wait Answer' calls='Get Answer,Answering' type='all' xpos='200' ypos='550' />
</sequence>
</process>
}

}
