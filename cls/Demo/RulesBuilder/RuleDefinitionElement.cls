Class Demo.RulesBuilder.RuleDefinitionElement Extends %SerialObject
{

Property Type As %String(VALUELIST = ",dictionary,item");

Property Name As %String;

/// 0 = optional
/// 1 = mandatory
/// 2 = one or more (keep best)
/// 2 = one or more (keep all)
Property Count As %Integer [ InitialExpression = 1 ];

Property Negation As %String(VALUELIST = ",N/A,rule,affirmative,negative") [ InitialExpression = "N/A" ];

Storage Default
{
<Data name="RuleDefinitionElementState">
<Value name="1">
<Value>Type</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Count</Value>
</Value>
<Value name="4">
<Value>Negation</Value>
</Value>
</Data>
<State>RuleDefinitionElementState</State>
<StreamLocation>^Demo.RulesB860.RuleDefinitAE14S</StreamLocation>
<Type>%Library.CacheSerialState</Type>
}

}

