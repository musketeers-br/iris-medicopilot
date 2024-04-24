Class dc.irisMediCopilot.interop.VoiceTransform Extends Ens.DataTransformDTL [ DependsOn = (Telegram.JSONContainer, Telegram.Request) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Telegram.JSONContainer' targetClass='Telegram.Request' create='new' language='objectscript' >
<assign value='"sendVoice"' property='target.Method' action='set' />
<assign value='{}' property='target.Data' action='set' />
<assign value='source.Data.message.chat.id' property='target.Data."chat_id"' action='set' />
<assign value='source.Data.message.document.thumbnail."file_path"' property='target.Data."photo"' action='set' />
<assign value='"Here is a preview for the "_source.Data.message.document."file_name"_" image"' property='target.Data."caption"' action='set' />
<assign value='source.Data.message.document.thumbnail."file_path"' property='target.Files' action='append' />
</transform>
}

}
