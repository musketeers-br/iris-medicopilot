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
    <Setting Target="Host" Name="Target">MessageRouting</Setting>
    <Setting Target="Adapter" Name="FilesMimeTypes">image/png</Setting>
    <Setting Target="Adapter" Name="FilesPath">/irisdev/app/images</Setting>
    <Setting Target="Adapter" Name="FilesSave">file,thumbnail</Setting>
    <Setting Target="Adapter" Name="Token">Token</Setting>
  </Item>
  <Item Name="MessageRouting" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">dc.irisMediCopilot.interop.FilterMessageRule</Setting>
  </Item>
</Production>
}

}
