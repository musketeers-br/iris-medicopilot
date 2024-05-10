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

/// Method Execute(Output resultMessage As %DynamicAbstractObject, question As %String) As %Status
Method Execute(Output resultMessage As %String, question As %String) As %Status
{
    Try {
        Set resultMessage = ..Core.Execute(question)
        //Set resultMessage.answer = ..Core.Execute(question)
    } Catch ex {
        Return ex.AsStatus()
    }
    Return $$$OK
}

}
