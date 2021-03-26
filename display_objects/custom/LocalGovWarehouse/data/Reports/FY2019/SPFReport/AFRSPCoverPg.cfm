<!--- 
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 6-13-00
Date Modified By: Gary Ashbaugh
Modification Date: 1-24-01
Modifications Made: Changed the SQL query to pull of the FYEnd date's sub-parts to be used to display the FYEnd date in the report.  This is a work-around for Allaire's format command and window 2000 incompatability.
SR 00298 View Work Update - Brenda Handy 
		Modified By: Andrew Peterson
		Modification Date: 10/29/00
		Modifications Made: Create Popup Window which allos User to view report one of two ways: By current way of viewing entir report one page at a time, and By viewing by individual page selected.
		
Date Modified: 4-3-01
Modified By: Gary Ashbaugh
Modifications Made:  Changed Selection criteria to include url.CFY criteria instead of just CFY
Date Modified: 8-23-01
Modified By: Gary Ashbaugh
Modifications Made:  Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

Date Modified: 5-4-05
Modified By: Gary Ashbaugh
Modifications Made: Added Phone Extensions to Contact, CEO, and CFO

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Cover Page of the AFR

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

<cfset url.PageType="AFR">
<cfset url.PageName="Contact Information">
<cfparam name="url.PrintIt" default="No">

     <table class="table table-bordered">
  <tr>
    <td VALIGN="TOP">FY <cfoutput>#url.CFY#</cfoutput><br>Annual Financial Report<br>Special Purpose Long Form
	</td>
    <td valign="top" align="left"><b><u>DO
      NOT SEND THIS PAPER COPY</u> - THIS IS <u>YOUR</u> COPY.</b>
      <p><b>MAKE SURE YOU HAVE CLICKED THE
      SUBMIT BUTTON IN THE COMPTROLLER CONNECT PROGRAM.&nbsp; THIS WILL PROVIDE
      THE COMPTROLLER'S OFFICE WITH A COPY OF YOUR ANNUAL FINANCIAL REPORT.</b></td>
  </tr>
</table>

<h3 class="clearfix">
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/SPFReport/AFRSPCoverPg.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=1" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<table class="table table-bordered">
<cfoutput query="GetAFRRptPg1">
<tr><td>Unit Name: #UnitName# #Description#</td><td>County: #County#</td><td valign="top">Unit Code: #GetAFRRptPg1.Code#</td></tr>
</cfoutput>
</table>

<table class="table table-bordered">
     <cfoutput query="GetAFRRptPg1">
             <tr>
             <td>I attest that, to the best of my knowledge, this report represents a complete and accurate statement of
                 the financial position of #UnitName# #Description#as of the end of this fiscal year.<br><br><br>
             <hr color="black"><br>
         <center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Written signature of government official&nbsp;
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date<br>#FirstName# #LastName#
                 , #Title#
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><b>Please Sign&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
             </center></td></tr>
     </cfoutput>
     </table>

<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 1:  ENTER CONTACT INFORMATION</h5>
<br>
Is the following information correct and complete? ______ Yes ______ No<BR>
<br>
<div class="table-responsive-new">
<table class="table table-bordered">
     <cfoutput query="GetAFRRptPg1">
             <tr>
                 <td colspan="2" align="top">A. <b>Contact Person</b> (elected or appointed official responsible for
                     filling out this form):
                 </td>
                 <td colspan="2" align="top">B. <b>Chief Executive Officer</b> (elected or appointed official
                     responsible for the executive administration, i.e. mayor, supervisor, or chairman):
                 </td>
                 <td colspan="2" align="top">C. <b>Chief Financial Officer</b> (elected or appointed official
                     responsible for maintaining the government's financial records):
                 </td>
             </tr>
         <tr>
         <td>#FirstName#</td>
     <td>#LastName#</td>
     <td>#CEOFName#</td>
     <td>#CEOLName#</td>
     <td>#CFOFName#</td>
     <td>#CFOLName#</td></tr>
     <tr>
     <td colspan="2">#Title#</td>
     <td colspan="2">#CEOTitle#</td>
     <td colspan="2">#CFOTitle#</td></tr>
     <tr>
     <td colspan="2">#Address#</td>
     <td colspan="2">#CEOAddr#</td>
     <td colspan="2">#CFOAddr#</td></tr>
     <tr>
     <td colspan="2">#City#</td>
     <td colspan="2">#CEOCity#</td>
     <td colspan="2">#CFOCity#</td></tr>
     <tr>
     <td colspan="2">#State#</td>
     <td colspan="2">#CEOState#</td>
     <td colspan="2">#CFOState#</td></tr>
     <tr>
     <td colspan="2">#Zip#</td>
     <td colspan="2">#CEOZip#</td>
     <td colspan="2">#CFOZip#</td></tr>
     <tr>
     <td colspan="2">Phone: #Phone#
         <cfif ext is not ""><br>Ext: #Ext#</cfif></td>
     <td colspan="2">Phone: #CEOPhone#
         <cfif CEOext is not ""><br>Ext: #CEOExt#</cfif></td>
     <td colspan="2">Phone: #CFOPhone#
         <cfif CFOext is not ""><br>Ext: #CFOExt#</cfif></td></tr>
     <tr>
     <td colspan="2">Fax: #Fax#</td>
     <td colspan="2">Fax: #CEOFax#</td>
     <td colspan="2">Fax: #CFOFax#</td></tr>
     <tr>
     <td colspan="2">E-mail: <span class="emailid-wrap">#Email_Gov#</span></td>
     <td colspan="2">E-mail: <span class="emailid-wrap">#CEOEmail#</span></td>
     <td colspan="2">E-mail: <span class="emailid-wrap">#CFOEmail#</span></td></tr>
     </table>
     </div>

<table class="table noborder-table">
<tr>
<td width="40">
    <cfif ((CEOFName is CFOFName) and (CEOLName is CFOLName) and (CEOFName is not "" and CEOLName is not ""))>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                width="24" height="24" border="0" alt=""><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                width="24" height="24" border="0" alt=""></cfif></td>
    <td>If the Chief Executive Officer and the Chief Financial Officer are the same person as the Contact
        Person, please check this box and skip to Step 2. If not, please <u>do not</u> leave columns B and C blank.
    </td></tr>
</cfoutput>
     </table>

<div class="text-danger margintop">*The contact person listed on the AFRs is for the current Fiscal Year.  Previous fiscal years may have a different contact person.  Please contact the Local Government Division at 877-304-3899 if you need the contact person for previous years.</div>
    <div class="text-danger margintop"><b>*The Annual Financial Reports downloaded from this site may vary from the original report.  Total on the downloaded form reflect the total of all sub accounts.  Other changes may include the reported method of accounting.</div>

	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>

</cflock>
