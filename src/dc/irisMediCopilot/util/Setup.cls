Class dc.irisMediCopilot.util.Setup
{

/// Production Name
Parameter PRODUCTION = "dc.irisMediCopilot.interop.Production";

ClassMethod Init(Token As %String = "") As %Status
{
    Set sc=$$$OK
	Try {
        For item="Telegram.BusinessService" {
            $$$ThrowOnError(##class(shvarov.i14y.Settings).SetValue(..#PRODUCTION, item, "Token", Token))
        }
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}

    Do ##class(%EnsembleMgr).SetAutoStart($namespace, ..#PRODUCTION)
    Job ##class(Ens.Director).StartProduction(..#PRODUCTION)

    Return sc
}

}
