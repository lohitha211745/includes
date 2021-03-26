<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->

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

<!---<html>
<head>
	<title>AFR Cover Page</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Contact Information">
<cfparam name="url.PrintIt" default="No">
<br /><br />
<table class="table-bordered" <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%"--->>
  <tr>
    <td width="35%" height="1" VALIGN="TOP"><font size="+2" color="Black">FY <cfoutput>#url.CFY#</cfoutput><br>Annual Financial Report</font><br><font size="-1" color="black">Special Purpose Long Form</font>
	</td>
    <td width="43%" height="75" rowspan="2" valign="top" align="left"><b><font size="-2"><u>DO
      NOT SEND THIS PAPER COPY</u> - THIS IS <u>YOUR</u> COPY.</font></b>
      <p><b><font size="-2">MAKE SURE YOU HAVE CLICKED THE
      SUBMIT BUTTON IN THE COMPTROLLER CONNECT PROGRAM.&nbsp; THIS WILL PROVIDE
      THE COMPTROLLER'S OFFICE WITH A COPY OF YOUR ANNUAL FINANCIAL REPORT.</font></b></td>
  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>
</table>
<h3>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/SPFReport/AFRSPCoverPg.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=1" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>
<HR size="+3" color="Gray">
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%"--->>
<cfoutput query="GetAFRRptPg1">
<tr><td><font size="-1">Unit Name: #UnitName# #Description#</font></td><td><font size="-1">County: #County#</font></td><td width="45%" valign="top"><font size="-1">Unit Code: #GetAFRRptPg1.Code#</font></td></tr>
</cfoutput>
</table>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1"  bordercolor="black" width="100%">
<cfoutput query="GetAFRRptPg1">
<tr><td><font size="-1">I attest that, to the best of my knowledge, this report represents a complete and accurate statement of the financial position of #UnitName# #Description# as of the end of this fiscal year.<br><br><br><hr color="black"><br><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Written signature of government official&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date<br>#FirstName# #LastName#, #Title#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><b>Please Sign&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></center></font></td></tr>
</cfoutput>
</table>
<br>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span>STEP 1:  ENTER CONTACT INFORMATION
</h5>
<br>
<font size="-1">Is the following information correct and complete?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;______ Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;______ No</font><BR>
<br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1"  bordercolor="black" width="100%"--->>
<cfoutput query="GetAFRRptPg1">
<tr><td colspan="2" align="top"><font size="-1">A. <b>Contact Person</b> (elected or appointed official responsible for filling out this form):</font></td><td colspan="2" align="top"><font size="-1">B. <b>Chief Executive Officer</b> (elected or appointed official responsible for the executive administration, i.e. mayor, supervisor, or chairman):</font></td><td colspan="2" align="top"><font size="-1">C. <b>Chief Financial Officer</b> (elected or appointed official responsible for maintaining the government's financial records):</font></td></tr>
<tr><td><font size="-1">#FirstName#&nbsp;</font></td><td><font size="-1">#LastName#&nbsp;</font></td><td><font size="-1">#CEOFName#&nbsp;</font></td><td><font size="-1">#CEOLName#&nbsp;</font></td><td><font size="-1">#CFOFName#&nbsp;</font></td><td><font size="-1">#CFOLName#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#Title#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOTitle#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOTitle#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#Address#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOAddr#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOAddr#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#City#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOCity#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOCity#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#State#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOState#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOState#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#Zip#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOZip#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOZip#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">Phone: #Phone#&nbsp;<cfif ext is not ""><br>Ext: #Ext#</cfif></font></td><td colspan="2"><font size="-1">Phone: #CEOPhone#<cfif CEOext is not ""><br>Ext: #CEOExt#</cfif></font></td><td colspan="2"><font size="-1">Phone: #CFOPhone#<cfif CFOext is not ""><br>Ext: #CFOExt#</cfif></font></td></tr>
<tr><td colspan="2"><font size="-1">Fax: #Fax#</font></td><td colspan="2"><font size="-1">Fax: #CEOFax#</font></td><td colspan="2"><font size="-1">Fax: #CFOFax#</font></td></tr>
<tr><td colspan="2"><font size="-1">E-mail: #Email_Gov#</font></td><td colspan="2"><font size="-1">E-mail: #CEOEmail#</font></td><td colspan="2"><font size="-1">E-mail: #CFOEmail#</font></td></tr>
</table>
<br>
<table <!--- bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%"--->>
<tr><td width="30"><cfif ((CEOFName is CFOFName) and (CEOLName is CFOLName) and (CEOFName is not "" and CEOLName is not ""))><img src="#application.LocGovWarehouse#images/Checked.jpg" width=24 height=24 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=24 height=24 border=0 alt=""></cfif></td><td colspan="6"><font size="-1">If the Chief Executive Officer and the Chief Financial Officer are the same person as the Contact Person, please check this box and skip to Step 2.  If not, please <u>do not</u> leave columns B and C blank.</font></td></tr>
</cfoutput>
</table>
<br>
<br>
	<p><font color="red" size="-2"><b>*The contact person listed on the AFRs is for the current Fiscal Year.  Previous fiscal years may have a different contact person.  Please contact the Local Government Division at 877-304-3899 if you need the contact person for previous years.</b></font><br>
	<br><p><font color="red" size="-2"><b>*The Annual Financial Reports downloaded from this site may vary from the original report.  Total on the downloaded form reflect the total of all sub accounts.  Other changes may include the reported method of accounting.</b></font>
<br><br>
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
<!---</body>
</html>--->
</cflock>
