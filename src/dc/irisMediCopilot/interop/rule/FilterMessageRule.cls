Class dc.irisMediCopilot.interop.rule.FilterMessage Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="" production="dc.irisMediCopilot.interop.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<constraint name="msgClass" value="Telegram.JSONContainer"></constraint>
<when condition="(GetJSONValue(Document.Data.message,&quot;voice&quot;))!=&quot;&quot;" comment="">
<send transform="dc.irisMediCopilot.interop.dtl.VoiceTransform" target="TelegramVoice.Process"></send>
</when>
<when condition="(GetJSONValue(Document.Data.message,&quot;text&quot;))=&quot;/start&quot;" comment="">
<send transform="dc.irisMediCopilot.interop.dtl.NewUser" target="Telegram.BusinessOperation"></send>
</when>
<when condition="(GetJSONValue(Document.Data.message,&quot;text&quot;))!=&quot;&quot;" comment="">
<send transform="dc.irisMediCopilot.interop.dtl.MessageTransform" target="MediCopilot.Process"></send>
</when>
<otherwise>
</otherwise>
</rule>
</ruleSet>
</ruleDefinition>
}

}
