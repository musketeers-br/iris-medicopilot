Include Ensemble

Class dc.irisMediCopilot.interop.operation.VoiceFile Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Parameter ADAPTER = "Telegram.OutboundAdapter";

Property Adapter As Telegram.OutboundAdapter;

ClassMethod GetVoiceFilePath(telegramserver As %String, token As %String, fileId As %String) As %String [ Language = python ]
{
    import requests

    url = f"https://{telegramserver}/bot{token}/"
    data = {'file_id': fileId}
    resp = requests.post(f"{url}getFile", json=data).json()
    if (not resp["ok"]):
        return ""
    filePath = resp["result"]["file_path"]
    return filePath
}

ClassMethod GetVoiceEncodedData(telegramserver As %String, token As %String, filePath As %String) As %String [ Language = python ]
{
    import requests
    import base64

    url = f"https://{telegramserver}/file/bot{token}/{filePath}"
    file_resp = requests.get(url)
    encoded_data = base64.b64encode(file_resp.content)
    return encoded_data
}

Method ProcessRequest(pRequest As Telegram.Request, Output pResponse As dc.irisMediCopilot.interop.msg.resp.Voice) As %Status
{
    Set tSC = $$$OK
    Return:(pRequest.Data."file_id"="") tSC
    Try {
        $$$TRACE("starting the process")
        Set pResponse = ##class(dc.irisMediCopilot.interop.msg.resp.Voice).%New()
        Set pResponse.ChatId = pRequest.Data."chat_id"
        Set pResponse.FileId = pRequest.Data."file_id"

        $$$TRACE("get voice file path")
        Set filePath =..GetVoiceFilePath(..Adapter.Server, ..Adapter.Token, pRequest.Data."file_id")
        $$$TRACE(filePath)
        $$$TRACE("get voice encoded data")
        Set pResponse.Audio = ..GetVoiceEncodedData(..Adapter.Server, ..Adapter.Token, filePath)
        $$$TRACE(pResponse.Audio)
        
    } Catch ex {
        Set tSC = ex.AsStatus()
    }
    Return tSC
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Telegram.Request">
    <Method>ProcessRequest</Method>
  </MapItem>
</MapItems>
}

}
