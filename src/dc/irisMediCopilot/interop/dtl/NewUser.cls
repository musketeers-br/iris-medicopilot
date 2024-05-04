Class dc.irisMediCopilot.interop.dtl.NewUser Extends Ens.DataTransform [ DependsOn = (Telegram.JSONContainer, Telegram.Request) ]
{

ClassMethod Transform(source As Telegram.JSONContainer, ByRef target As Telegram.Request) As %Status
{
    Set tSC = $$$OK
    Try {

        Set target = ##class(Telegram.Request).%New()

        Set data = {
            "chat_id": (source.Data.message.chat.id),
            "protect_content": 1
        }
        
        Set target.Method = "sendMessage"
        Set data."text" = "Welcome "_source.Data.message."new_chat_participant"."first_name"_ " to Iris MediCoPilot"

        Set target.Data = data

    } Catch ex {
        Set tSC = ex.AsStatus()
    }
    Return tSC
}

}
