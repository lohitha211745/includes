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
Date Modified: 4-3-01
Modified By: Gary Ashbaugh
Modifications Made:  Changed Selection criteria to include url.CFY criteria instead of just CFY
Date Modified: 8-27-01
Modified By: Gary Ashbaugh
Modifications Made: Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

LOGIC: Pulls off data from the Revenues table to show a unformatted view of the Page F2 of the AFR

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
 
 <!--- pulls off fields for Revenues --->
 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategoryMPPgF2Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategoryMPPgF2RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategoryMPPgF2RptRetMsg">
	<cfprocresult name="GetRevCategoryMPPgF2Rpt">
</cfstoredproc>
</cfoutput>

 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategoryMPPgF3Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategoryMPPgF3RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategoryMPPgF3RptRetMsg">
	<cfprocresult name="GetRevCategoryMPPgF3Rpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotRevenue">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotRevenueRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotRevenueRptRetMsg">
	<cfprocresult name="GetTotRevenue">
</cfstoredproc>
</cfoutput>

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevMPPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevPerctRptRetMsg">
	<cfprocresult name="GetRevPerctRpt">
</cfstoredproc>
</cfoutput>
 
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Revenues">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h3><a href="#PercAmt">View Percentages for Revenues</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/MPFReport/AFRMPPgF2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F2-F3" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<center><font size="-1"><b>Revenues and Receipts</b>&nbsp;</font></center>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<tr><td <!--- bgcolor="silver" ---> valign="top" align="center"><font size="-1"><b>Code</b>&nbsp;</font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>General</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Special<br>Revenue</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Capital<br>Project</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Debt<br>Service</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Enterprise</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Internal<br>Service</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Fiduciary</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Discretely<br>Presented<br>Component<br>Units</b>&nbsp;</font></td></tr>
		<cfoutput query="GetRevCategoryMPPgF2Rpt">
		<Cfset Category1=Left(RevenueID, 4)>
		<cfif #Category1# is "201t">
			<tr><td Colspan=10><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Local Taxes</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "202t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "203t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "203a" or #Category1# is "203b" or #Category1# is "203c" or #Category1# is "203d">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1">#RevenueDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "211t">
			<tr><td Colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1"><b>Intergovernmental Receipts & Grants</b>&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "212t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "213t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(0)#&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "214t" or #Category1# is "205t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "215t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "215a" or #Category1# is "215b" or #Category1# is "215c" or #Category1# is "215d" or #Category1# is "215e" or #Category1# is "215f" or #Category1# is "215g" or #Category1# is "215h" or #Category1# is "215i" or #Category1# is "215j">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1">#RevenueDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "225t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "225a" or #Category1# is "225b" or #Category1# is "225c" or #Category1# is "225d" or #Category1# is "225e" or #Category1# is "225f" or #Category1# is "225g">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1">#RevenueDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "226t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelse>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
        <cfoutput query="GetRevCategoryMPPgF3Rpt">
		<Cfset Category1=Left(RevenueID, 4)>
		
		<cfif #Category1# is "225h" or #Category1# is "225i" or #Category1# is "225j">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1">#RevenueDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "226t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "231t">
			<tr><td Colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1"><b>Other Sources</b>&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "233t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "234t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(SR)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(CP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(EP)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(TS)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(FD)#&nbsp;</td><td align="right" bgcolor="gray">#NumberFormat(DP)#&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "234a" or #Category1# is "234b" or #Category1# is "234c" or #Category1# is "234d" or #Category1# is "234e" or #Category1# is "234f" or #Category1# is "234g" or #Category1# is "234h" or #Category1# is "234i" or #Category1# is "234j" or #Category1# is "234k">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1">#RevenueDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "235t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "236t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>240t</b>&nbsp;</font></td><td><font size="-1"><b>Total Receipts and Revenue</b></font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotRevenue.TotRevGN is not "",NumberFormat(GetTotRevenue.TotRevGN,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotRevenue.TotRevSR is not "",NumberFormat(GetTotRevenue.TotRevSR,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotRevenue.TotRevCP is not "",NumberFormat(GetTotRevenue.TotRevCP,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotRevenue.TotRevDS is not "",NumberFormat(GetTotRevenue.TotRevDS,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotRevenue.TotRevEP is not "",NumberFormat(GetTotRevenue.TotRevEP,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotRevenue.TotRevTS is not "",NumberFormat(GetTotRevenue.TotRevTS,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotRevenue.TotRevFD is not "",NumberFormat(GetTotRevenue.TotRevFD,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">&nbsp;#Numberformat(IIF (GetTotRevenue.TotRevDP is not "",NumberFormat(GetTotRevenue.TotRevDP,"9999999999999999"),0))#</font></td>
			</tr>
		<cfelse>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#RevenueID#</b>&nbsp;</font></td><td><font size="-1"><b>#RevenueDescription#</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
        <!--- Added per SR13016 --->
         <a name="PercAmt"><br><br></a>
        <table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
        <tr><td  bgcolor="silver" >Revenues</td><td  bgcolor="silver" >Percentages</td></tr>
        <cfoutput query="GetRevPerctRpt">
		<tr><td align="left"><font size="-1">#RevenueDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        </table>
		<br>
        
        <!---<p align="right"><font size="-1">F2 and F3&nbsp;</font></right>
		<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Multi-Purpose Form&nbsp;</font></center>
 <br><br>--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MP">
    	<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
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
        <td width="20%">#url.CFY# Multi-Purpose Form - F2-F3</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
