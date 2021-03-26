<!---
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 3-13-00
Date Modified: 4-19-00
Modifications Made:  Changed to reflect new AFR
Modified By: Gary Ashbaugh
Date Modified: 6-1-00
Modified By: Gary Ashbaugh
Modifications Made: Added Unit Name and Code to the top of form
Date Modified: 8-27-01
Modified By: Gary Ashbaugh
Modifications Made: Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

LOGIC: Pulls off data from the Indebtedness table to show a unformatted view of the Page F5 of the AFR

 --->
 <!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>
 
 <!--- pulls off fields for Indebtedness --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_IndebtednessInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetIndebtednessInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetIndebtednessInfoRetMsg">
	<cfprocresult name="GetIndebtednessInfo">
</cfstoredproc>
</cfoutput>

<cfif GetIndebtednessInfoRetVal is 0>
	<cfoutput>
	<cfset a400 = #iif(GetIndebtednessInfo.a400 is not "",NumberFormat(GetIndebtednessInfo.a400,"9999999999999999"),0)#>
	<cfset b400 = #iif(GetIndebtednessInfo.b400 is not "",NumberFormat(GetIndebtednessInfo.b400,"9999999999999999"),0)#>
	<cfset c400 = #iif(GetIndebtednessInfo.c400 is not "",NumberFormat(GetIndebtednessInfo.c400,"9999999999999999"),0)#>
	<cfset d400 = #iif(GetIndebtednessInfo.d400 is not "",NumberFormat(GetIndebtednessInfo.d400,"9999999999999999"),0)#>
	<cfset e400 = #iif(GetIndebtednessInfo.e400 is not "",NumberFormat(GetIndebtednessInfo.e400,"9999999999999999"),0)#>
	<cfset a401 = #iif(GetIndebtednessInfo.a401 is not "",NumberFormat(GetIndebtednessInfo.a401,"9999999999999999"),0)#>
	<cfset b401 = #iif(GetIndebtednessInfo.b401 is not "",NumberFormat(GetIndebtednessInfo.b401,"9999999999999999"),0)#>
	<cfset c401 = #iif(GetIndebtednessInfo.c401 is not "",NumberFormat(GetIndebtednessInfo.c401,"9999999999999999"),0)#>
	<cfset d401 = #iif(GetIndebtednessInfo.d401 is not "",NumberFormat(GetIndebtednessInfo.d401,"9999999999999999"),0)#>
	<cfset e401 = #iif(GetIndebtednessInfo.e401 is not "",NumberFormat(GetIndebtednessInfo.e401,"9999999999999999"),0)#>
	<cfset t402 = #iif(GetIndebtednessInfo.t402 is not "",NumberFormat(GetIndebtednessInfo.t402,"9999999999999999"),0)#>
	<cfset t403 = #iif(GetIndebtednessInfo.t403 is not "",NumberFormat(GetIndebtednessInfo.t403,"9999999999999999"),0)#>
	<cfset t404 = #iif(GetIndebtednessInfo.t404 is not "",NumberFormat(GetIndebtednessInfo.t404,"9999999999999999"),0)#>
	<cfset a406 = #iif(GetIndebtednessInfo.a406 is not "",NumberFormat(GetIndebtednessInfo.a406,"9999999999999999"),0)#>
	<cfset b406 = #iif(GetIndebtednessInfo.b406 is not "",NumberFormat(GetIndebtednessInfo.b406,"9999999999999999"),0)#>
	<cfset c406 = #iif(GetIndebtednessInfo.c406 is not "",NumberFormat(GetIndebtednessInfo.c406,"9999999999999999"),0)#>
	<cfset d406 = #iif(GetIndebtednessInfo.d406 is not "",NumberFormat(GetIndebtednessInfo.d406,"9999999999999999"),0)#>
	<cfset e406 = #iif(GetIndebtednessInfo.e406 is not "",NumberFormat(GetIndebtednessInfo.e406,"9999999999999999"),0)#>
	<cfset a407 = #iif(GetIndebtednessInfo.a407 is not "",NumberFormat(GetIndebtednessInfo.a407,"9999999999999999"),0)#>
	<cfset b407 = #iif(GetIndebtednessInfo.b407 is not "",NumberFormat(GetIndebtednessInfo.b407,"9999999999999999"),0)#>
	<cfset c407 = #iif(GetIndebtednessInfo.c407 is not "",NumberFormat(GetIndebtednessInfo.c407,"9999999999999999"),0)#>
	<cfset d407 = #iif(GetIndebtednessInfo.d407 is not "",NumberFormat(GetIndebtednessInfo.d407,"9999999999999999"),0)#>
	<cfset e407 = #iif(GetIndebtednessInfo.e407 is not "",NumberFormat(GetIndebtednessInfo.e407,"9999999999999999"),0)#>
	<cfset t408 = #iif(GetIndebtednessInfo.t408 is not "",NumberFormat(GetIndebtednessInfo.t408,"9999999999999999"),0)#>
	<cfset t409 = #iif(GetIndebtednessInfo.t409 is not "",NumberFormat(GetIndebtednessInfo.t409,"9999999999999999"),0)#>
	<cfset t410 = #iif(GetIndebtednessInfo.t410 is not "",NumberFormat(GetIndebtednessInfo.t410,"9999999999999999"),0)#>
	<cfset a412 = #iif(GetIndebtednessInfo.a412 is not "",NumberFormat(GetIndebtednessInfo.a412,"9999999999999999"),0)#>
	<cfset b412 = #iif(GetIndebtednessInfo.b412 is not "",NumberFormat(GetIndebtednessInfo.b412,"9999999999999999"),0)#>
	<cfset c412 = #iif(GetIndebtednessInfo.c412 is not "",NumberFormat(GetIndebtednessInfo.c412,"9999999999999999"),0)#>
	<cfset d412 = #iif(GetIndebtednessInfo.d412 is not "",NumberFormat(GetIndebtednessInfo.d412,"9999999999999999"),0)#>
	<cfset e412 = #iif(GetIndebtednessInfo.e412 is not "",NumberFormat(GetIndebtednessInfo.e412,"9999999999999999"),0)#>
	<cfset a413 = #iif(GetIndebtednessInfo.a413 is not "",NumberFormat(GetIndebtednessInfo.a413,"9999999999999999"),0)#>
	<cfset b413 = #iif(GetIndebtednessInfo.b413 is not "",NumberFormat(GetIndebtednessInfo.b413,"9999999999999999"),0)#>
	<cfset c413 = #iif(GetIndebtednessInfo.c413 is not "",NumberFormat(GetIndebtednessInfo.c413,"9999999999999999"),0)#>
	<cfset d413 = #iif(GetIndebtednessInfo.d413 is not "",NumberFormat(GetIndebtednessInfo.d413,"9999999999999999"),0)#>
	<cfset e413 = #iif(GetIndebtednessInfo.e413 is not "",NumberFormat(GetIndebtednessInfo.e413,"9999999999999999"),0)#>
	<cfset t414 = #iif(GetIndebtednessInfo.t414 is not "",NumberFormat(GetIndebtednessInfo.t414,"9999999999999999"),0)#>
	<cfset t415 = #iif(GetIndebtednessInfo.t415 is not "",NumberFormat(GetIndebtednessInfo.t415,"9999999999999999"),0)#>
	<cfset t416 = #iif(GetIndebtednessInfo.t416 is not "",NumberFormat(GetIndebtednessInfo.t416,"9999999999999999"),0)#>
	
	<cfset a418 = #LSParseNumber("#a400#")# + #LSParseNumber("#a406#")# - #LSParseNumber("#a412#")#>
	<cfset b418 = #LSParseNumber("#b400#")# + #LSParseNumber("#b406#")# - #LSParseNumber("#b412#")#>
	<cfset c418 = #LSParseNumber("#c400#")# + #LSParseNumber("#c406#")# - #LSParseNumber("#c412#")#>
	<cfset d418 = #LSParseNumber("#d400#")# + #LSParseNumber("#d406#")# - #LSParseNumber("#d412#")#>
	<cfset e418 = #LSParseNumber("#e400#")# + #LSParseNumber("#e406#")# - #LSParseNumber("#e412#")#>
	<cfset a419 = #LSParseNumber("#a401#")# + #LSParseNumber("#a407#")# - #LSParseNumber("#a413#")#>
	<cfset b419 = #LSParseNumber("#b401#")# + #LSParseNumber("#b407#")# - #LSParseNumber("#b413#")#>
	<cfset c419 = #LSParseNumber("#c401#")# + #LSParseNumber("#c407#")# - #LSParseNumber("#c413#")#>
	<cfset d419 = #LSParseNumber("#d401#")# + #LSParseNumber("#d407#")# - #LSParseNumber("#d413#")#>
	<cfset e419 = #LSParseNumber("#e401#")# + #LSParseNumber("#e407#")# - #LSParseNumber("#e413#")#>
	<cfset t420 = #LSParseNumber("#t402#")# + #LSParseNumber("#t408#")# - #LSParseNumber("#t414#")#>
	<cfset t421 = #LSParseNumber("#t403#")# + #LSParseNumber("#t409#")# - #LSParseNumber("#t415#")#>
	<cfset t422 = #LSParseNumber("#t404#")# + #LSParseNumber("#t410#")# - #LSParseNumber("#t416#")#>
    
    <cfset a424 = #iif(GetIndebtednessInfo.a424 is not "",NumberFormat(GetIndebtednessInfo.a424,"9999999999999999"),0)#>
	<cfset b424 = #iif(GetIndebtednessInfo.b424 is not "",NumberFormat(GetIndebtednessInfo.b424,"9999999999999999"),0)#>
	<cfset c424 = #iif(GetIndebtednessInfo.c424 is not "",NumberFormat(GetIndebtednessInfo.c424,"9999999999999999"),0)#>
	<cfset d424 = #iif(GetIndebtednessInfo.d424 is not "",NumberFormat(GetIndebtednessInfo.d424,"9999999999999999"),0)#>
	<cfset e424 = #iif(GetIndebtednessInfo.e424 is not "",NumberFormat(GetIndebtednessInfo.e424,"9999999999999999"),0)#>
    <cfset a425 = #iif(GetIndebtednessInfo.a425 is not "",NumberFormat(GetIndebtednessInfo.a425,"9999999999999999"),0)#>
	<cfset b425 = #iif(GetIndebtednessInfo.b425 is not "",NumberFormat(GetIndebtednessInfo.b425,"9999999999999999"),0)#>
	<cfset c425 = #iif(GetIndebtednessInfo.c425 is not "",NumberFormat(GetIndebtednessInfo.c425,"9999999999999999"),0)#>
	<cfset d425 = #iif(GetIndebtednessInfo.d425 is not "",NumberFormat(GetIndebtednessInfo.d425,"9999999999999999"),0)#>
	<cfset e425 = #iif(GetIndebtednessInfo.e425 is not "",NumberFormat(GetIndebtednessInfo.e425,"9999999999999999"),0)#>
    <cfset t426 = #iif(GetIndebtednessInfo.t426 is not "",NumberFormat(GetIndebtednessInfo.t426,"9999999999999999"),0)#>
	<cfset t427 = #iif(GetIndebtednessInfo.t427 is not "",NumberFormat(GetIndebtednessInfo.t427,"9999999999999999"),0)#>
	<cfset t428 = #iif(GetIndebtednessInfo.t428 is not "",NumberFormat(GetIndebtednessInfo.t428,"9999999999999999"),0)#>
    
    <cfset a430 = #GetIndebtednessInfo.a430#>
	<cfset b430 = #GetIndebtednessInfo.b430#>
	<cfset c430 = #GetIndebtednessInfo.c430#>
	<cfset d430 = #GetIndebtednessInfo.d430#>
	<cfset e430 = #GetIndebtednessInfo.e430#>
    <cfset a431 = #GetIndebtednessInfo.a431#>
	<cfset b431 = #GetIndebtednessInfo.b431#>
	<cfset c431 = #GetIndebtednessInfo.c431#>
	<cfset d431 = #GetIndebtednessInfo.d431#>
	<cfset e431 = #GetIndebtednessInfo.e431#>
    <cfset t432 = #GetIndebtednessInfo.t432#>
	<cfset t433 = #GetIndebtednessInfo.t433#>
	<cfset t434 = #GetIndebtednessInfo.t434#>
    
    <cfset a436 = #iif(GetIndebtednessInfo.a436 is not "",NumberFormat(GetIndebtednessInfo.a436,"9999999999999.99"),0.00)#>
	<cfset b436 = #iif(GetIndebtednessInfo.b436 is not "",NumberFormat(GetIndebtednessInfo.b436,"9999999999999.99"),0.00)#>
	<cfset c436 = #iif(GetIndebtednessInfo.c436 is not "",NumberFormat(GetIndebtednessInfo.c436,"9999999999999.99"),0.00)#>
	<cfset d436 = #iif(GetIndebtednessInfo.d436 is not "",NumberFormat(GetIndebtednessInfo.d436,"9999999999999.99"),0.00)#>
	<cfset e436 = #iif(GetIndebtednessInfo.e436 is not "",NumberFormat(GetIndebtednessInfo.e436,"9999999999999.99"),0.00)#>
    <cfset a437 = #iif(GetIndebtednessInfo.a437 is not "",NumberFormat(GetIndebtednessInfo.a437,"9999999999999.99"),0.00)#>
	<cfset b437 = #iif(GetIndebtednessInfo.b437 is not "",NumberFormat(GetIndebtednessInfo.b437,"9999999999999.99"),0.00)#>
	<cfset c437 = #iif(GetIndebtednessInfo.c437 is not "",NumberFormat(GetIndebtednessInfo.c437,"9999999999999.99"),0.00)#>
	<cfset d437 = #iif(GetIndebtednessInfo.d437 is not "",NumberFormat(GetIndebtednessInfo.d437,"9999999999999.99"),0.00)#>
	<cfset e437 = #iif(GetIndebtednessInfo.e437 is not "",NumberFormat(GetIndebtednessInfo.e437,"9999999999999.99"),0.00)#>
    <cfset t438 = #iif(GetIndebtednessInfo.t438 is not "",NumberFormat(GetIndebtednessInfo.t438,"9999999999999.99"),0.00)#>
	<cfset t439 = #iif(GetIndebtednessInfo.t439 is not "",NumberFormat(GetIndebtednessInfo.t439,"9999999999999.99"),0.00)#>
	<cfset t440 = #iif(GetIndebtednessInfo.t440 is not "",NumberFormat(GetIndebtednessInfo.t440,"9999999999999.99"),0.00)#>
    
    <cfset a442 = #iif(GetIndebtednessInfo.a442 is not "",NumberFormat(GetIndebtednessInfo.a442,"9999999999999.99"),0.00)#>
	<cfset b442 = #iif(GetIndebtednessInfo.b442 is not "",NumberFormat(GetIndebtednessInfo.b442,"9999999999999.99"),0.00)#>
	<cfset c442 = #iif(GetIndebtednessInfo.c442 is not "",NumberFormat(GetIndebtednessInfo.c442,"9999999999999.99"),0.00)#>
	<cfset d442 = #iif(GetIndebtednessInfo.d442 is not "",NumberFormat(GetIndebtednessInfo.d442,"9999999999999.99"),0.00)#>
	<cfset e442 = #iif(GetIndebtednessInfo.e442 is not "",NumberFormat(GetIndebtednessInfo.e442,"9999999999999.99"),0.00)#>
    <cfset a443 = #iif(GetIndebtednessInfo.a443 is not "",NumberFormat(GetIndebtednessInfo.a443,"9999999999999.99"),0.00)#>
	<cfset b443 = #iif(GetIndebtednessInfo.b443 is not "",NumberFormat(GetIndebtednessInfo.b443,"9999999999999.99"),0.00)#>
	<cfset c443 = #iif(GetIndebtednessInfo.c443 is not "",NumberFormat(GetIndebtednessInfo.c443,"9999999999999.99"),0.00)#>
	<cfset d443 = #iif(GetIndebtednessInfo.d443 is not "",NumberFormat(GetIndebtednessInfo.d443,"9999999999999.99"),0.00)#>
	<cfset e443 = #iif(GetIndebtednessInfo.e443 is not "",NumberFormat(GetIndebtednessInfo.e443,"9999999999999.99"),0.00)#>
    <cfset t444 = #iif(GetIndebtednessInfo.t444 is not "",NumberFormat(GetIndebtednessInfo.t444,"9999999999999.99"),0.00)#>
	<cfset t445 = #iif(GetIndebtednessInfo.t445 is not "",NumberFormat(GetIndebtednessInfo.t445,"9999999999999.99"),0.00)#>
	<cfset t446 = #iif(GetIndebtednessInfo.t446 is not "",NumberFormat(GetIndebtednessInfo.t446,"9999999999999.99"),0.00)#>	
	</cfoutput>
<cfelse>
	<cfset a400 = 0>
	<cfset b400 = 0>
	<cfset c400 = 0>
	<cfset d400 = 0>
	<cfset e400 = 0>
	<cfset a401 = 0>
	<cfset b401 = 0>
	<cfset c401 = 0>
	<cfset d401 = 0>
	<cfset e401 = 0>
	<cfset t402 = 0>
	<cfset t403 = 0>
	<cfset t404 = 0>
	<cfset a406 = 0>
	<cfset b406 = 0>
	<cfset c406 = 0>
	<cfset d406 = 0>
	<cfset e406 = 0>
	<cfset a407 = 0>
	<cfset b407 = 0>
	<cfset c407 = 0>
	<cfset d407 = 0>
	<cfset e407 = 0>
	<cfset t408 = 0>
	<cfset t409 = 0>
	<cfset t410 = 0>
	<cfset a412 = 0>
	<cfset b412 = 0>
	<cfset c412 = 0>
	<cfset d412 = 0>
	<cfset e412 = 0>
	<cfset a413 = 0>
	<cfset b413 = 0>
	<cfset c413 = 0>
	<cfset d413 = 0>
	<cfset e413 = 0>
	<cfset t414 = 0>
	<cfset t415 = 0>
	<cfset t416 = 0>
	<cfset a418 = 0>
	<cfset b418 = 0>
	<cfset c418 = 0>
	<cfset d418 = 0>
	<cfset e418 = 0>
	<cfset a419 = 0>
	<cfset b419 = 0>
	<cfset c419 = 0>
	<cfset d419 = 0>
	<cfset e419 = 0>
	<cfset t420 = 0>
	<cfset t421 = 0>
	<cfset t422 = 0>
    
    <cfset a424 = 0>
	<cfset b424 = 0>
	<cfset c424 = 0>
	<cfset d424 = 0>
	<cfset e424 = 0>
    <cfset a425 = 0>
	<cfset b425 = 0>
	<cfset c425 = 0>
	<cfset d425 = 0>
	<cfset e425 = 0>
    <cfset t426 = 0>
	<cfset t427 = 0>
	<cfset t428 = 0>
    
    <cfset a430 = "">
	<cfset b430 = "">
	<cfset c430 = "">
	<cfset d430 = "">
	<cfset e430 = "">
    <cfset a431 = "">
	<cfset b431 = "">
	<cfset c431 = "">
	<cfset d431 = "">
	<cfset e431 = "">
    <cfset t432 = "">
	<cfset t433 = "">
	<cfset t434 = "">
    
    <cfset a436 = 0.00>
	<cfset b436 = 0.00>
	<cfset c436 = 0.00>
	<cfset d436 = 0.00>
	<cfset e436 = 0.00>
    <cfset a437 = 0.00>
	<cfset b437 = 0.00>
	<cfset c437 = 0.00>
	<cfset d437 = 0.00>
	<cfset e437 = 0.00>
    <cfset t438 = 0.00>
	<cfset t439 = 0.00>
	<cfset t440 = 0.00>
    
    <cfset a442 = 0.00>
	<cfset b442 = 0.00>
	<cfset c442 = 0.00>
	<cfset d442 = 0.00>
	<cfset e442 = 0.00>
    <cfset a443 = 0.00>
	<cfset b443 = 0.00>
	<cfset c443 = 0.00>
	<cfset d443 = 0.00>
	<cfset e443 = 0.00>
    <cfset t444 = 0.00>
	<cfset t445 = 0.00>
	<cfset t446 = 0.00>
</cfif>
 
<cfset url.PageType="AFR">
<cfset url.PageName="Indebtedness">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5 class="clearfix">
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2015/MPFReport/AFRMPPgF7.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F7" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h5>

<div class="table-responsive">
<table class="table table-bordered">
    <tr><td colspan="13" align="center"><b>Statement of Indebtedness (Governmental and Propriety)</b></td></tr>
		<tr><td align="center" valign="top"><b>Debt Instruments for All Funds</b></td><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Outstanding Beginning of Year</b></td><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Issued Current Fiscal Year</b></td><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Retired Current Fiscal Year</b></td><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Outstanding End of Year</b></td><td align="center" valign="top"><b>Original Issue Amount</b></td><td align="center" valign="top"><b>Final Maturity Date</b></td><td align="center" valign="top"><b>Interest Rate Ranges -  Lowest</b></td><td align="center" valign="top"><b>Interest Rate Ranges -  Highest</b></td></tr>
		<tr><td colspan="13" valign="top" align="center">Report in Whole Numbers</td></tr>
		<cfoutput>
			<tr>
			<td><b>General Obligation Bonds</b></td>
			<td><b>400</b></td><td align="right">#NumberFormat((a400 + b400 + c400 + d400 + e400))#</td>
			<td><b>406</b></td><td align="right">#NumberFormat((a406 + b406 + c406 + d406 + e406))#</td>
			<td><b>412</b></td><td align="right">#NumberFormat((a412 + b412 + c412 + d412 + e412))#</td>
			<td><b>418</b></td><td align="right">#NumberFormat((a418 + b418 + c418 + d418 + e418))#</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
			</tr>
			<tr>
			<td>Water</td>
			<td><b>400a</b></td><td align="right">#NumberFormat(a400)#</td>
			<td><b>406a</b></td><td align="right">#NumberFormat(a406)#</td>
			<td><b>412a</b></td><td align="right">#NumberFormat(a412)#</td>
			<td><b>418a</b></td><td align="right">#NumberFormat(a418)#</td>
            <td align="right">#NumberFormat(a424,"9999999999999999")#</td>
            <td align="right">#DateFormat(a430,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(a436,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(a442,"9999999999999.99")#</td>
			</tr>
			<tr>
			<td>Electric</td>
			<td><b>400b</b></td><td align="right">#NumberFormat(b400)#</td>
			<td><b>406b</b></td><td align="right">#NumberFormat(b406)#</td>
			<td><b>412b</b></td><td align="right">#NumberFormat(b412)#</td>
			<td><b>418b</b></td><td align="right">#NumberFormat(b418)#</td>
            <td align="right">#NumberFormat(b424,"9999999999999999")#</td>
            <td align="right">#DateFormat(b430,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(b436,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(b442,"9999999999999.99")#</td>
			</tr>
			<tr>
			<td>Transportation</td>
			<td><b>400c</b></td><td align="right">#NumberFormat(c400)#</td>
			<td><b>406c</b></td><td align="right">#NumberFormat(c406)#</td>
			<td><b>412c</b></td><td align="right">#NumberFormat(c412)#</td>
			<td><b>418c</b></td><td align="right">#NumberFormat(c418)#</td>
            <td align="right">#NumberFormat(c424,"9999999999999999")#</td>
            <td align="right">#DateFormat(c430,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(c436,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(c442,"9999999999999.99")#</td>
			</tr>
			<tr>
			<td>Housing</td>
			<td><b>400d</b></td><td align="right">#NumberFormat(d400)#</td>
			<td><b>406d</b></td><td align="right">#NumberFormat(d406)#</td>
			<td><b>412d</b></td><td align="right">#NumberFormat(d412)#</td>
			<td><b>418d</b></td><td align="right">#NumberFormat(d418)#</td>
            <td align="right">#NumberFormat(d424,"9999999999999999")#</td>
            <td align="right">#DateFormat(d430,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(d436,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(d442,"9999999999999.99")#</td>
			</tr>
			<tr>
			<td>Other (Explain)</td>
			<td><b>400e</b></td><td align="right">#NumberFormat(e400)#</td>
			<td><b>406e</b></td><td align="right">#NumberFormat(e406)#</td>
			<td><b>412e</b></td><td align="right">#NumberFormat(e412)#</td>
			<td><b>418e</b></td><td align="right">#NumberFormat(e418)#</td>
			<td align="right">#NumberFormat(e424,"9999999999999999")#</td>
            <td align="right">#DateFormat(e430,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(e436,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(e442,"9999999999999.99")#</td>
            </tr>
			<tr>
			<td><b>Revenue Bonds</b></td>
			<td><b>401</b></td><td align="right">#NumberFormat((a401 + b401 + c401 + d401 + e401))#</td>
			<td><b>407</b></td><td align="right">#NumberFormat((a407 + b407 + c407 + d407 + e407))#</td>
			<td><b>413</b></td><td align="right">#NumberFormat((a413 + b413 + c413 + d413 + e413))#</td>
			<td><b>419</b></td><td align="right">#NumberFormat((a419 + b419 + c419 + d419 + e419))#</td>
			<td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>
			<tr>
			<td>Water</td>
			<td><b>401a</b></td><td align="right">#NumberFormat(a401)#</td>
			<td><b>407a</b></td><td align="right">#NumberFormat(a407)#</td>
			<td><b>413a</b></td><td align="right">#NumberFormat(a413)#</td>
			<td><b>419a</b></td><td align="right">#NumberFormat(a419)#</td>
            <td align="right">#NumberFormat(a425,"9999999999999999")#</td>
            <td align="right">#DateFormat(a431,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(a437,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(a443,"9999999999999.99")#</td>
			</tr>
			<tr>
			<td>Electric</td>
			<td><b>401b</b></td><td align="right">#NumberFormat(b401)#</td>
			<td><b>407b</b></td><td align="right">#NumberFormat(b407)#</td>
			<td><b>413b</b></td><td align="right">#NumberFormat(b413)#</td>
			<td><b>419b</b></td><td align="right">#NumberFormat(b419)#</td>
            <td align="right">#NumberFormat(b425,"9999999999999999")#</td>
            <td align="right">#DateFormat(b431,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(b437,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(b443,"9999999999999.99")#</td>
            </tr>
			<tr>
			<td>Transportation</td>
			<td><b>401c</b></td><td align="right">#NumberFormat(c401)#</td>
			<td><b>407c</b></td><td align="right">#NumberFormat(c407)#</td>
			<td><b>413c</b></td><td align="right">#NumberFormat(c413)#</td>
			<td><b>419c</b></td><td align="right">#NumberFormat(c419)#</td>
			<td align="right">#NumberFormat(c425,"9999999999999999")#</td>
            <td align="right">#DateFormat(c431,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(c437,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(c443,"9999999999999.99")#</td>
            </tr>
			<tr>
			<td>Housing</td>
			<td><b>401d</b></td><td align="right">#NumberFormat(d401)#</td>
			<td><b>407d</b></td><td align="right">#NumberFormat(d407)#</td>
			<td><b>413d</b></td><td align="right">#NumberFormat(d413)#</td>
			<td><b>419d</b></td><td align="right">#NumberFormat(d419)#</td>
			<td align="right">#NumberFormat(d425,"9999999999999999")#</td>
            <td align="right">#DateFormat(d431,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(d437,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(d443,"9999999999999.99")#</td>
            </tr>
			<tr>
			<td>Other (Explain)</td>
			<td><b>401e</b></td><td align="right">#NumberFormat(e401)#</td>
			<td><b>407e</b></td><td align="right">#NumberFormat(e407)#</td>
			<td><b>413e</b></td><td align="right">#NumberFormat(e413)#</td>
			<td><b>419e</b></td><td align="right">#NumberFormat(e419)#</td>
			<td align="right">#NumberFormat(e425,"9999999999999999")#</td>
            <td align="right">#DateFormat(e431,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(e437,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(e443,"9999999999999.99")#</td>
            </tr>
			<tr>
			<td><b>Alternate Revenue Bonds</b></td>
			<td><b>402</b></td><td align="right">#NumberFormat(t402)#</td>
			<td><b>408</b></td><td align="right">#NumberFormat(t408)#</td>
			<td><b>414</b></td><td align="right">#NumberFormat(t414)#</td>
			<td><b>420</b></td><td align="right">#NumberFormat(t420)#</td>
			<td align="right">#NumberFormat(t426,"9999999999999999")#</td>
            <td align="right">#DateFormat(t432,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(t438,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(t444,"9999999999999.99")#</td>
            </tr>
			<tr>
			<td><b>Contractual Commitments</b></td>
			<td><b>403</b></td><td align="right">#NumberFormat(t403)#</td>
			<td><b>409</b></td><td align="right">#NumberFormat(t409)#</td>
			<td><b>415</b></td><td align="right">#NumberFormat(t415)#</td>
			<td><b>421</b></td><td align="right">#NumberFormat(t421)#</td>	
			<td align="right">#NumberFormat(t427,"9999999999999999")#</td>
            <td align="right">#DateFormat(t433,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(t439,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(t445,"9999999999999.99")#</td>
            </tr>
			<tr>
			<td><b>Other (Explain)</b></td>
			<td><b>404</b></td><td align="right">#NumberFormat(t404)#</td>
			<td><b>410</b></td><td align="right">#NumberFormat(t410)#</td>
			<td><b>416</b></td><td align="right">#NumberFormat(t416)#</td>
			<td><b>422</b></td><td align="right">#NumberFormat(t422)#</td>
			<td align="right">#NumberFormat(t428,"9999999999999999")#</td>
            <td align="right">#DateFormat(t434,"MM/DD/YYYY")#</td>
            <td align="right">#NumberFormat(t440,"9999999999999.99")#</td>
            <td align="right">#NumberFormat(t446,"9999999999999.99")#</td>
            </tr>
            <tr>
			<td><b>Total Debt</b></td>
			<td><b>405</b></td><td align="right">#NumberFormat((a400 + b400 + c400 + d400 + e400 + a401 + b401 + c401 + d401 + e401 + t402 + t403 + t404))#</td>
			<td><b>411</b></td><td align="right">#NumberFormat((a406 + b406 + c406 + d406 + e406 + a407 + b407 + c407 + d407 + e407 + t408 + t409 + t410))#</td>
			<td><b>417</b></td><td align="right">#NumberFormat((a412 + b412 + c412 + d412 + e412 + a413 + b413 + c413 + d413 + e413 + t414 + t415 + t416))#</td>
			<td><b>423</b></td><td align="right">#NumberFormat((a418 + b418 + c418 + d418 + e418 + a419 + b419 + c419 + d419 + e419 + t420 + t421 + t422))#</td>
			<td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>
		</cfoutput>
		</table>       
      </div>
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm">  --->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Multi-Purpose Form - F7</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>

</cflock>
