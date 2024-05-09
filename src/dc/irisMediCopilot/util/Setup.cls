Class dc.irisMediCopilot.util.Setup
{

/// Production Name
Parameter PRODUCTION = "dc.irisMediCopilot.interop.Production";

ClassMethod Init(Token As %String = "", OpenAIKey As %String = "") As %Status
{
    Set sc=$$$OK
	Try {
        For item="Telegram.BusinessService","VoiceFile.BusinessOperation" {
            Continue:(Token="")
            $$$ThrowOnError(##class(shvarov.i14y.Settings).SetValue(..#PRODUCTION, item, "Token", Token))
        }
        For item="MediCopilot.BusinessOperation","St.OpenAi.BO.Api.Connect" {
            Continue:(OpenAIKey="")
            $$$ThrowOnError(##class(shvarov.i14y.Settings).SetValue(..#PRODUCTION, item, "ApiKey", OpenAIKey))
        }

	} Catch tException {
		Set:$$$ISOK(sc) sc = tException.AsStatus()
	}

    Do ##class(%EnsembleMgr).SetAutoStart($namespace, ..#PRODUCTION)
    Job ##class(Ens.Director).StartProduction(..#PRODUCTION)

    Return sc
}

}
