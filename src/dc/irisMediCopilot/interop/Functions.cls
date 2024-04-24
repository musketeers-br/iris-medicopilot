Class dc.irisMediCopilot.interop.Functions Extends Ens.Rule.FunctionSet
{

ClassMethod GetJSONValue(obj As %DynamicAbstractObject, key As %String) As %String
{
    if ('$isobject(obj)) {
        return ""
    }
    Return obj.%Get(key)
}

}
