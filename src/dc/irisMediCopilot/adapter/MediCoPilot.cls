Include Ensemble

Class dc.irisMediCopilot.adapter.MediCopilot Extends Ens.OutboundAdapter
{

Property CollectionName As %String [ InitialExpression = "mediCopilot-docs" ];

Property ApiKey As %String(MAXLEN = "");

Property SSLConfig As %String;

Parameter SETTINGS As %String = "CollectionName:Connection,ApiKey:Connection,SSLConfig:Connection:sslConfigSelector";

Property Core As dc.irisMediCopilot.core.MediCopilot;

Method OnInit() As %Status
{
    Try {
        Set ..Core = ##class(dc.irisMediCopilot.core.MediCopilot).%New(..CollectionName, ..ApiKey, ..SSLConfig)
    } Catch ex {
        Return ex.AsStatus()
    }
    Return $$$OK
}

Method ExecuteRequest(Output resultMessage As %DynamicAbstractObject = {{}}, question As %String) As %Status
{
    Try {
        $$$TRACE("starting the adapter process")
        If ('$IsObject(..Core)) {
            $$$ThrowStatus($$$ERROR($$$GeneralError, "Сonnection not initialized"))
        }

        Set resultMessage = {}
        $$$TRACE(question)
        Set resultMessage = ..Core.ExecuteRequest(question)
        $$$TRACE(resultMessage)
    } Catch ex {
        Return ex.AsStatus()
    }
    Return $$$OK
}

}
