<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 3-13-00
Date Modified: 4-18-00
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

LOGIC: Pulls off data from the Expenditures table to show a unformatted view of the Page F3 of the AFR

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
 
 <!--- pulls off fields for Expenditures --->
 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryMPPgF4Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryMPPgF4RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryMPPgF4RptRetMsg">
	<cfprocresult name="GetExpCategoryMPPgF4Rpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryMPPgF5Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryMPPgF5RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryMPPgF5RptRetMsg">
	<cfprocresult name="GetExpCategoryMPPgF5Rpt">
</cfstoredproc>
</cfoutput>

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpMPPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpPerctRptRetMsg">
	<cfprocresult name="GetExpPerctRpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotExpenditure">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotExpenditureRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotExpenditureRetMsg">
	<cfprocresult name="GetTotExpenditure">
</cfstoredproc>
</cfoutput>
 
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Expenditures">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h3><a href="#PercAmt">View Percentages for Expenditures</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/MPFReport/AFRMPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F4-F5" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<center><font size="-1"><b>Disbursements, Expenditures and Expenses</b>&nbsp;</font></center>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<tr><td <!--- bgcolor="silver" ---> valign="top" align="center"><font size="-1"><b>Code</b>&nbsp;</font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>General</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Special<br>Revenue</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Capital<br>Project</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Debt<br>Service</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Enterprise</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Internal<br>Service</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Fiduciary</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Discretely<br>Presented<br>Component<br>Units</b>&nbsp;</font></td></tr>
		<cfoutput query="GetExpCategoryMPPgF4Rpt">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t">
			<tr><td Colspan=10><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "251a" or #Category1# is "251b" or #Category1# is "251c" or #Category1# is "251d">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "252t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "252a" or #Category1# is "252b" or #Category1# is "252c" or #Category1# is "252d">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "253t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "254t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "255t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "255a" or #Category1# is "255b" or #Category1# is "255c" or #Category1# is "255d" or #Category1# is "255e">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "256t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "256a" or #Category1# is "256b" or #Category1# is "256c" or #Category1# is "256d" or #Category1# is "256e">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "257t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "257a" or #Category1# is "257b" or #Category1# is "257c">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "258t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "275t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "275a" or #Category1# is "275b" or #Category1# is "275c">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "259t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "259a" or #Category1# is "259b">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "271t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "271a" or #Category1# is "271b" or #Category1# is "271c" or #Category1# is "271d">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "272t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "260t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "270t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelse>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
        <cfoutput query="GetExpCategoryMPPgF5Rpt">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t">
			<tr><td Colspan=10><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "251a" or #Category1# is "251b" or #Category1# is "251c" or #Category1# is "251d">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "252t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "252a" or #Category1# is "252b" or #Category1# is "252c" or #Category1# is "252d">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "253t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "254t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "255t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "255a" or #Category1# is "255b" or #Category1# is "255c" or #Category1# is "255d" or #Category1# is "255e">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "256t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "256a" or #Category1# is "256b" or #Category1# is "256c" or #Category1# is "256d" or #Category1# is "256e">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "257t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "257a" or #Category1# is "257b" or #Category1# is "257c">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "258t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "275t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "275a" or #Category1# is "275b" or #Category1# is "275c">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "259t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "259a" or #Category1# is "259b">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "271t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "271a" or #Category1# is "271b" or #Category1# is "271c" or #Category1# is "271d">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1">#DispDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "272t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "260t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>270t</b></td><td><font size="-1"><b>Total Expenditures/Expense</b></font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotExpenditure.TotExpGN is not "",NumberFormat(GetTotExpenditure.TotExpGN,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotExpenditure.TotExpSR is not "",NumberFormat(GetTotExpenditure.TotExpSR,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotExpenditure.TotExpCP is not "",NumberFormat(GetTotExpenditure.TotExpCP,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotExpenditure.TotExpDS is not "",NumberFormat(GetTotExpenditure.TotExpDS,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotExpenditure.TotExpEP is not "",NumberFormat(GetTotExpenditure.TotExpEP,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotExpenditure.TotExpTS is not "",NumberFormat(GetTotExpenditure.TotExpTS,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotExpenditure.TotExpFD is not "",NumberFormat(GetTotExpenditure.TotExpFD,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotExpenditure.TotExpDP is not "",NumberFormat(GetTotExpenditure.TotExpDP,"9999999999999999"),0))#</font></td>
			</tr>
		<cfelse>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><b>#DispDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
        <!--- Added per SR13016 --->
         <a name="PercAmt"><br><br></a>
        <table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
        <tr><td  bgcolor="silver" >Expenditures</td><td  bgcolor="silver" >Percentages</td></tr>
        <cfoutput query="GetExpPerctRpt">
		<tr><td align="left"><font size="-1">#DispDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        </table>
		<br>
        
        <!---<p align="right"><font size="-1">F4&nbsp;</font></right>
		<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Multi-Purpose Form&nbsp;</font></center>
 <br><br>--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
        <div align="center">
        <table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="90%">
        <tr><Td width="30%">&nbsp;</Td>
        <td width="5%">&nbsp;</td>
        <td width="30%"><center>#url.AFRDesiredData#</center></td>
        <td width="5%">&nbsp;</td>
        <td width="20%">#url.CFY# Multi-Purpose Form - F4-F5</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
