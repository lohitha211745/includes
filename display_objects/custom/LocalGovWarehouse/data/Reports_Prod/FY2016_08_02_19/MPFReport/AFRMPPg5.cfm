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

LOGIC: Pulls off data from the UnitStats, UnitData, and FundsUsed table to show a unformatted view of the Page 5 of the AFR

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

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_FundsUsed">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFundsUsedRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFundsUsedRetMsg">
	<cfprocresult name="GetFundsUsed">
</cfstoredproc>
</cfoutput>
  
<cfset url.PageType="AFR">
<cfset url.PageName="Fund Listing and Account Groups">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 8:  FUND LISTING & ACCOUNT GROUPS
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2016/MPFReport/AFRMPPg5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=5" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>
<div><b>A. List all funds and how much was spent in FY 2016 for each fund.  Also, indicate the Fund Type (Fund Types are at the top of each column beginning on page F1).</b> If any fund names appear below, that data is based on forms submitted last year. Please make all necessary corrections. If you have more fund names than the rows provided below, please indicate them on an attachment.</div><br>
<div class="table-responsive">
<table class="table table-bordered">
<tr><td><b>Fund Name</b></td><td><b>Expenditure</b></td><td><b>Fund Type</b></td><td><b>FY End</b></td></tr>
<cfset TotExp=0><cfoutput query="GetFundsUsed"><cfset TotExp = #iif(TotExp is "",0,TotExp)# + #iif(Expenditures is "",0,Expenditures)#>
<tr><td>#Instrument#</td><td align="right">#NumberFormat(Expenditures,"$999,999,999,999,999")#</td><td><cfif FundType is "GN">General<cfelseif FundType is "SR">Special Revenue<cfelseif FundType is "CP">Capital Projects<cfelseif FundType is "DS">Debt Service<cfelseif FundType is "EP">Enterprise<cfelseif FundType is "TS">Internal Service<cfelseif FundType is "FD">Fiduciary<cfelseif FundType is "AG">Account Groups<cfelseif FundType is "DP">Discretely Presented Component Units<cfelse>&nbsp;</cfif></td><td>#DateFormat(FYEnd,"MM")#/#DateFormat(FYEnd,"DD")#</td></tr>
</cfoutput>
<tr><td><b>Total Expenditures</b></td><td align="right"><cfoutput>#NumberFormat(TotExp,"$9,999,999,999,999,999")#</cfoutput></td><td>&nbsp;</td><td>&nbsp;</td></tr>
</table>
</div>
<b>B. Does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> have assets or liabilities that should be recorded as a part of Account Groups?</b>  See <i><a href="https://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2016/2016chartofaccounts.pdf" target="_New">Chart of Accounts and Definitions</a></i> and the <i><a href="https://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2016/2016FAQ_HowtoAll.pdf" target="_New">How to Fill Out An AFR</a></i> documents for more information about Account Groups.<br>

_<cfif UCase(GetAFRRptPg1.AccountGroups) is "Y"><u>X</u><cfelse>_</cfif>_&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.AccountGroups) is "N"><u>X</u><cfelse>_</cfif>_&nbsp;No

<!---
<center>5<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Multi-Purpose Form</center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Multi-Purpose Form - 5</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
