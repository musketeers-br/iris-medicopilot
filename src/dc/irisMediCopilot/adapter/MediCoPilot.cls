Include Ensemble

Class dc.irisMediCopilot.adapter.MediCopilot Extends Ens.OutboundAdapter
{

Property CollectionName As %String [ InitialExpression = "mediCopilot-docs" ];

Property ApiKey As %String(MAXLEN = "");

Property SSLConfig As %String;

Property Model As %String(MAXLEN = "") [ InitialExpression = "gpt-3.5-turbo" ];

Property DataPath As %String(MAXLEN = "") [ InitialExpression = "/home/irisowner/dev/src/data/synthetic_data_02.csv" ];

Parameter SETTINGS = "CollectionName:Connection,ApiKey:Connection,SSLConfig:Connection:sslConfigSelector,DataPath:Setup,Model:Setup";

Property Core As dc.irisMediCopilot.core.MediCopilot;

Method OnInit() As %Status
{
    Try {
        Set ..Core = ##class(dc.irisMediCopilot.core.MediCopilot).%New(..CollectionName, ..ApiKey, ..SSLConfig, ..DataPath)
    } Catch ex {
        Return ex.AsStatus()
    }
    Return $$$OK
}

Method ApiKeyGet() As %String
{
    Set openaiKey = ##class(%SYSTEM.Util).GetEnviron("OPENAI_KEY")
    If (i%ApiKey = "") && (openaiKey '= "") {
        $$$TRACE("Using key from OPENAI_KEY env")
        Return openaiKey
    }
    $$$TRACE("Using key from settings")
    Return i%ApiKey
}

Method Execute(Output resultMessage As %DynamicAbstractObject, question As %String) As %Status
{
    Set resultMessage = {}
    Try {
        If ('$IsObject(..Core)) {
            $$$ThrowStatus($$$ERROR($$$GeneralError, "Сonnection not initialized"))
        }

        Set resultMessage = ..Core.Execute(question)
    } Catch ex {
        Return ex.AsStatus()
    }
    Return $$$OK
}

}
