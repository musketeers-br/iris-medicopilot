Class dc.irisMediCopilot.interop.rule.VoiceFile Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="" production="dc.irisMediCopilot.interop.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<constraint name="source" value="Telegram.JSONContainer"></constraint>
<when condition="1" comment="">
<send transform="dc.irisMediCopilot.interop.dtl.VoiceTransform" target="VoiceFile.BusinessOperation"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
