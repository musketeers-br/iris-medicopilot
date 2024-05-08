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
<property name='audioResponse' type='St.OpenAi.Msg.Audio.AudioResponse' instantiate='0' />
<property name='audioRequest' type='St.OpenAi.Msg.Audio.AudioRequest' instantiate='0' />
<property name='promptRequest' type='dc.irisMediCopilot.interop.msg.req.Prompt' instantiate='0' />
</context>
<sequence xend='200' yend='950' >
<call name='Get Voice' target='VoiceFile.BusinessOperation' async='0' xpos='200' ypos='250' >
<request type='Telegram.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='dc.irisMediCopilot.interop.msg.resp.Voice' >
<assign property="context.voiceResponse" value="callresponse" action="set" />
</response>
</call>
<call name='Call Speech2Text' target='SpeechToText.Router' async='0' xpos='200' ypos='350' >
<request type='dc.irisMediCopilot.interop.msg.resp.Voice' >
<assign property="callrequest" value="context.voiceResponse" action="set" />
</request>
<response type='St.OpenAi.Msg.Audio.AudioResponse' >
<assign property="context.audioResponse" value="callresponse" action="set" />
</response>
</call>
<transform name='OpenAi2MediCopilot' class='dc.irisMediCopilot.interop.dtl.OpenAi2Medicopilot' source='context.audioResponse' target='context.promptRequest' xpos='200' ypos='450' />
<assign name="chat id" property="context.promptRequest.chatId" value='request.Data."chat_id"' action="set" xpos='200' ypos='550' />
<assign name="message id" property="context.promptRequest.messageId" value='request.Data."reply_to_message_id"' action="set" xpos='200' ypos='650' />
<call name='Call MediCopilot' target='MediCopilot.Process' async='1' xpos='200' ypos='750' >
<request type='dc.irisMediCopilot.interop.msg.req.Prompt' >
<assign property="callrequest" value="context.promptRequest" action="set" />
</request>
</call>
<sync name='Wait Voice' calls='Get Voice,Call Speech2Text,Call MediCopilot' type='all' xpos='200' ypos='850' />
</sequence>
</process>
}

}
