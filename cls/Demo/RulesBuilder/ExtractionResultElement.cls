Class Demo.RulesBuilder.ExtractionResultElement Extends %SerialObject
{

Property RuleElementSeq As %Integer;

Property RuleElement As RuleDefinitionElement;

Property MatchScore As %Numeric;

Property DictionaryTermId As %Integer;

Property Literal As %String(MAXLEN = 1000);

Property EntOccOutput As array Of %String(MAXLEN = 200);

Property Negation As %Boolean;

Property Color As %String;

Property FirstEntOccId As %Integer;

Property IsSecondary As %Boolean;

Storage Default
{
<Data name="ExtractionResultElementState">
<Value name="1">
<Value>RuleElementSeq</Value>
</Value>
<Value name="2">
<Value>RuleElement</Value>
</Value>
<Value name="3">
<Value>MatchScore</Value>
</Value>
<Value name="4">
<Value>EntOccOutput</Value>
</Value>
<Value name="5">
<Value>Literal</Value>
</Value>
<Value name="6">
<Value>DictionaryTermId</Value>
</Value>
<Value name="7">
<Value>Negation</Value>
</Value>
<Value name="8">
<Value>Color</Value>
</Value>
<Value name="9">
<Value>FirstEntOccId</Value>
</Value>
<Value name="10">
<Value>IsSecondary</Value>
</Value>
</Data>
<State>ExtractionResultElementState</State>
<StreamLocation>^Demo.RulesB860.ExtractionR5ACBS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
}

}

