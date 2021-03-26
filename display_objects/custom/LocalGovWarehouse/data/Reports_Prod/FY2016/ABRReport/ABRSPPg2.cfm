<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Page 2 of the AFR

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
 
<!---<html>
<head>
	<title>AFR - Page 2</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Fiscal Year End">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>

<h5><span class="glyphicon glyphicon-circle-arrow-right"></span><font size="-1" color="black"> STEP 2:  VERIFY FISCAL YEAR END</FONT>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/ABRReport/ABRSPPg2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=2" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="25%">
<tr><td>
<font size="-1"><cfoutput>FY END DATE:&nbsp;&nbsp;#DateFormat(GetAFRRptPg1.FYEnd,"MM/DD/YYYY")#</cfoutput></font><br>
</td></tr>
</table>
<br>
<font size="-1">If the fiscal year end date, listed above, is incorrect, cross out the incorrect date and provide the correct date.  Official documentation of this change must be sent to the Chicago office before the fiscal year end date is officially changed.</font><br>
<br>
<h5>
<span class="glyphicon glyphicon-circle-arrow-right"></span><font size="-1" color="black"> STEP 3:  ACCOUNTING SYSTEM AND DEBT</FONT><BR>
</h5>
<br>
<font size="-1"><b>A. Which type of accounting system does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> use:</font></b><br>
<br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%">
<cfoutput query="GetAFRRptPg1">

<tr><td width="50%" align="left">_<cfif AccountingMethod is "Cash"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Cash - with no assets (Cash Basis)</font></td><td width="50%" align="left">_<cfif AccountingMethod is "Modified Accrual"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Modified Accrual/Accrual</font></td></tr>
<tr><td width="50%" align="left">_<cfif AccountingMethod is "Cash With Assets"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Cash - with assets (Modified Cash Basis)</font></td><td width="50%" align="left">_<cfif AccountingMethod is "Combination"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Combination (explain)</font></td></tr>
</cfoutput>
</table>
<br>
<cfoutput query="GetAFRRptPg1">
<font size="-1"><b>B. Does the government have <u>Bonded</u> debt this reporting fiscal year?</font></b> _<cfif UCase(BondedDebt) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Yes</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(BondedDebt) is "N"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">No</font><br>
<br>
<font size="-1"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Yes", indicate the type(s) of debt <u>and</u> complete the Statement of Indebtedness page, located on page F7.</b></font><br>
<br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%">
<tr><td width="34%" align="left">_<cfif UCase(GoBonds) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">G.O. Bonds</font></td><td width="33%" align="left">_<cfif UCase(RevenueBonds) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Revenue Bonds</font></td><td width="33%" align="left">_<cfif UCase(AlternateRevenueBonds) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Alternate Revenue Bonds</font></td></tr>
</table>
</cfoutput>
<br>
<cfoutput query="GetAFRRptPg1">
<font size="-1"><b>C. Does the government have debt, other than bonded debt this reporting fiscal year?</font></b> _<cfif UCase(Debt) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Yes</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(Debt) is "N"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">No</font><br>
<br>
<font size="-1"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Yes", indicate the type(s) of debt <u>and</u> complete the Statement of Indebtedness page, located on page F7.</b></font><br>
<br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%">
<tr><td width="34%" align="left">_<cfif UCase(ContractualCommitments) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Contractual Commitments</font></td><td width="66%" align="left">_<cfif UCase(Other) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Other (Explan)&nbsp;<u>#OtherExplan#</u></font></td></tr>
</table>
</cfoutput>
<br>
<!---
<center><font size="-1">2<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Abbreviated Form</font></center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
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
        <td width="20%">#url.CFY# Abbreviated Form - 2</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
