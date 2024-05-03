Class dc.irisMediCopilot.interop.dtl.VoiceTransform Extends Ens.DataTransformDTL [ DependsOn = (Telegram.JSONContainer, Telegram.Request) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Telegram.JSONContainer' targetClass='Telegram.Request' create='new' language='objectscript' >
<assign value='{}' property='target.Data' action='set' />
<assign value='source.Data.message.chat.id' property='target.Data."chat_id"' action='set' />
<assign value='source.Data.message.voice."file_id" ' property='target.Data."file_id"' action='set' />
<assign value='source.Data.message."message_id"' property='target.Data."reply_to_message_id"' action='set' />
</transform>
}

}
