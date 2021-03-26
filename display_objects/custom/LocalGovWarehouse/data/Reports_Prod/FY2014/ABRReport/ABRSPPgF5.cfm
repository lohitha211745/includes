<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the CapitalOutlay table to show a unformatted view of the Page F6 of the AFR

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
 
 <!--- pulls off fields for Capital Outlay for update form --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_CapitalOutlayCategoryInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCapitalOutlayCategoryInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCapitalOutlayCategoryInfoRetMsg">
	<cfprocresult name="GetCapitalOutlayCategoryInfo">
</cfstoredproc>
</cfoutput>

<cfset url.PageType="AFR">
<cfset url.PageName="Capital Outlay">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h3 class="clearfix">
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2014/ABRReport/ABRSPPgF5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=F7" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h3>

<div class="table-responsive">
<table class="table table-bordered">
		<tr><td colspan="4" align="center"><b>Capital Outlay</b></td></tr>
		<tr><td></td><td></td><td colspan="2" align="center" valign="top">These are not funds</td></tr>
		<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Function</b></td><td align="center" valign="top"><b>Construction</b></td><td  align="center" valign="top"><b>Land, Structures, and Equipment</b></td></tr>
		<cfoutput query="GetCapitalOutlayCategoryInfo">
			<tr><td align="center"><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(CO)#</td><td align="right">#NumberFormat(LS)#</td>
			</tr>
		</cfoutput>
    </table>
    </div>
    <div>*This page should only be filled out if you have spent funds for capital projects or development<br>
		*The Capital Outlay page is requested by the U.S. Census Bureau and is considered optional by the State Comptroller.<br>
		*If you complete this page you WILL NOT have to complete the Survey of Government Finances from the U.S. Census Bureau.<br>
		*If you do NOT complete this page the U.S. Census Bureau will contact you for further information.</div>
		<p class="text-right">F5</p>

	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Abbreviated Form - F7</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
