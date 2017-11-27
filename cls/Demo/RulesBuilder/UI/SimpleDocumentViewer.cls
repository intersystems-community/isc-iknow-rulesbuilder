Class Demo.RulesBuilder.UI.SimpleDocumentViewer Extends %ZEN.Component.page
{

Property doc As %String;

XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page title="Document viewer">
<select label="document" sql="SELECT DISTINCT DocumentName FROM Demo_RulesBuilder.Paragraph" onchange="zenPage.changeDoc(zenThis.getValue());" />
<spacer height="20" />
<html id="html" OnDrawContent="DrawDocument" />
</page>
}

ClientMethod changeDoc(doc) [ Language = javascript ]
{
	var sc = zenPage.setProperty('doc', doc);
	zen('html').refreshContents();
}

Method DrawDocument(pSeed) As %Status
{
	set tSC = $$$OK
	try {
		set tDocName = ..doc, tMaxLevel=0
		&SQL(SELECT MAX("Level") INTO :tMaxLevel FROM Demo_RulesBuilder.Paragraph WHERE DocumentName = :tDocName)
		
		if (tDocName="") || 'tMaxLevel {
			write "no document selected"
			quit
		}
		
		&html<<table class="doc"><tr>>
		for i = 1:1:tMaxLevel {
			&html<<th>&nbsp;</th>>
		}
		&html<<th>Text</th>>
		&html<<th>StartPos</th>>
		&html<<th>EndPos</th>>
		&html<</tr>>
		
		set tResult = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Demo_RulesBuilder.Paragraph WHERE DocumentName = :tDocName ORDER BY StartPos ASC")
		while tResult.%Next() {
			&html<<tr>>
			for i = 1:1:tMaxLevel {
				if i = tResult.%Get("Level") {
					&html<<td>>
					write tResult.%Get("Key")
					&html<</td>>
				} else {
					&html<<td>&nbsp;</td>>
				}
			}
			&html<<td>>
			write tResult.%Get("TextContents")
			&html<</td><td>>
			write tResult.%Get("StartPos")
			&html<</td><td>>
			write tResult.%Get("EndPos")
			&html<</td>>
			&html<</tr>>
		}
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// Default style for Zen pages
XData Style
{
<style type="text/css">
body {
	padding: 20px;
}

table.doc {
	border-spacing: 0px;
    border-collapse: collapse;
}
table.doc td,
table.doc td {
	border: 1px solid #777777;
}
</style>
}

}

