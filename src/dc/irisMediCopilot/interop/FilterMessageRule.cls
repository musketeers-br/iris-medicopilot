Class dc.irisMediCopilot.interop.FilterMessageRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="" production="dc.irisMediCopilot.interop.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<constraint name="msgClass" value="Telegram.JSONContainer"></constraint>
<when condition="(GetJSONValue(Document.Data.message,&quot;voice&quot;))!=&quot;&quot;" comment="">
<send transform="dc.irisMediCopilot.interop.VoiceTransform" target="Telegram.BusinessOperation"></send>
</when>
<when condition="(GetJSONValue(Document.Data.message,&quot;text&quot;))!=&quot;&quot;" comment="">
<send transform="dc.irisMediCopilot.interop.MessageTransformDTL" target="Telegram.BusinessOperation"></send>
</when>
<otherwise>
</otherwise>
</rule>
</ruleSet>
</ruleDefinition>
}

}
