Class dc.irisMediCopilot.interop.dtl.VoiceToOpenAi Extends Ens.DataTransformDTL [ DependsOn = (dc.irisMediCopilot.interop.msg.resp.Voice, St.OpenAi.Msg.Audio.AudioRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='dc.irisMediCopilot.interop.msg.resp.Voice' targetClass='St.OpenAi.Msg.Audio.AudioRequest' create='new' language='objectscript' >
<assign value='source.Audio' property='target.Audio' action='set' />
<assign value='"ogg"' property='target.Type' action='set' />
<assign value='"transcription"' property='target.Operation' action='set' />
<assign value='"json"' property='target.ResponseFormat' action='set' />
</transform>
}

}
