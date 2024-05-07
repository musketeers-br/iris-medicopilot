Class dc.irisMediCopilot.interop.dtl.MediCopilot2Telegram Extends Ens.DataTransformDTL [ DependsOn = (dc.irisMediCopilot.interop.msg.resp.Prompt, Telegram.Request) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='dc.irisMediCopilot.interop.msg.req.Prompt' targetClass='Telegram.Request' create='new' language='objectscript' >
<assign value='"sendMessage"' property='target.Method' action='set' />
<assign value='{}' property='target.Data' action='set' />
<assign value='source.chatId' property='target.Data."chat_id"' action='set' />
<assign value='source.content' property='target.Data.text' action='set' />
<assign value='source.messageId' property='target.Data."reply_to_message_id"' action='set' />
</transform>
}

}
