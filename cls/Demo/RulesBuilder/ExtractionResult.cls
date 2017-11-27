Class Demo.RulesBuilder.ExtractionResult Extends %Persistent
{

Property DomainId As %Integer;

Property DocumentName As %String(MAXLEN = 250);

Property SourceId As %Integer;

Property RuleDefinition As RuleDefinition;

Property Score As %Numeric [ InitialExpression = 0 ];

Property HighlightingResult As %String(MAXLEN = "");

Property MatchedElements As list Of ExtractionResultElement(STORAGEDEFAULT = "array");

Property MeetsMandatory As %Boolean;

Property MeetsOrder As %Boolean;

Property Paragraph As Paragraph;

Property SentenceId As %Integer;

ForeignKey RuleDefinition(RuleDefinition) References Demo.RulesBuilder.RuleDefinition() [ OnDelete = cascade ];

ForeignKey ParagraphFK(Paragraph) References Paragraph() [ OnDelete = cascade ];

Index DomSrcIdx On (DomainId, DocumentName);

Storage Default
{
<Data name="ExtractionResultDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>SourceId</Value>
</Value>
<Value name="3">
<Value>RuleDefinition</Value>
</Value>
<Value name="4">
<Value>Score</Value>
</Value>
<Value name="5">
<Value>HighlightingResult</Value>
</Value>
<Value name="6">
<Value>MeetsMandatory</Value>
</Value>
<Value name="7">
<Value>MeetsOrder</Value>
</Value>
<Value name="8">
<Value>DomainId</Value>
</Value>
<Value name="9">
<Value>DocumentName</Value>
</Value>
<Value name="10">
<Value>Paragraph</Value>
</Value>
<Value name="11">
<Value>SentenceId</Value>
</Value>
</Data>
<Data name="MatchedElements">
<Attribute>MatchedElements</Attribute>
<Structure>subnode</Structure>
<Subscript>"MatchedElements"</Subscript>
</Data>
<DataLocation>^Demo.RulesB860.ExtractionR40E5D</DataLocation>
<DefaultData>ExtractionResultDefaultData</DefaultData>
<IdLocation>^Demo.RulesB860.ExtractionR40E5D</IdLocation>
<IndexLocation>^Demo.RulesB860.ExtractionR40E5I</IndexLocation>
<StreamLocation>^Demo.RulesB860.ExtractionR40E5S</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

