<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 6-13-00
Modified By: Gary Ashbaugh
Modifications Made:  Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 8-27-01
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Page 4 of the AFR

 --->
 


 
<!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>
  
<!---<html>
<head>
	<title>AFR - Page 4</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Payments to Other Governments">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span><font size="-1" color="black">STEP 7:  OTHER GOVERNMENTS</FONT>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/MPFReport/AFRMPPg4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=4" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<font size="-1"><b>Indicate any payments <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> made to other governments for services or programs (include programs performed on a reimbursement, cost-sharing basis or federal payroll taxes).</font></b><br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<cfoutput query="GetAFRRptPg1">
<tr><td width="75%" align="left"><font size="-1">Intergovernmental agreements - indicate how much was paid</font></td><td width="25%" align="right"><font size="-1">#NumberFormat(AmtState,"$9,999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1">Federal government payroll taxes</font></td><td width="25%" align="right"><font size="-1">#NumberFormat(AmtFederal,"$9,999,999,999,999,999")#</font>&nbsp;</td></tr>
<tr><td width="75%" align="left"><font size="-1">All other intergovernmental payments</font></td><td width="25%" align="right"><font size="-1">#NumberFormat(AmtLocal,"$9,999,999,999,999,999")#</font>&nbsp;</td></tr>
</cfoutput>
</table>

<br>
<!---
<center><font size="-1">4<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Multi-Purpose Form</font></center><br><br>
--->
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
        <td width="20%">#url.CFY# Multi-Purpose Form - 4</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>