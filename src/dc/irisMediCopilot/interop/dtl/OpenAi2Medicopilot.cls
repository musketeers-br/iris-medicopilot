Class dc.irisMediCopilot.interop.dtl.OpenAi2Medicopilot Extends Ens.DataTransformDTL [ DependsOn = (dc.irisMediCopilot.interop.msg.resp.Prompt, Telegram.Request) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass ='St.OpenAi.Msg.Audio.AudioResponse' targetClass='dc.irisMediCopilot.interop.msg.req.Prompt' create='new' language='objectscript' >
<assign value='source.Text' property='target.content' action='set' />
</transform>
}

}
