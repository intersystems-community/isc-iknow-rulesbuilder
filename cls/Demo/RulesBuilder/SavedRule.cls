/// Not yet in use
Class Demo.RulesBuilder.SavedRule Extends %Persistent
{

Property DomainId As %Integer;

Property DocumentName As %String(MAXLEN = 2000);

Property ExtractionResult As ExtractionResult;

Property RuleText As %String(MAXLEN = 2000);

Property Comments As %String(MAXLEN = "");

Property Paragraph As Paragraph;

Index DomDocIdx On (DomainId, DocumentName);

ForeignKey ExtractionResultFK(ExtractionResult) References ExtractionResult() [ OnDelete = cascade ];

ForeignKey ParagraphFK(Paragraph) References Paragraph() [ OnDelete = cascade ];

Storage Default
{
<Data name="SavedRuleDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DomainId</Value>
</Value>
<Value name="3">
<Value>DocumentName</Value>
</Value>
<Value name="4">
<Value>ExtractionResult</Value>
</Value>
<Value name="5">
<Value>RuleText</Value>
</Value>
<Value name="6">
<Value>Comments</Value>
</Value>
<Value name="7">
<Value>Paragraph</Value>
</Value>
</Data>
<DataLocation>^Demo.RulesBuilder.SavedRuleD</DataLocation>
<DefaultData>SavedRuleDefaultData</DefaultData>
<IdLocation>^Demo.RulesBuilder.SavedRuleD</IdLocation>
<IndexLocation>^Demo.RulesBuilder.SavedRuleI</IndexLocation>
<StreamLocation>^Demo.RulesBuilder.SavedRuleS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

