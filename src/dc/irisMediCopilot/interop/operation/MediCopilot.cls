Include Ensemble

Class dc.irisMediCopilot.interop.operation.MediCopilot Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Parameter ADAPTER = "dc.irisMediCopilot.adapter.MediCopilot";

Property Adapter As dc.irisMediCopilot.adapter.MediCopilot;

Method ProcessRequest(pRequest As dc.irisMediCopilot.interop.msg.req.Prompt, Output pResponse As dc.irisMediCopilot.interop.msg.resp.Prompt) As %Status
{
    Set tSC = $$$OK
    Try {
        $$$TRACE("starting the process")
        Set tSC = ..Adapter.ExecuteRequest(.resp, pRequest.content)
        If (resp.error '= "") {
            $$$ThrowStatus($$$ERROR($$$GeneralError,resp."error"_": "_resp.error))
        }
        Set pResponse = ##class(dc.irisMediCopilot.interop.msg.resp.Prompt).%New()
        Set pResponse.chatId = pRequest.chatId
        Set pResponse.content = resp.answer
        Set pResponse.messageId = pRequest.messageId
        Set pResponse.username = pRequest.username
    } Catch ex {
        Set tSC = ex.AsStatus()
    }
    Return tSC
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="dc.irisMediCopilot.interop.msg.req.Prompt">
    <Method>ProcessRequest</Method>
  </MapItem>
</MapItems>
}

}
