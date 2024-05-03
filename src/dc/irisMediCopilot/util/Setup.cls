Class dc.irisMediCopilot.util.Setup
{

/// Production Name
Parameter PRODUCTION = "dc.irisMediCopilot.interop.Production";

ClassMethod Init(Token As %String = "", OpenAIKey As %String = "") As %Status
{
    Set sc=$$$OK
	Try {
        For item="Telegram.BusinessService","St.OpenAi.BO.Api.Connect" {
            Set prop = "ApiKey"
            Set:(item["Telegram") prop = "Token"
            $$$ThrowOnError(##class(shvarov.i14y.Settings).SetValue(..#PRODUCTION, item, prop, Token))
        }

	} Catch tException {
		Set:$$$ISOK(sc) sc = tException.AsStatus()
	}

    Do ##class(%EnsembleMgr).SetAutoStart($namespace, ..#PRODUCTION)
    Job ##class(Ens.Director).StartProduction(..#PRODUCTION)

    Return sc
}

}
