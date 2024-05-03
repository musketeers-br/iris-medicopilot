Class dc.irisMediCopilot.interop.rule.SpeechToText Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="" production="dc.irisMediCopilot.interop.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<constraint name="msgClass" value="dc.irisMediCopilot.interop.msg.resp.Voice"></constraint>
<when condition="1" comment="">
<send transform="dc.irisMediCopilot.interop.dtl.VoiceToOpenAi" target="OpenAi.BusinessOperation"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
