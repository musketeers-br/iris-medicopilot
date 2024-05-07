Class dc.irisMediCopilot.interop.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="dc.irisMediCopilot.interop.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Telegram.BusinessService" Category="" ClassName="Telegram.LongPollingService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="SSLConfig">tg</Setting>
    <Setting Target="Adapter" Name="CallInterval">5</Setting>
    <Setting Target="Host" Name="Target">Message.Router</Setting>
    <Setting Target="Adapter" Name="FilesMimeTypes">audio/ogg</Setting>
    <Setting Target="Adapter" Name="FilesPath">/irisdev/app/images</Setting>
    <Setting Target="Adapter" Name="FilesSave">file</Setting>
    <Setting Target="Adapter" Name="Token">Token</Setting>
  </Item>

  <Item Name="Message.Router" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">dc.irisMediCopilot.interop.rule.FilterMessage</Setting>
  </Item>

  <Item Name="TelegramVoice.Process" Category="" ClassName="dc.irisMediCopilot.interop.bp.Voice" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>

  <Item Name="MediCopilot.Process" Category="" ClassName="dc.irisMediCopilot.interop.bp.MediCopilot" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>

  <Item Name="SpeechToText.Router" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">dc.irisMediCopilot.interop.rule.SpeechToText</Setting>
    <Setting Target="Host" Name="RuleLogging">a</Setting>
    <Setting Target="Host" Name="AlertOnBadMessage">1</Setting>
    <Setting Target="Host" Name="ResponseFrom">OpenAi.BusinessOperation</Setting>
  </Item>

  <Item Name="MediCopilot2Telegram.Router" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">dc.irisMediCopilot.interop.rule.MediCopilot2Telegram</Setting>
    <Setting Target="Host" Name="RuleLogging">a</Setting>
    <Setting Target="Host" Name="AlertOnBadMessage">1</Setting>
    <Setting Target="Host" Name="ResponseFrom">Telegram.BusinessOperation</Setting>
  </Item>

  <Item Name="VoiceFile.BusinessOperation" Category="" ClassName="dc.irisMediCopilot.interop.operation.VoiceFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="SSLConfig">tg</Setting>
    <Setting Target="Adapter" Name="Token">Token</Setting>
  </Item>

  <Item Name="Telegram.BusinessOperation" Category="" ClassName="Telegram.BusinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="SSLConfig">tg</Setting>
    <Setting Target="Adapter" Name="Token">Token</Setting>
  </Item>

  <Item Name="OpenAi.BusinessOperation" Category="" ClassName="St.OpenAi.BO.Api.Connect" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ApiKey">Key</Setting>
    <Setting Target="Host" Name="Organization"></Setting>
    <Setting Target="Adapter" Name="SSLConfig">tg</Setting>
  </Item>

  <Item Name="MediCopilot.BusinessOperation" Category="" ClassName="dc.irisMediCopilot.interop.operation.MediCopilot" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ApiKey">Key</Setting>
    <Setting Target="Adapter" Name="SSLConfig">tg</Setting>
  </Item>
</Production>
}

}
