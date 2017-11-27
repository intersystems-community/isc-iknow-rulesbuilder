Class Demo.RulesBuilder.Utils
{

ClassMethod LoadDocument(pDocumentName As %String, pDomainId As %Integer, Output vSrcIDs) As %Status
{
	set tSC = $$$OK
	try {
		kill vSrcIDs
		set tDomainName = $system.iKnow.GetDomainName(pDomainId)
		
		
		// first drop old sources
		set tRS = ##class(%SQL.Statement).%ExecDirect(,"SELECT SourceId, ExternalId FROM %iKnow_Objects.VirtualSource WHERE DomainId = "_pDomainId_" AND ExternalId LIKE ':SQL:"_$replace(pDocumentName,"'","''")_":%'")
		while tRS.%Next() {
			set tSC = ##class(%iKnow.Source.Loader).DeleteVirtualSource(pDomainId, tRS.%Get("SourceId"))
			quit:$$$ISERR(tSC)
		}
		quit:$$$ISERR(tSC)
		
		
		// index new records and match through the classic way (to load multiple virtual sources at once)
		set tLoader = ##class(%iKnow.Source.Loader).%New(pDomainId)
		set tLister = ##class(%iKnow.Source.SQL.Lister).%New(pDomainId)
		set tSC = tLister.ProcessVirtualList("SELECT * FROM Demo_RulesBuilder.Paragraph WHERE FullTextContents != ''", "ID", "DocumentName", "FullTextContents")
		quit:$$$ISERR(tSC)
		set tList = tLoader.GetSourceIds()
		
		set ptr=0
		while $listnext(tList,ptr,vSrcID) {
			set tSC = ##class(%iKnow.Matching.MatchingAPI).MatchSource(pDomainId, -vSrcID)
			quit:$$$ISERR(tSC)
			set vSrcIDs(-vSrcID) = $piece(##class(%iKnow.Objects.VirtualSource).PKINDEXOpen(pDomainId, vSrcID).ExternalId,":",*)
		}
		
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

ClassMethod GetDocumentName(pDomainId As %Integer, pSourceId As %Integer) As %String
{
	if (pSourceId<0) {
		quit $piece(##class(%iKnow.Objects.VirtualSource).PKINDEXOpen(pDomainId,$zabs(pSourceId)).ExternalId,":",3)
	}
	set tFieldId = ##class(%iKnow.Queries.MetadataAPI).GetFieldId(pDomainId, "DocumentName")
	quit:'tFieldId ""
	quit ##class(%iKnow.Queries.MetadataAPI).GetValueById(pDomainId, tFieldId, pSourceId)
}

ClassMethod CreateRestWebApp(ByRef pWebAppName As %String = "") As %Status
{
	set tSC = $$$OK, tCreated=0, tCurrentNS = $$$LOWER($namespace)
	try {
		set:pWebAppName="" pWebAppName = "/csp/"_tCurrentNS_"/rbREST/"
		set tProperties("NameSpace") = tCurrentNS
		set tProperties("DispatchClass") = "Demo.RulesBuilder.RestHandler"
		set tProperties("AutheEnabled") = $$$AutheUnauthenticated
		//set tProperties("iKnowEnabled") = 1
		
		zn "%SYS"
		if '##class(Security.Applications).Exists(pWebAppName) {
			set tSC = ##class(Security.Applications).Create(pWebAppName, .tProperties)
			quit:$$$ISERR(tSC)
			set tCreated=1
		}
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	zn tCurrentNS
	
	if $$$ISERR(tSC) {
		write !,"WARNING: unable to create web application due to the following error:",!
		do $system.OBJ.DisplayError(tSC)
		write !,"You'll still have to create a web application '",pWebAppName,"' referring to Demo.RulesBuilder.RestHandler",!
	} elseif (tCreated) {
		write !,"Web Application '"_pWebAppName_"' created successfully",!
	}
	
	quit $$$OK
}

}

