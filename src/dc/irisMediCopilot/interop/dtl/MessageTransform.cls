Class dc.irisMediCopilot.interop.dtl.MessageTransform Extends Ens.DataTransformDTL [ DependsOn = (Telegram.JSONContainer, Telegram.Request) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Telegram.JSONContainer' targetClass='Telegram.Request' create='new' language='objectscript' >
<assign value='"sendMessage"' property='target.Method' action='set' />
<assign value='{}' property='target.Data' action='set' />
<assign value='source.Data.message.chat.id' property='target.Data."chat_id"' action='set' />
<assign value='"IRIS Echo: "_source.Data.message.text' property='target.Data.text' action='set' />
<assign value='source.Data.message."message_id"' property='target.Data."reply_to_message_id"' action='set' />
</transform>
}

}
