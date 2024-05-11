Class dc.irisMediCopilot.adapter.TelegramOutboundAdapter Extends Telegram.OutboundAdapter
{

Method TokenGet() As %String
{
    Set telegramToken = ##class(%SYSTEM.Util).GetEnviron("TELEGRAM_TOKEN")
    If (i%Token = "") && (telegramToken '= "") {
        $$$TRACE("Using key from TELEGRAM_TOKEN env")
        Return telegramToken
    }
    $$$TRACE("Using key from settings")
    Return i%Token
}

}
