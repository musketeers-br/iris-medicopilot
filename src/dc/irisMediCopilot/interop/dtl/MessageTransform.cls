Class dc.irisMediCopilot.interop.dtl.MessageTransform Extends Ens.DataTransformDTL [ DependsOn = (Telegram.JSONContainer, dc.irisMediCopilot.interop.msg.req.Prompt) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Telegram.JSONContainer' targetClass='dc.irisMediCopilot.interop.msg.req.Prompt' create='new' language='objectscript' >
<assign value='source.Data.message.chat.id' property='target.chatId' action='set' />
<assign value='source.Data.message.text' property='target.content' action='set' />
<assign value='source.Data.message.from.username' property='target.username' action='set' />
<assign value='source.Data.message."message_id"' property='target.messageId' action='set' />
</transform>
}

}
