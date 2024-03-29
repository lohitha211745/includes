﻿<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
<!---<head>--->
	<!---<title>Vendor Payments</title>--->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance Manage User">
	<meta name="author" content="Gary Ashbaugh">
	<meta name="robots" content="noindex,nofollow">
<!--- 
Created By: Gary Ashbaugh
Date Created: 4-13-2012

Modified By: Gary Ashbaugh
Modifications Made: Added API, MobileApp, and MobileAppType fields for the IOC EVR Mobile Application

Description:  The program will allow users to register for the Vendor Remittance Site
--->

<SCRIPT LANGUAGE="JavaScript" type="text/javascript" src="script1.js"></SCRIPT>  
<SCRIPT LANGUAGE="JavaScript">

	
	function SelectImage(NoOfImage) {
		document.VendorRemit.Captcha.value = NoOfImage;
		
	}

	function MakeMouseCursorWait() {
 	 document.body.style.cursor='wait';
 	}
 
 	function MakeMouseCursorPointer() {
 	 document.body.style.cursor='Default';
	 document.VendorRemit.vendTIN.focus();
 	} 
	  
	function ChangeCoordinator() {
		
		Admchosen = ""
		len = document.VR.VendorAdmin.length
		for(i=0;i<len;i++) {
			if(document.VR.VendorAdmin[i].checked) {
				Admchosen = document.VR.VendorAdmin[i].value
			}
		}
		
		if(Admchosen == "Y") {
		/*if (document.VendorRemit.VendorAdmin[0].checked) {*/
			document.VR.PaymentNotification[0].disabled = false;
			document.VR.PaymentNotification[1].disabled = false;
			if (document.VR.PaymentNotification[0].checked == true) {
				document.VR.NotificationType.disabled = false;
				if (document.VR.NotificationType.value == 'Text') {
					document.VR.CellProvider.disabled = false;
					document.VR.CellPhone.disabled = false;
				}
				else { 
					document.VR.CellProvider.value = 'None';
					document.VR.CellProvider.disabled = true;
					document.VR.CellPhone.value = '';
					document.VR.CellPhone.disabled = true;
				}
			}
			else {
				document.VR.NotificationType.value = 'None';
				document.VR.NotificationType.disabled = true;
				document.VR.CellProvider.value = 'None';
				document.VR.CellProvider.disabled = true;
				document.VR.CellPhone.value = '';
				document.VR.CellPhone.disabled = false;
			}

		}
		else {
			document.VR.PaymentNotification[0].checked = false;
			document.VR.PaymentNotification[1].checked = true;
			document.VR.PaymentNotification[0].disabled = true;
			document.VR.PaymentNotification[1].disabled = true;
			document.VR.NotificationType.value = 'None';
			document.VR.NotificationType.disabled = true;
			document.VR.CellProvider.value = 'None';
			document.VR.CellProvider.disabled = true;
			document.VR.CellPhone.value = '';
			document.VR.CellPhone.disabled = true;
		}

	}
	
	function Instructions() {
         remote = window.open("","remotewin","width=800,height=400,scrollbars=1");
         /*remote.location.href = "http://illinoisComptroller.gov/vendors/enhanced-vendor-remittance/manage-user-instructions/";*/
        remote.location.href = "https://2018-uat.illinoisComptroller.gov/vendors/enhanced-vendor-remittance/manage-user-instructions/";
             if (remote.opener == null) remote.opener = window; 
         remote.opener.name = "opener";
         }
</script>

<cfLock Scope="SESSION" TIMEOUT="120">
<cfoutput>
<cfparam name="Session.vendTIN" default="">
<cfparam name="url.CurrentPage" default="1">
<cfparam name="url.StartRec" default="1">
<cfparam name="url.EndRec" default="6">
<cfparam name="url.PrevPage" default="False">
<cfparam name="url.NextPage" default="False">
<cfparam name="Session.AdmLevel" default="">
<cfparam name="url.ValUser" default="True">
<cfparam name="url.NewPage" default="False">
<cfparam name="Session.Number_Code" default="">
<cfparam name="EntryType" default="">
<cfset ErrorNo = "">

<CFIF IsDefined ("form.NewPage")>
  <CFSET NewPage = form.NewPage>  
<cfelseif IsDefined ("url.NewPage")>
 <CFSET NewPage = URL.NewPage>
</CFIF>


<cfinclude template="TmpVendorapplicationSettings.cfm">
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

</cfoutput>
<cfif trim(Session.AdmLevel) is not "Coordinator">
    	<cflocation url="#application.EVRSite#/vendors/direct-deposit/learn-more/" addtoken="No">
</cfif>
</cfLock>

<cfif isdefined("form.Delete")>
	<cfoutput>
    
    <cfStoredProc datasource="#application.VendorPayments#" Procedure="Del_VendorUserInfo">
        <cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
        <cfif trim(Session.VendTIN) is not "">
            <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
        <cfelse>
            <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNO" null="yes">
        </cfif>
        </cfLock>
        <cfif trim(form.OldEMail) is not "">
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.OldEmail)#">
        <cfelse>
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" null="yes">
        </cfif>
        <cfif trim(Session.Number_Code) is "4">
            <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#Session.Number_Code#">
        <cfelse>
            <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
        </cfif>
        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@IOCManager" value="N">
        <cfif trim(form.ModifiedBy) is not "">
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@ModifiedBy" value="#trim(form.ModifiedBy)#">
        <cfelse>
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@ModifiedBy" null="yes">
        </cfif>
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="DelVendorUserInfoRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="DelVendorUserInfoRetMsg">
        <cfprocresult name="DelVendorUserInfo">
    </cfstoredproc>

    <cfif DelVendorUserInfoRetVal eq 0>
        <div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
        <b>#trim(form.FirstName)# #trim(form.LastName)# has been removed from having access to the Vendor Remittance Site on #DateFormat(Now(),"mm/dd/yyyy")#!</b>
        </div>
    
   <cfelse>
        <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
        <b>#trim(form.FirstName)# #trim(form.LastName)# could not be removed from having access to the Vendor Remittance Site since the user is the only Coordinator left for your Vendor!</b>
        </div>
        <cfset ErrorNo = "11">
        <cfif EntryType is "Add">
            <cfset DisplayvendorRecord = "False">
            <cfset url.NewPage="True">
         </cfif>       
    </cfif>
    </cfoutput>

<cfelseif isdefined("form.ResetPassword")>
	<cfoutput>
	<!--- Reset Password --->                            
	<cfset TmpResetAuthCd = "#CreateUUID()#">
    <cfset TestUnique=0>

    <cfloop condition="TestUnique greater than 0">
    
        <cfStoredProc  datasource="#application.VendorPayments#" Procedure="Check_ResetAuthCd">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" value="#TmpResetAuthCd#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckResetAuthCdRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckResetAuthCdRetMsg">
            <cfprocresult name="CheckResetAuthCd">
        </cfstoredproc>
        
        <cfif CheckResetAuthCdRetVal gt 0>
            <cfset TmpResetAuthCd = "#CreateUUID()#">
        <cfelse>
            <cfset TestUnique=1>
        </cfif>
     </cfloop>
     
    <cfStoredProc datasource="#application.VendorPayments#" Procedure="Reset_UserPassword">
        <cfif trim(form.oldEMail) is not "">
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.oldEmail)#">
        <cfelse>
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" null="yes">
        </cfif>
        <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" value="#TmpResetAuthCd#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ResetUserPasswordRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ResetUserPasswordRetMsg">
        <cfprocresult name="ResetUserPassword">
    </cfstoredproc>

    <cfif ResetUserPasswordRetVal eq 0>

        <!--- Change Password --->
        <CFMail to="#trim(form.OldEMail)#" 
            from="#application.VendorRemitEmail#"
            subject="Secure Enhanced Vendor Remittance Change Password"
            type="html">
            <p>This is an automated E-Mail sent to you by the Illinois Office of the Comptroller.  It is being sent to you from the State of Illinois Comptroller's Secure Enhanced Vendor Remittance Site.<br><br>Please click on <a href="#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ResetAuthCd=#TmpResetAuthCd#&DtChngEmailSent=#DateFormat(now(),"mm/dd/yyyy")#">Change Password</a> to create your own personal password.  If the "Change Password" link does not work, you will need to copy and paste this link into your Internet Browser's Internet Site Address.  http://#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ResetAuthCd=#TmpResetAuthCd#&DtChngEmailSent=#DateFormat(now(),"mm/dd/yyyy")#  <br /><br />Your Password must be between 6-25 characters in length.  You will need to change it every 30 days and you can NOT use the same password that you have used in the last 10 times.  If you forget your password, please contact your Coordinator to have it reset.  If you have received this E-Mail by mistake, please contact our office at <a href="Mailto:#application.SecAdmEmail#?Subject=Secure Enhanced Vendor Remittance Registration">#application.SecAdmEmail#</a> or contact our office at #application.SecAdmPhone#.
            <br><br>
            Thank You,
            <br><br><Br><Br>
            Illinois Office of the Comptroller</P>
            <BR>
            <BR>
        </cfmail>
        
        <div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
        <b>#trim(form.FirstName)# #trim(form.LastName)# password has been reset for the Vendor Remittance Site on #DateFormat(Now(),"mm/dd/yyyy")#!</b>
        </div>        
    </cfif>
    </cfoutput>

<cfelseif isdefined("form.ValidateEmail")>
	<cfoutput>
	<!--- Send out another "Validate Your E-Mail --->                     
    <cfStoredProc datasource="#application.VendorPayments#" Procedure="ReValidate_EmailInfo">
        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.OldEmail)#">
        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@DtValidated" value="#dateformat(now(),"mm/dd/yyyy")#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ReValidateEMailRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ReValidateEMailRetMsg">
        <cfprocresult name="ReValidateEMail">
    </cfstoredproc>

    <cfif ReValidateEMailRetVal eq 0>
        <!--- Create Password --->
        <CFMail 
        TO="#trim(form.OldEMail)#"
        from="#application.VendorRemitEmail#"
        subject="Secure Enhanced Vendor Remittance Updated Registration"
        type="html"> 
        <P>This is an automated E-Mail sent to you by the Illinois Office of the Comptroller.  It is being sent to you from the State of Illinois Comptroller's Secure Enhanced Vendor Remittance Site.<br><br><b>Your registration as a user of this site has been updated.</b>.<br><br>Please click on <a href="#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ValidateEmail=Yes&TaxpayerInfoNo=#urlEncodedformat(Session.VENDTIN)#&Email=#urlEncodedFormat(form.OldEMail)#&Number_Code=#urlEncodedFormat(Session.Number_Code)#">Verify E-Mail Address</a> to verify that you have received this E-Mail.  If the "Verify E-Mail Address" link does not work, you will need to copy and paste this link into your Internet Browser's Internet Site Address. http://#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ValidateEmail=Yes&TaxpayerInfoNo=#urlEncodedformat(Session.VENDTIN)#&Email=#urlEncodedFormat(form.OldEMail)#&Number_Code=#urlEncodedFormat(Session.Number_Code)#<br /><br />This E-Mail address is your User Id for the Enhanced Vendor Site.  If you have received this E-Mail by mistake, please contact our office at <a href="Mailto:#application.SecAdmEmail#?Subject=Secure Enhanced Vendor Remittance Registration">#application.SecAdmEmail#</a> or contact our office at #application.SecAdmPhone#.  You must verify your E-Mail address, since it has changed since the last time you had been registered.  You will not be able to log into the Secure Enhanced Vendor Remittance Site until (1) you have verified your E-Mail address and (2) you have created a password.  
        <br><br>
        Thank You,
        <br><br><br><br>
        Illinois Office of the Comptroller</P>
        </cfmail>
        
        <div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
        <b>#trim(form.FirstName)# #trim(form.LastName)# has been sent a "Validate Your E-Mail" E-Mail for the Vendor Remittance Site on #DateFormat(Now(),"mm/dd/yyyy")#!</b>
        </div>
        
    </cfif>
	</cfoutput>
    
<cfelseif isdefined("form.Add")>
	
	<cfoutput>  
    <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_NoVendorCoordinator">
        <cfLock Scope="SESSION" TIMEOUT="120" type="readonly"><cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"></cfLock>
        <cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
        <cfif trim(Session.Number_Code) is "4">
        	<cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
        <cfelse>
        	<cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="Yes">
        </cfif>
        </cfLock>
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
        <cfprocresult name="CheckNoVendorCoordinator">
    </cfstoredproc>
    
  	<!--- Check to see if Email has been marked as being returned --->
        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_EmailReturned">
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckEmailReturnedRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckEmailReturnedRetMsg">
            <cfprocresult name="CheckEmailReturned">
        </cfstoredproc>
        
       
        <cfset TMPAPI="">
        <cfset  TMpOldMobileApp="N"> 
    
    	<!--- Verify E-Mail has a "@" sign and a "." after "@" sign --->       
        <cfif isdefined("form.VendorAdmin")>
        	<cfset TmpVendorAdmin = "#form.VendorAdmin#">
        <cfelse>
        	<cfset TmpVendorAdmin = "N">
        </cfif>
        <cfif isdefined("form.MobileApp")>
        	<cfset TmpMobileApp = "#form.MobileApp#">
        <cfelse>
        	<cfset TmpMobileApp = "N">
        </cfif>
         
        <cfif isdefined("form.OldVendorAdmin")>
        	<cfset TmpOldVendorAdmin = "#form.OldVendorAdmin#">
        <cfelse>
        	<cfset TmpOldVendorAdmin = "N">
        </cfif>
        <cfif isdefined("form.PaymentNotification")>
        	<cfset TmpPaymentNotification = "#form.PaymentNotification#">
        <cfelse>
        	<cfset TmpPaymentNotification = "N">
        </cfif>
         <cfif isdefined("form.OldPaymentNotification")>
        	<cfset TmpOldPaymentNotification = "#form.OldPaymentNotification#">
        <cfelse>
        	<cfset TmpOldPaymentNotification = "N">
        </cfif>
        <cfif isdefined("form.NotificationType")>
        	<cfset TmpNotificationType = "#form.NotificationType#">
        <cfelse>
        	<cfset TmpNotificationType = "None">
        </cfif>
        <cfif isdefined("form.OldNotificationType")>
        	<cfset TmpOldNotificationType = "#form.OldNotificationType#">
        <cfelse>
        	<cfset TmpOldNotificationType = "None">
        </cfif>
        <cfif isdefined("form.CellProvider")>
        	<cfset TmpCellProvider = "#form.CellProvider#">
        <cfelse>
        	<cfset TmpCellProvider = "None">
        </cfif>
        <cfif isdefined("form.OldCellProvider")>
        	<cfset TmpOldCellProvider = "#form.OldCellProvider#">
        <cfelse>
        	<cfset TmpOldCellProvider = "None">
        </cfif>
        <cfif isdefined("form.CellPhone")>
        	<cfif len(form.CellPhone) is 14>
            	<cfset TmpAreaCode = "#mid(form.CellPhone,2,3)#">
                <cfset TmpPhonePrefix = "#mid(form.CellPhone,7,3)#">
                <cfset TmpPhoneSuffix = "#mid(form.CellPhone,11,4)#">
            <cfelseif len(form.Contact_Phone) is 8>
           		<cfset TmpAreaCode = "">
                <cfset TmpPhonePrefix = "#mid(form.CellPhone,1,3)#">
                <cfset TmpPhoneSuffix = "#mid(form.CellPhone,5,4)#">
           	<cfelse>
            	<cfset TmpAreaCode = "">
                <cfset TmpPhonePrefix = "">
                <cfset TmpPhoneSuffix = "">
            </cfif> 
        <cfelse>
			<cfset TmpAreaCode = "">
            <cfset TmpPhonePrefix = "">
            <cfset TmpPhoneSuffix = "">   
        </cfif>
        <cfif isdefined("form.OldAreaCode")>
        	<cfset TmpOldAreaCode = "#form.OldAreaCode#">
        <cfelse>
        	<cfset TmpOldAreaCode = "">
        </cfif>
        <cfif isdefined("form.OldPhonePrefix")>
        	<cfset TmpOldPhonePrefix = "#form.OldPhonePrefix#">
        <cfelse>
        	<cfset TmpOldPhonePrefix = "">
        </cfif>
        <cfif isdefined("form.OldPhoneSuffix")>
        	<cfset TmpOldPhoneSuffix = "#form.OldPhoneSuffix#">
        <cfelse>
        	<cfset TmpOldPhoneSuffix = "">
        </cfif>
        
        <cfif trim(form.Contact_Phone) is not "">
			<cfset TmpPhone = "#form.Contact_Phone#">
        <cfelse>
            <cfset TmpPhone = "">
        </cfif>
        
        <cfset TmpOldContactPhone = "#form.oldContactPhone#">
       
       	<!--- Verify user has used the '@' sign and a '.' --->
		<cfset FindAt = False>
        <cfset AtPost = 0>
        <cfset FindPeriod = False>
        <cfset i = 1>
		<cfif trim(form.Email) is not "">
            <cfloop condition="#i# lt #len(form.Email)#">
                <cfif mid(form.Email,#i#,1) is '@'>
                    <cfset atPost = "#i#">
                    <cfset FindAt = True>
                </cfif>
                <cfif (FindAt is True) and (mid(form.Email,#i#,1) is ".")>
                    <cfset FindPeriod = True>
                </cfif>
                <cfset i = i +1>
         
            </cfloop>
        </cfif>
        
        <!--- Verify user has not used a '+' sign before the  '@' sign --->
        <cfset FindPlus = False>
        <cfset i = 1>       
        <cfset AtPost = 0>
		<cfif trim(form.Email) is not "">
            <cfloop condition="#i# lt #atPost#">
                <cfif (mid(form.Email,#i#,1) is "+")>
                    <cfset FindPlus = True>
                </cfif>
                <cfset i = i +1>
         
            </cfloop>
        </cfif>
        
        <cfif CheckEmailReturnedRetVal is 0>
        	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)# since the user's E-Mail has been marked as being "undeliverable" by our office!</b>
            </div>
            <cfset ErrorNo = "1">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>
  
    	<cfelseif (trim(form.VendorAdmin) is "N" and trim(form.OldVendorAdmin) is "Y" and CheckNoVendorCoordinator.CoordinatorCount le 1)>
        	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can NOT change #trim(form.FirstName)# #trim(form.LastName)# from being a Coordinator until you make somebody else the Coordinator!</b>
            </div>
            <cfset ErrorNo = "2">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>

     	<cfelseif (trim(form.VendorAdmin) is "N" and CheckNoVendorCoordinator.CoordinatorCount eq 0) and (trim(form.LastName) is not "")>
        	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can NOT add #trim(form.FirstName)# #trim(form.LastName)# as a Non-Coordinator until you add a Coordinator!</b>
            </div>
            <cfset ErrorNo = "3">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>

     	<cfelseif (trim(form.LastName) is "" or trim(form.FirstName) is "" or trim(form.Email) is "") and (trim(form.LastName) is not "" or trim(form.FirstName) is not "" or trim(form.Email) is not "")>
        	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)# as an authorized user of the Secure Enhanced Vendor Remittance application since you failed to fillout either your Taxpayer Identification Number, First Name, Last Name, and/or E-Mail!</b>
            </div>
            <cfset ErrorNo = "4">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>
 
        <cfelseif (((FindAt is "False") or (FindPeriod is "False")) and (trim(form.Email) is not ""))>
        	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)# as an authorized user of the Secure Enhanced Vendor Remittance application since you failed to give us a valid E-Mail!</b>
            </div>
            <cfset ErrorNo = "5">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>

        <cfelseif (FindPlus is "True")>
        	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)# as an authorized user of the Secure Enhanced Vendor Remittance application since you failed to give us a valid E-Mail!</b>
            </div>
            <cfset ErrorNo = "6">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>

        <cfelseif  TmpVendorAdmin is "Y" and TmpNotificationType is "Text" and (TmpCellProvider is "None")>
        	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)# as an authorized user of the Secure Enhanced Vendor Remittance application since you failed to give us a valid Cell Phone Provider when asking for a Text notification!</b>
            </div>
            <cfset ErrorNo = "7">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>
            
       	<cfelseif  TmpVendorAdmin is "Y" and TmpNotificationType is "Text" and (len(trim(TmpAreaCode)) lt 3 or len(trim(TmpPhonePrefix)) lt 3 or len(trim(TmpPhoneSuffix)) lt 4)>
        	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)# as an authorized user of the Secure Enhanced Vendor Remittance application since you failed to give us a valid Cell Phone Number when asking for a Text notification!</b>
            </div>
            <cfset ErrorNo = "8">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>

       <cfelseif  TmpVendorAdmin is "Y" and trim(TmpPaymentNotification) is "Y" and (trim(TmpNotificationType) is not "Text" and trim(TmpNotificationType) is not "EMail")>
       		<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We can not register or update #trim(form.FirstName)# #trim(form.LastName)# because the user is marked as receiving payment notification but has failed to tell us the type of notification (E-Mail or Text)!</b>
            </div>
            <cfset ErrorNo = "9">
            <cfif EntryTYpe is "Add">
            	<cfset DisplayvendorRecord = "False">
                <cfset url.NewPage="True">
            </cfif>
    
       <cfelseif (trim(form.LastName) is not "" and trim(form.FirstName) is not "" and trim(form.Email) is not "")>
       
            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_VendorRemit">
                <cfif trim(form.OldEMail) is not "">
                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.OldEmail)#">
                <cfelse>
                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" null="yes">
                </cfif>
                <cfif trim(Session.VENDTIN) is not "">
                    <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VENDTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                <cfelse>
                    <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNO" null="yes">
                </cfif>
                <cfif trim(Session.Number_Code) is "4">
                    <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
                <cfelse>
                    <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
                </cfif>
                
                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckVendorRemitRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckVendorRemitRetMsg">
                <cfprocresult name="CheckVendorRemit">
            </cfstoredproc>
        
			<cfif CheckVendorRemitRetVal eq 0>
            	<!--- ************** --->
            	<!--- Update Routine --->
            	<!--- ************** --->
            	<cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_VendorRemit">
                	<cfif trim(form.EMail) is not "">
                    	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                	<cfelse>
                    	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" null="yes">
                	</cfif>
                    <cfif trim(Session.VENDTIN) is not "">
                    	<cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VENDTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                	<cfelse>
                    	<cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNO" null="yes">
                	</cfif>
                    <cfif trim(Session.Number_Code) is "4">
                    	<cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#Session.Number_Code#">
                	<cfelse>
                    	<cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
                	</cfif>
                	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckVendorRemit2RetVal">
               	 	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckVendorRemit2RetMsg">
                	<cfprocresult name="CheckVendorRemit">
            	</cfstoredproc>
                
                <cfif CheckVendorRemit2RetVal eq 0 and #trim(form.Email)# is not #trim(form.OldEmail)#>
                	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                    <b>We can not update #trim(form.FirstName)# #trim(form.LastName)# as a contact for this Vendor because the E-Mail is already being used!</b>
                    </div>
                    <cfset ErrorNo = "10">
                    <cfif EntryTYpe is "Add">
            			<cfset DisplayvendorRecord = "False">
                        <cfset url.NewPage="True">
            		</cfif>

                <cfelse>
               
					<cfif (trim(form.OldEmail) is not trim(form.Email)) or (trim(form.OldFirstName) is not  trim(form.FirstName)) or (trim(form.LastName) is not trim(form.OldLastName)) or (trim(TmpVendorAdmin) is not trim(TmpOldVendorAdmin)) or (trim(TmpOldPaymentNotification) is not trim(TmpPaymentNotification)) or (trim(TmpOldNotificationType) is not trim(TmpNotificationType)) or (trim(TmpOldCellProvider) is not trim(TmpCellProvider)) or (trim(TmpOldAreaCode) is not trim(TmpAreaCode)) or (trim(TmpOldPhonePrefix) is not trim(TmpPhonePrefix)) or (trim(TmpPhoneSuffix) is not trim(TmpPhoneSuffix)) or (trim(form.OldInactive) is not trim(form.Inactive)) or (trim(TmpOldContactPhone) is not trim(TmpPhone)) ><!---or (TmpOldMobileApp is not TmpMobileApp)--->
                        
                        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Updt_VendorUserInfo">
                            <cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
                            <cfif trim(Session.VendTIN) is not "">
                                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" null="yes">
                            </cfif>
                            <cfif trim(Session.Number_Code) is "4">
                                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
                            </cfif>
                            </cfLock>
                            <cfif trim(form.OldEMail) is not "">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@OldEMail" value="#trim(form.OldEmail)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@OldEMail" null="yes">
                            </cfif>
                            <cfif trim(form.EMail) is not "">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" null="yes">
                            </cfif>
                            <cfif trim(form.FirstName) is not "">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Firstname" value="#trim(form.Firstname)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Firstname" null="yes">
                            </cfif>
                            <cfif trim(form.LastName) is not "">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Lastname" value="#trim(form.Lastname)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Lastname" null="Yes">
                            </cfif>
                            <cfif trim(TmpPhone) is not "">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Phone" value="#trim(TmpPhone)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Phone" null="Yes">
                            </cfif>
                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@API" null="Yes">
                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@MobileApp" value="N">
                            <cfif (trim(form.DtEmailValSent) is not "" and (trim(form.OldEMail) is not trim(form.EMail)))>
                                <cfprocparam type="In"  cfsqltype="cf_sql_TimeStamp" dbvarname="@DtEmailValSent" value="#dateformat(now(),"mm/dd/yyyy")#">
                            <cfelseif ((trim(form.OldInactive) is not trim(form.Inactive)) and trim(form.Inactive) is "No")>
                                <cfprocparam type="In"  cfsqltype="cf_sql_TimeStamp" dbvarname="@DtEmailValSent" value="#dateformat(now(),"mm/dd/yyyy")#">
                            <cfelseif trim(form.DtEmailValSent) is not "" and (trim(form.OldEMail) is trim(form.EMail))>
                                <cfprocparam type="In"  cfsqltype="cf_sql_TimeStamp" dbvarname="@DtEmailValSent" value="#trim(form.DtEmailValSent)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_TimeStamp" dbvarname="@DtEmailValSent" null="Yes">
                            </cfif>
                            <cfif trim(TmpVendorAdmin) is "Y">
                                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@VendorAdmin" value="#trim(TmpVendorAdmin)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@VendorAdmin" value="N">
                            </cfif>                               
                            <cfif trim(form.Inactive) is "Yes">
                                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@ActiveCd" value="I">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@ActiveCd" value="A">
                            </cfif>
                            <cfif TmpVendorAdmin is "Y">
                                <cfif TmpPaymentNotification is "Y">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                    <cfif TmpNotificationType is "Text">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                        <cfif TmpAreaCode is not "">
                                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                        <cfelse>
                                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                        </cfif>
                                        <cfif TmpPhonePrefix is not "">
                                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                        <cfelse>
                                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                        </cfif>
                                        <cfif TmpPhoneSuffix is not "">
                                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                        <cfelse>
                                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                        </cfif>
                                    <cfelse>
                                        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>
                                
                                <cfelse>
                                    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                                
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                            </cfif>
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@ModifiedBy" value="#Session.Email#">
                            <cfprocparam type="In"  cfsqltype="cf_sql_TimeStamp" dbvarname="@DtModified" value="#DateFormat(Now(),"mm/dd/yyyy")#">
                            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="UpdtVendorUserInfoRetVal">
                            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="UpdtVendorUserInfoRetMsg">
                            <cfprocresult name="UpdtVendorUserInfo">
                        </cfstoredproc>
                        
                        <cfif UpdtVendorUserInfoRetVal eq 0>
                            <cfif trim(form.EMail) is not trim(form.OldEMail)>
                                <!--- Check to see if we need to send out a "Verify Your E-Mail" --->        
                                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserInfo">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                                    <cfif trim(Session.Number_Code) is "4">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
                                    <cfelse>
                                        <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
                                    </cfif>
                                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUserInfoRetVal">
                                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GEtUserInfoRetMsg">
                                    <cfprocresult name="GetUserInfo">
                                </cfstoredproc>
                                <cfif trim(GetUserInfo.DtEmailValidated) is "">
                                    <div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                                    <b>Thank You, #trim(form.FirstName)# #trim(form.LastName)# for modifying your registration information with us on #DateFormat(Now(),"mm/dd/yyyy")# for the Vendor Remittance Site!<br><br>Since you have changed your E-Mail address, you will be receiving a Confirmation E-Mail from us shortly.  Please open the E-Mail and click on the "Verify E-Mail Address" hyperlink to validate your E-Mail.  If you do NOT receive the E-Mail, please check your "Junk E-Mail" folder.  After validating your E-Mail, you will be given the opportunity to create your password.  Once you have successfully created your password, you will be ready to use the Secure Enhanced Vendor Remittance Site!<cfif trim(GetUserInfo.MobileApp) is "Y" and trim(TmpOldMobileApp) is "N">  You also have been registered to use IOC mobile app<!--- for the #TmpMobileAppType#--->.  Your API number has been sent to you in the Registration Updated E-Mail.<br><br />This API is your User Id for the mobile app.<br /></cfif></b>
                                    </div>

                                    <!--- Create Password --->
                                    <CFMail 
                                    TO="#trim(form.EMail)#"
                                    from="#application.VendorRemitEmail#"
                                    subject="Secure Enhanced Vendor Remittance Updated Registration"
                                    type="html">
                                    <P>This is an automated E-Mail sent to you by the Illinois Office of the Comptroller.  It is being sent to you from the State of Illinois Comptroller's Secure Enhanced Vendor Remittance Site.<br><br><b>Your registered as a user of this site has been updated.</b>.<br><br>Please click on <a href="#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ValidateEmail=Yes&TaxpayerInfoNo=#urlEncodedformat(Session.VendTIN)#&Email=#urlEncodedFormat(form.EMail)#&Number_Code=#urlEncodedFormat(Number_Code)#">Verify E-Mail Address</a> to verify that you have received this E-Mail.  If the "Verify E-Mail Address" link does not work, you will need to copy and paste this link into your Internet Browser's Internet Site Address. http://#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ValidateEmail=Yes&TaxpayerInfoNo=#urlEncodedformat(Session.VendTIN)#&Email=#urlEncodedFormat(form.EMail)#&Number_Code=#urlEncodedFormat(Number_Code)#<br /><br />This E-Mail address is your User Id for the Enhanced Vendor Site. If you have received this E-Mail by mistake, please contact our office at <a href="Mailto:#application.SecAdmEmail#?Subject=Secure Enhanced Vendor Remittance Registration">#application.SecAdmEmail#</a> or contact our office at #application.SecAdmPhone#.  You must verify your E-Mail address, since it has changed since the last time you had been registered. <br /><br />After you have clicked the link above, you will be given the opportunity to create a password.  While doing so, please remember passwords must be 6-25 characters.  To ensure your company's remittance information is kept private, passwords expire every 30 days.  When this happens you will be redirected automatically to a Web page that allows you to create a new password for the next 30-day period.  You must not reuse a password from the last 10 times you have changed it.
                    
                                    <br><br>
                                    Thank You,
                                    <br><br><Br><Br>
                                    Illinois Office of the Comptroller</P>
                                    </cfmail>
                                
                                   
                                <cfelse>
                                
                                    <div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                                    <b>Thank You, #trim(form.FirstName)# #trim(form.LastName)# for modifying your registration information with us on #DateFormat(Now(),"mm/dd/yyyy")# for the Vendor Remittance Site!<br /><Br />You are now ready to use the Secure Enhanced Vendor Remittance Site!</b>
                                    </div>

                                </cfif>
                                
                            <cfelse>
                                <!--- Check to see if we need to send out an email for new mobile user --->      
                                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserInfo">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                                    <cfif trim(Session.Number_Code) is "4">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
                                    <cfelse>
                                        <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
                                    </cfif>
                                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUserInfoRetVal">
                                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GEtUserInfoRetMsg">
                                    <cfprocresult name="GetUserInfo">
                                </cfstoredproc>
                                 
                                <div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                                <b>Thank You, #trim(form.FirstName)# #trim(form.LastName)# for modifying your registration information with us on #DateFormat(Now(),"mm/dd/yyyy")# for the Vendor Remittance Site!<br /><Br />You are now ready to use the Secure Enhanced Vendor Remittance Site!</b>
                                </div>

                             </cfif>
                             
                        <cfelse>
                            <div class="text-danger"><b>#UpdtVendorUserInfoRetMsg#</b></div>
                        </cfif>
                   </cfif>
                </cfif>
            <cfelse>
                
                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_VendorRemit">
               		<cfif trim(form.EMail) is not "">
                    	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                	<cfelse>
                    	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" null="yes">
                	</cfif>
                    <cfif trim(Session.VendTIN) is not "">
                    	<cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                	<cfelse>
                    	<cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNO" null="yes">
                	</cfif>
                    <cfif trim(Session.Number_Code) is "4">
                        <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
                    <cfelse>
                        <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
                    </cfif>
                	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckVendorRemit2RetVal">
                	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckVendorRemit2RetMsg">
                	<cfprocresult name="CheckVendorRemit2">
           	 	</cfstoredproc>
                
                <cfif CheckVendorRemit2RetVal eq 0>
                	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                    <b>We can not Add #trim(form.FirstName)# #trim(form.LastName)# as a contact for this Vendor because the E-Mail is already being used!</b>
                    </div>
                    <cfset ErrorNo = "12">

                 <cfelse>
                            
                 	<cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_VendorUserInfo">
                    	<cfif trim(form.EMail) is not "">
                        	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                        <cfelse>
                        	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" null="yes">
                        </cfif>
                        <cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
                        <cfif trim(Session.VendTIN) is not "">
                        	<cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                        <cfelse>
                        	<cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNO" null="yes">
                        </cfif>
                        <cfif trim(Session.Number_Code) is "4">
                        	<cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
                        <cfelse>
                        	<cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
                        </cfif>
                        </cfLock>
                        <cfif trim(form.FirstName) is not "">
                        	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Firstname" value="#trim(form.Firstname)#">
                        <cfelse>
                        	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Firstname" null="yes">
                        </cfif>
                        <cfif trim(form.LastName) is not "">
                        	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Lastname" value="#trim(form.Lastname)#">
                        <cfelse>
                        	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Lastname" null="Yes">
                        </cfif>
                        <cfif trim(TmpPhone) is not "">
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Phone" value="#trim(TmpPhone)#">
                        <cfelse>
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Phone" null="Yes">
                        </cfif>
                        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@API" null="Yes">
                        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@MobileApp" value="N">
                        <cfif trim(form.VendorAdmin) is not "">
                        	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@VendorAdmin" value="#trim(form.VendorAdmin)#">
                        <cfelse>
                        	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@VendorAdmin" value="N">
                        </cfif>
                        <cfif TmpVendorAdmin is "Y">
							<cfif TmpPaymentNotification is "Y">
                                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                <cfif TmpNotificationType is "Text">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                    <cfif TmpAreaCode is not "">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                    <cfelse>
                                        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                    </cfif>
                                    <cfif TmpPhonePrefix is not "">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                    <cfelse>
                                        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                    </cfif>
                                    <cfif TmpPhoneSuffix is not "">
                                        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                    <cfelse>
                                        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>
                                <cfelse>
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                            
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                            </cfif>
                            
                        <cfelse>
                            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                        </cfif>
						<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EnteredBy" value="#Session.Email#">
                        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="AddVendorUserInfoRetVal">
                        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="AddVendorUserInfoRetMsg">
                        <cfprocresult name="AddVendorUserInfo">
                     </cfstoredproc>
                        
                     <cfif AddVendorUserInfoRetVal eq 0>
                     
                        <!--- Check to see if we need to send out a "Verify Your E-Mail" --->        
                        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserInfo">
                            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                            <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                            <cfif trim(Session.Number_Code) is "4">
                                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="yes">
                            </cfif>
                            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUserInfoRetVal">
                            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GEtUserInfoRetMsg">
                            <cfprocresult name="GetUserInfo">
                        </cfstoredproc>
                        
                        <cfif trim(GetUserInfo.DtEmailValidated) is "">
                        
                            <div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                            <b>Thank You, #trim(form.FirstName)# #trim(form.LastName)# for registering with us on #DateFormat(Now(),"mm/dd/yyyy")# for the Vendor Remittance Site!<br><br>You will be receiving a Confirmation E-Mail from us shortly.  Please open the E-Mail and click on the "Verify E-Mail Address" hyperlink to validate your E-Mail.  If you do NOT receive the E-Mail, please check your "Junk E-Mail" folder.  After validating your E-Mail, you will be given the opportunity to create your password.  Once you have successfully created your password, you will be ready to use the Secure Enhanced Vendor Remittance Site! </b>
                            </div>
                           
                           <!--- Create Password --->                
                           <CFMail 
                            TO="#trim(form.EMail)#"
                            from="#application.VendorRemitEmail#"
                             subject="Secure Enhanced Vendor Remittance Registration"
                              type="html">
                             <P>This is an automated E-Mail sent to you by the Illinois Office of the Comptroller.  It is being sent to you from the State of Illinois Comptroller's Secure Enhanced Vendor Remittance Site.<br><br><b>You have been registered as a user of this site.</b><br><br>Please click on   <a href="#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ValidateEmail=Yes&TaxpayerInfoNo=#urlEncodedformat(Session.VendTIN)#&Email=#urlEncodedFormat(form.EMail)#&Number_Code=#urlEncodedFormat(Session.Number_Code)#">Verify E-Mail Address</a> to verify that you have received this E-Mail.  If the "Verify E-Mail Address" link does not work, you will need to copy and paste this link into your Internet Browser's Internet Site Address. http://#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ValidateEmail=Yes&TaxpayerInfoNo=#urlEncodedformat(Session.VendTIN)#&Email=#urlEncodedFormat(form.EMail)#&Number_Code=#urlEncodedFormat(Session.Number_Code)#<br /><br />This E-Mail address is your User Id for the Enhanced Vendor Site.  If you have received this E-Mail by mistake, please contact our office at <a href="Mailto:#application.SecAdmEmail#?Subject=Secure Enhanced Vendor Remittance Registration">#application.SecAdmEmail#</a> or contact our office at #application.SecAdmPhone#.  You must verify your E-Mail address before you will be given the chance to create your personal password for the site.<br /><br />After you have clicked the link above, you will be given the opportunity to create a password.  While doing so, please remember passwords must be 6-25 characters.  To ensure your company's remittance information is kept private, passwords expire every 30 days.  When this happens you will be redirected automatically to a Web page that allows you to create a new password for the next 30-day period.  You must not reuse a password from the last 10 times you have changed it.  You will not be able to log into the Secure Enhanced Vendor Remittance Site until both steps have been completed.<br /><br /><b>ATTENTION USER COORDINATORS:</b> Did you know the IOC can alert you when state payments are on the way? You and any additional users can choose to receive either an SMS text message or an E-Mail the morning after your warrants are issued. Messages contain the vendor's name, the payment(s) amount, and an anticipated deposit date. Standard text message rates may apply. Click on "Manage Accounts" once you have logged in to the Secure Enhanced Vendor Remittance Site to activate Payment Notifications.<br />

							<br><br>
                            Thank You,
                            <br><br><Br><Br>
                            Illinois Office of the Comptroller</P>
                             </cfmail>

                     	 <Cfelse>
                         	<div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                            <b>Thank You, #trim(form.FirstName)# #trim(form.LastName)# for registering with us on #DateFormat(Now(),"mm/dd/yyyy")# for the Vendor Remittance Site!<br><br>You are now ready to use the Secure Enhanced Vendor Remittance Site!</b>
                            </div>
                            
                        </cfif>

                      <br /><hr color="black" width="100%" /><br />
                     <cfelse>
                     	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                        <b>#AddVendorUserInfoRetMsg#</b>
                        </div>
                   </cfif>
            </cfif>
    	</cfif>
	</cfif>
	</cfoutput>
    
</cfif>

<head>
<title>Secure Enhanced Vendor Remittance Registration</title>
</head>

<div onLoad="Javascript:MakeMouseCursorPointer(); ChangeCoordinator(); ChangeMobileApp();">

<cfset DisplayvendorRecord = False>

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<cfif trim(Session.VendTIN) is not "">

	<cfset x = 0>
	<cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_VendorUsersInfoNONIOC">
		<cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.vendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
        <cfif Session.Number_Code is "4">
        	<cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
        <cfelse>
        	<cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="Yes">
        </cfif>
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetVendorUsersInfoRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetVendorUsersInfoRetMsg">
		<cfprocresult name="GetVendorUsersInfo">
	</cfstoredproc>
    
	<cfif GetVendorUsersInfo.recordcount gt 0 and url.NewPage is "False">
		<cfset DisplayvendorRecord = True>
        
        <cfset LastRec = "#GetVendorUsersInfo.recordcount#">
		<cfset LastPage=#GetVendorUsersInfo.recordcount#/20>
        
        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_NoVendorCoordinator">
			<cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#decrypt(Session.vendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
            <cfif Session.Number_Code is "4">
                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="4">
            <cfelse>
                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@Number_Code" null="Yes">
            </cfif>
			<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
			<cfprocresult name="CheckNoVendorCoordinator">
		</cfstoredproc>
	</cfif>

</cfif>
</cfLock>
<CFINCLUDE TEMPLATE="VendHeader.cfm">
<cfif DisplayvendorRecord is True>

<form role="form" class="form-horizontal" name="VR" action="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?ValUser=True<cfif IsDefined("URL.NewPage")>&NewPage=True
</cfif>"  method="post">
<cfset TabNo = 4>
<!--- Update Form --->

	<cfoutput>
	<div class="form-group">
    	<div class="col-sm-4">
        	<b>Remember: All fields are required!</b>
        </div>
        <div class="col-sm-8">
        	<center><a href="javascript:Instructions()"><b>Instructions</b></a></center>
        </div>
    </div>
	<div class="form-group">
        <div class="col-sm-12">
        <label for="VendTIN" id="UserId" class="control-label"><b><i>Taxpayer Identification No&nbsp;&nbsp;&nbsp;</i></b></label>
            <cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
             <cfif Session.Number_Code is "4">
                    #decrypt(Session.vendTIN, application.theKey, application.theAlgor, application.TheEncode)#
                <cfelse>
                    * * * * * * #Right(decrypt(Session.vendTIN, application.theKey, application.theAlgor, application.TheEncode),3)#
                 </cfif> </cfLock>
         &nbsp;&nbsp;&nbsp;(Format: 999999999)
        </div>
    </div>
	<div class="text-center marginb20">
    	<button name="Add" id="Addbtn" VALUE="Add" tabIndex="3" class="btn btn-primary">Add/Modify/E-Mail Verification</button>
    </div>

	<div class="text-center marginb30"><cfinclude template="NavUserAccessReq.cfm"></div>

	<cfset x=#url.StartRec#>
	<cfloop  query="GetVendorUsersInfo" startrow="#url.StartRec#" endrow="#url.StartRec#">
    	<cfif not(GetVendorUsersInfo.Email contains "@IllinoisComptroller.Gov")>
			  <div class="form-group">
              	    <input type="hidden" name="EntryType" value="Update">
                    <input type="hidden" name="OldEMail" value="#GetVendorUsersInfo.EMail#" />
                    <input type="hidden" name="OldMobileApp" value="N" />
                    <input type="hidden" name="MobileApp" value="N" />
                     <input type="hidden" name="OldVendorAdmin" value="#GetVendorUsersInfo.VendorAdmin#" />
                    <input type="hidden" name="OldLastName" value="#GetVendorUsersInfo.LastName#" />
                    <input type="hidden" name="OldFirstName" value="#GetVendorUsersInfo.FirstName#" />
                    <input type="hidden" name="OldDtModified" value="#GetVendorUsersInfo.DtModified#" />
                    <cfLock Scope="SESSION" TIMEOUT="100" type="readonly">
                        <input type="hidden" name="ModifiedBy"  value="#Session.Email#" />
                    </cfLock>
                    <input type="hidden" name="OldPaymentNotification" value="#GetVendorUsersInfo.PaymentNotification#"
                    <input type="hidden" name="OldCellProvider" value="#GetVendorUsersInfo.CellProvider#" />
                    <input type="hidden" name="OldAreaCode" value="#GetVendorUsersInfo.AreaCode#" />
                    <input type="hidden" name="OldPhonePrefix" value="#GetVendorUsersInfo.PhonePrefix#" />
                    <input type="hidden" name="OldPhoneSuffix" value="#GetVendorUsersInfo.PhoneSuffix#" />
                    <input type="hidden" name="OldContactPhone" value="#GetVendorUsersInfo.Phone#" />
                    <input type="hidden" name="OldDtEmailReturned" value="#GetVendorUsersInfo.DtEmailReturned#" />
                    <input type="hidden" name="OldDtTextReturned" value="#GetVendorUsersInfo.DtTextReturned#" />
                    <cfif GetVendorUsersInfo.Status is not "A">
                        <input type="hidden" name="Inactive" value="Yes" />
                        <input type="hidden" name="OldInactive" value="Yes" />
                    <cfelse>
                        <input type="hidden" name="OldInactive" value="No" />
                        <input type="hidden" name="Inactive" value="NO" />
                    </cfif>
                <div class="col-sm-3 col-md-2">
                	<label for="FirstName" id="lblFirstName" class="control-label">#x#) First Name </label>
                </div>
                <div class="col-sm-3 col-md-4">
                    	<input type="text" name="FirstName" <cfif not listfind(ErrorNo,"4")>id ="FirstName"<cfelse>id ="FirstNameRed"</cfif> class="form-control"  size="15" maxlength="25" tabindex="#TabNo#"  value="#GetVendorUsersInfo.FirstName#"><cfset TabNo = TabNo + 1>
                </div>
                <div class="col-sm-3 col-md-2">
                	<label for="LastName" id="lblLastName" class="control-label">Last Name</label>
                </div>
                <div class="col-sm-3 col-md-4">
                		<input type="text" name="LastName" <cfif not listfind(ErrorNo,"4")>id="LastName"<cfelse>id="LastNameRed"</cfif> class="form-control"  size="15" maxlength="25" tabindex="#TabNo#" value="#GetVendorUsersInfo.LastName#"><cfset TabNo = TabNo + 1>
                </div>
 			</div>
            <div class="form-group">
				<cfset NoColSkip = 0>
				<cfif (GetVendorUsersInfo.VendorAdmin is "Y" and CheckNoVendorCoordinator.CoordinatorCount gt 1) or (GetVendorUsersInfo.VendorAdmin is not "Y" )>		
                	<div class="col-sm-4 col-md-3">
						<cfset TabNo = TabNo + 1>
                        <button name="Delete" id="Delete" VALUE="Delete User" tabIndex="#TabNo#" class="btn btn-primary btn-sm btn-block nomargin">Delete User</button>
                    </div>
                 <cfelse>
                 	<cfset NoColSkip = NoColSkip + 3>
                 </cfif>
				 <cfif trim(GetVendorUsersInfo.DtEmailValidated) is not "">
                    <div class="col-sm-4 col-md-3 mt10">
                    <cfset TabNo = TabNo + 1>
                    <button name="ResetPassword" id="Reset" VALUE="Reset Password" tabIndex="#TabNo#" class="btn btn-primary btn-sm btn-block nomargin">Reset Password</button>
                    </div>
                 <Cfelse>
                 	<cfset NoColSkip = NoColSkip + 3>
                 </cfif>  

				 <cfif trim(GetVendorUsersInfo.DtEmailvalidated) is "">
                    <div class="col-sm-4 col-md-3">
						<cfset TabNo = TabNo + 1>
                        <button name="ValidateEmail" id="Validate" VALUE="Validate E-Mail" tabIndex="#TabNo#" class="btn btn-primary btn-sm btn-block">Re-Send Out validate E-Mail</button>
                    </div>
                 <cfelse>
                 	<cfset NoColSkip = NoColSkip + 3>

                 </cfif><cfset ClassVal = "col-sm-" & #NoColSkip#>
                 <cfif NoColSkip gt 0><div class="#ClassVal#">&nbsp;</div></cfif>
       		</div>

      		<div class="form-group">
                <div class="col-sm-3 col-md-2">
                    <cfif trim(getvendorusersinfo.DtEmailreturned) is not "">
                      	<label for="E-Mail" class="control-label text-danger">*** E-Mail </label>
                    <cfelse>
                    	<label for="E-Mail" class="control-label">E-Mail </label>  
                    </cfif>
               	</div>
                <div class="col-sm-3 col-md-4">
                    <input type="email" <cfif not listfind(ErrorNo,"1") and not listfind(ErrorNo,"4") and not listfind(ErrorNo,"5") and not listfind(ErrorNo,"6") and not listfind(ErrorNo,"10") and not listfind(ErrorNo,"12")>id="Email"<cfelse>id="EmailRed"</cfif> class="form-control"  name="Email" size="25" maxlength="50" tabindex="#TabNo#"  value="#GetVendorUsersInfo.EMail#"><cfset TabNo = TabNo + 1>
                </div>
                <div class="col-sm-3 col-md-2">
                    <label for="ContactPhone"  class="control-label">Contact Phone </label>
                </div>
                <div class="col-sm-3 col-md-4">
                    <input type="tel" class="form-control" message"Invalid Contact Phone Format.  Please re-enter it in the format of (999) 999-9999."  id="ContactPhone" placeholder="(999) 999-9999" name="Contact_phone" value="#GetVendorUsersInfo.Phone#">
                </div>
            </div>
            <!--- Added per SR15160 --->

        	<div class="form-group">
                <div class="col-sm-12"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                    <a href="/vendors/enhanced-vendor-remittance/find-smtp-email-status/?TargetEmail=#urlEncodedFormat(GetVendorUsersInfo.Email)#&Number_Code=#Session.Number_Code#">Find User Email Status (Last 60 Days)</a>
				</div>
            </div>
            <div class="form-group">
                <div class="col-sm-3 col-md-2"><label for="Coordinator" class="control-label">Coordinator</label> </div>
                <div class="col-sm-3 col-md-4">
                     	<input type="radio" name="VendorAdmin" <cfif not listfind(ErrorNo,"2") and not listfind(ErrorNo,"3")>id="CoordinatorY"<cfelse>class="has-error" id="CoordinatorYRed"</cfif>  value="Y" tabindex="#TabNo#" <cfif GetVendorUsersInfo.VendorAdmin is "Y"> checked</cfif> OnClick="ChangeCoordinator()">&nbsp;Yes
                    	<cfset TabNo = TabNo + 1>
                    	<input class="marginl15" type="radio" name="VendorAdmin" value="N"  <cfif not listfind(ErrorNo,"2") and not listfind(ErrorNo,"3")>id="CoordinatorN"<cfelse>class="has-error" id="CoordinatorNRed"</cfif> tabindex="#TabNo#" <cfif GetVendorUsersInfo.VendorAdmin is not "Y"> checked</cfif> OnClick="ChangeCoordinator()">
            			<cfset TabNo = TabNo + 1>&nbsp;No
                </div>
                <div class="col-sm-3 col-md-2">
                    <label for="PaymentNotification" class="control-label">Payment Notification?</label>
                </div>
                <div class="col-sm-3 col-md-4">
                    	<input type="radio" name="PaymentNotification" value="Y" id="PaymentNotificationY"  tabindex="#TabNo#" <cfif GetVendorUsersInfo.PaymentNotification is "Y">checked</cfif> OnClick="ChangeCoordinator()" >
                    <cfset TabNo = TabNo + 1>&nbsp;Yes
                    	<input class="marginl15" type="radio" name="PaymentNotification" id="PaymentNotificationN" value="N" tabindex="#TabNo#" <cfif GetVendorUsersInfo.PaymentNotification is not "Y">checked</cfif> OnClick="ChangeCoordinator()" >
                    	<cfset TabNo = TabNo + 1>No
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-3 col-md-2">
                	<label for="TypeNotification" class="control-label">Type of Notification</label>
                </div>
                <div class="col-sm-3 col-md-4">
                    <select name="NotificationType" <cfif listfind(ErrorNo,"9")>class="form-control  has-error"<cfelse>class="form-control"</cfif> id="NotificationType" onchange="ChangeCoordinator()">
                        <option value="None" <cfif GetVendorUsersInfo.NotificationType is "None" or PaymentNotification is "N">selected</cfif>>None</option>
                         <option value="EMail" <cfif GetVendorUsersInfo.NotificationType is "EMail">selected</cfif>>EMail</option>
                        <option value="Text" <cfif GetVendorUsersInfo.NotificationType is "Text">selected</cfif>>Text</option>
                     </select><cfset TabNo = TabNo + 1>
                </div>
                <div class="col-sm-3 col-md-2">
                    <cfif trim(GetVendorUsersInfo.DtTextreturned) is not "">
                       <label for="CellProvider" class="control-label text-danger">*** Cell Provider</label>
                    <cfelse>
                    	 <label for="CellProvider" class="control-label">Cell Provider</label>
                    </cfif>
                </div>
                <div class="col-sm-3 col-md-4">
                    <select name="CellProvider" <cfif listfind(ErrorNo,"7") or listfind(ErrorNo,"8")>class="form-control  has-error"<cfelse>class="form-control"</cfif> id="CellProvider" OnClick="ChangeCoordinator()">
                        <option value="None" <cfif GetVendorUsersInfo.CellProvider  is "None" or PaymentNotification is "N">selected</cfif>>None</option>
                        <option value="ATT" <cfif GetVendorUsersInfo.CellProvider  is "ATT">selected</cfif>>AT&amp;T</option>
                        <option value="Boost" <cfif GetVendorUsersInfo.CellProvider is "Boost">selected</cfif>>Boost</option>
                		<option value="Cricket" <cfif GetVendorUsersInfo.CellProvider is "Cricket">selected</cfif>>Cricket</option>
                        <option value="Sprint PCS" <cfif GetVendorUsersInfo.CellProvider  is "Sprint PCS">selected</cfif>>Sprint</option>
                        <option value="T-Mobile" <cfif GetVendorUsersInfo.CellProvider  is "T-Mobile">selected</cfif>>T-Mobile</option>
                        <option value="U.S. Cellular" <cfif GetVendorUsersInfo.CellProvider  is "U.S. Cellular">selected</cfif>>U.S. Cellular </option>
                        <option value="Verizon" <cfif GetVendorUsersInfo.CellProvider is "Verizon">selected</cfif>>Verizon</option>
                        <option value="Virgin Mobile" <cfif GetVendorUsersInfo.CellProvider  is "Virgin Mobile">selected</cfif>>Virgin Mobile </option>
                    </select><cfset TabNo = TabNo + 1>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-3 col-md-2">
                    <cfif trim(GetVendorUsersInfo.DtTextreturned) is not "">
                        <label for="CellPhone" class="control-label text-danger">*** Cell Phone</label>
                    <cfelse>
                    	<label for="CellPhone" class="control-label">Cell Phone</label>
                    </cfif>
                </div>
                <div class="col-sm-3 col-md-4">
                    <cfset TmpPhone = "#getvendorusersinfo.AreaCode#" & "#getvendorusersinfo.PhonePrefix#" & "#getvendorusersinfo.PhoneSuffix#">
					<input type="tel" class="form-control"  <cfif listfind(ErrorNo,"7")>id="CellPhone2Red" <cfelse>id="CellPhone2" </cfif>placeholder="(999) 999-9999" name="CellPhone"  value="#TmpPhone#" tabindex="14">
					<cfset TabNo = TabNo + 1>
                </div>
            </div>

            <cfif trim(getvendorusersinfo.DtEmailreturned) is not "" or trim(GetVendorUsersInfo.DtTextreturned) is not "">
                <div class="form-group">
                	<div class="col-sm-12">   
                    <p class="text-danger"><b>***E-Mail/Text has been marked as not being deliverable!  If you are requesting a notification by Email, please supply us with a correct validated Email.  If you are requesting a notification by Text, please supply us with your correct Cell Phone Provider and Cell Phone Number.</b></p>
                    </div>
                </div>
            </cfif>
            <div class="form-group">
                <div class="col-sm-4 col-md-3">Date Validated E-Mail Sent</div>
                <div class="col-sm-8 col-md-9"><input type="hidden" name="DtEmailValSent" value="#DateFormat(GetVendorUsersInfo.DtEmailValSent,"mm/dd/yyyy")#" tabindex="#TabNo#" /><font color="black">#DateFormat(GetVendorUsersInfo.DtEmailValSent,"mm/dd/yyyy")#</font><cfset TabNo = TabNo + 1>
                </div>
            </div>
            <div class="form-group">
            	<div class="col-sm-4 col-md-3">Date E-Mail Validated</div>
                <div class="col-sm-8 col-md-9"><input type="hidden" name="DtEmailValidated" value="#DateFormat(GetVendorUsersInfo.DtEmailValidated,"mm/dd/yyyy")#" tabindex="#TabNo#" /><font color="black">#DateFormat(GetVendorUsersInfo.DtEmailValidated,"mm/dd/yyyy")#</font><cfset TabNo = TabNo + 1>
                </div>
            </div>
            <div class="form-group">
            	<div class="col-sm-4 col-md-3">Date Password Changed</div>
                <div class="col-sm-8 col-md-9"><input type="hidden" name="DtPasswordChged" value="#DateFormat(GetVendorUsersInfo.DtPasswordChged,"mm/dd/yyyy")#" tabindex="#TabNo#" /><font color="black">#DateFormat(GetVendorUsersInfo.DtPasswordChged,"mm/dd/yyyy")#</font><cfset TabNo = TabNo + 1>
                </div>
            </div>
            <cfif trim(getvendorusersinfo.DtEmailreturned) is not "">
                <div class="form-group">
                	<div class="col-sm-4 col-md-3">
                    <p class="text-danger"><b>***Date Email Returned</b></p>
                    </div>
                    <div class="col-sm-8 col-md-9"><font color="black">#DateFormat(GetVendorUsersInfo.DtEmailReturned,"mm/dd/yyyy")#</font>
                    </div>
                </div>
            </cfif>
            <cfif trim(GetVendorUsersInfo.DtTextreturned) is not "">
                <div class="form-group">
                	<div class="col-sm-4 col-md-3">
                    <p class="text-danger"><b>***Date Text Returned</b></p>
                    </div>
                    <div class="col-sm-8 col-md-9"><font color="black">#DateFormat(GetVendorUsersInfo.DtTextReturned,"mm/dd/yyyy")#</font>
                    </div>
               </div>
			</cfif>
		</cfif>
    </cfloop>

	<div class="text-center">
    	<button name="Add" id="Addbtn2" VALUE="Add" tabIndex="3" class="btn btn-primary">Add/Modify/E-Mail Verification</button>
    </div>
	
   </cfoutput> 
   </form>

 <!--- Add Form --->
<cfelse>

	
    <form role="form" class="form-horizontal" name="VR" action="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?ValUser=True<cfif IsDefined("URL.NewPage")>&NewPage=True
</cfif>"  method="post">
    <cfset TabNo = 4>
    <!--- Update Form --->
    <cfif GetVendorUsersInfo.recordcount>
    	<cfset x = #GetVendorUsersInfo.recordcount# + 1>
    <cfelse>
		<cfset x = x+1>
    </cfif>
        <cfoutput>
        <div class="form-group">
            <div class="col-sm-4">
                <b>Remember: All fields are required!</b>
            </div>
            <div class="col-sm-8">
                <div class="text-center"><a href="javascript:Instructions()"><b>Instructions</b></a></div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-12">
                <label for="VendTIN" id="UserId" class="control-label"><b><i>Taxpayer Identification No&nbsp;&nbsp;&nbsp;</i></b></label>
                    <cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
                    <cfif Session.Number_Code is "4">
                    	#decrypt(Session.vendTIN, application.theKey, application.theAlgor, application.TheEncode)#
                    <cfelse>
                    	* * * * * * #Right(decrypt(Session.vendTIN, application.theKey, application.theAlgor, application.TheEncode),3)#
                     </cfif>   
                  </cfLock>
                 &nbsp;&nbsp;&nbsp;(Format: 999999999)
            </div>
        </div>
        <div class="text-center marginb20">
    	<button name="Add" id="Addbtn" VALUE="Add" tabIndex="3" class="btn btn-primary">Add/Modify/E-Mail Verification</button>
			<cfif GetVendorUsersInfo.recordcount>
                <button name="Cancel" id="Cancelbtn" VALUE="Cancel" tabIndex="3" class="btn btn-primary">Cancel</button>
        	</cfif>
    	</div>
        <div class="form-group">
        	<input type="hidden" name="EntryType" value="Add">
            <input type="hidden" name="OldEMail" value="" />
            <input type="hidden" name="OldMobileApp" value="N" />
             <input type="hidden" name="OldVendorAdmin" value="N" />
            <input type="hidden" name="OldLastName" value="" />
            <input type="hidden" name="OldFirstName" value="" />
            <input type="hidden" name="OldDtModified" value="" />
            <cfLock Scope="SESSION" TIMEOUT="100" type="readonly">
                <input type="hidden" name="ModifiedBy"  value="#Session.Email#" />
            </cfLock>
            <input type="hidden" name="OldPaymentNotification" value=""
            <input type="hidden" name="OldCellProvider" value="" />
            <input type="hidden" name="OldAreaCode" value="" />
            <input type="hidden" name="OldPhonePrefix" value="" />
            <input type="hidden" name="OldPhoneSuffix" value="" />
            <input type="hidden" name="OldContactPhone" value="" />
            <input type="hidden" name="OldDtEmailReturned" value="" />
            <input type="hidden" name="OldDtTextReturned" value="" />
            <div class="col-sm-3 col-md-2">
                <label for="FirstName" id="lblFirstName" class="control-label">#x#) First Name</label>
            </div>
            <div class="col-sm-3 col-md-4">
            	<div <cfif listfind(ErrorNo,"4")>class="has-error"<cfelse></cfif>>
            		<input type="text" class="form-control"  name="FirstName" <cfif not listfind(ErrorNo,"4")>id="FirstName"<cfelse>id="FirstNameRed" value="#form.FirstName#"</cfif> size="15" maxlength="25" tabindex="#TabNo#"><cfset TabNo = TabNo + 1>
                </div>
            </div>
            <div class="col-sm-3 col-md-2">
                <label for="LastName" id="lblLastName" class="control-label">Last Name</label>
            </div>
            <div class="col-sm-3 col-md-4">
            	<div <cfif listfind(ErrorNo,"4")>class="has-error"<cfelse></cfif>>
            		<input type="text" class="form-control"  name="LastName" <cfif not listfind(ErrorNo,"4")>id="LastName"<cfelse>id="LastNameRed" value="#form.LastName#"</cfif> size="15" maxlength="25" tabindex="#TabNo#" ><cfset TabNo = TabNo + 1>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-3 col-md-2">
                <label for="E-Mail" class="control-label">E-Mail </label>
            </div>
            <div class="col-sm-3 col-md-4">
            	<div <cfif listfind(ErrorNo,"1") or listfind(ErrorNo,"4") or listfind(ErrorNo,"5") or listfind(ErrorNo,"6") or listfind(ErrorNo,"10") or listfind(ErrorNo,"12")>class="has-error"<cfelse></cfif>>
                	<input type="email" class="form-control" <cfif not listfind(ErrorNo,"1") and not listfind(ErrorNo,"4") and not listfind(ErrorNo,"5") and not listfind(ErrorNo,"6") and not listfind(ErrorNo,"10") and not listfind(ErrorNo,"12")>id="Email"<cfelse>id="EmailRed" value="#form.Email#"</cfif> name="Email" size="25" maxlength="50" tabindex="#TabNo#" ><cfset TabNo = TabNo + 1>
               	</div>
            </div>
            <div class="col-sm-3 col-md-2">
                <label for="ContactPhone" class="control-label">Contact Phone</label>
            </div>
            <div class="col-sm-3 col-md-4">
                    <input type="Tel" class="form-control" id="ContactPhone" placeholder="(999) 999-9999" name="Contact_Phone" <cfif IsDefined("form.Contact_Phone") AND form.Contact_Phone NEQ "">value="#form.Contact_Phone#"</cfif> tabindex="#TabNo#"><cfset TabNo = TabNo + 1>
            </div>
        </div>
    <div class="form-group">
        <div class="col-sm-3 col-md-2">
        	<label for="Coordinator" class="control-label">Coordinator</label>
        </div> 
        <div class="col-sm-3 col-md-4">
        		<input type="radio" name="VendorAdmin" value="Y"  <cfif IsDefined("form.VendorAdmin") AND  form.VendorAdmin EQ "Y">checked</cfif>  <cfif not listfind(ErrorNo,"2") and not listfind(ErrorNo,"3")>id="CoordinatorY"<cfelse>class="has-error" id="CoordinatorYRed"</cfif> tabindex="#TabNo#" OnClick="ChangeCoordinator()"><cfset TabNo = TabNo + 1>&nbsp;Yes
            	<input type="radio" name="VendorAdmin" value="N" class="marginl15" <cfif IsDefined("form.VendorAdmin") AND form.VendorAdmin EQ "N">checked</cfif> <cfif Not IsDefined("form.VendorAdmin")>checked</cfif> <cfif not listfind(ErrorNo,"2") and not listfind(ErrorNo,"3")>id="CoordinatorY"<cfelse>class="has-error"  id="CoordinatorYRed"</cfif>  tabindex="#TabNo#"  OnClick="ChangeCoordinator()"><cfset TabNo = TabNo + 1>&nbsp;No
        </div>
        <div class="col-sm-3 col-md-2">
            <label for="PaymentNotification" class="control-label">Payment Notification?</label>
        </div>
        <div class="col-sm-3 col-md-4">
            	<input type="radio" name="PaymentNotification" <cfif IsDefined("form.VendorAdmin") AND form.VendorAdmin EQ "N"> disabled <cfelseif Not IsDefined("form.VendorAdmin")> disabled </cfif>  id="PaymentNotificationY" value="Y" tabindex="#TabNo#" OnClick="ChangeCoordinator()" <cfif IsDefined("form.PaymentNotification") AND  form.PaymentNotification EQ "Y">checked</cfif> ><cfset TabNo = TabNo + 1>&nbsp;Yes
                <input class="marginl15" type="radio" name="PaymentNotification" <cfif IsDefined("form.PaymentNotification") AND form.PaymentNotification EQ "N">checked</cfif> <cfif IsDefined("form.VendorAdmin") AND form.VendorAdmin EQ "N"> disabled <cfelseif Not IsDefined("form.VendorAdmin")> disabled </cfif>  id="PaymentNotificationN"  value="N"  tabindex="#TabNo#" OnClick="ChangeCoordinator()" ><cfset TabNo = TabNo + 1>&nbsp;No
       	</div>
    </div>
    <div class="form-group">
    	<div class="col-sm-3 col-md-2">
        	<label for="TypeNotification" class="control-label">Type of Notification</label>
        </div>
        <div class="col-sm-3 col-md-4">
            <select name="NotificationType" <cfif listfind(ErrorNo,"9")>class="form-control  has-error"<cfelse>class="form-control"</cfif> <cfif IsDefined("form.VendorAdmin") AND form.VendorAdmin EQ "N"> disabled <cfelseif Not IsDefined("form.VendorAdmin")> disabled </cfif> id="NotificationType" onchange="ChangeCoordinator()">
                <option <cfif isDefined("form.NotificationType") AND form.NotificationType EQ "None"> selected</cfif> value="None">None</option>
                 <option <cfif isDefined("form.NotificationType") AND form.NotificationType EQ "EMail"> selected</cfif> value="EMail">EMail</option>
                <option <cfif isDefined("form.NotificationType") AND form.NotificationType EQ "Text"> selected</cfif> value="Text">Text</option>
             </select><cfset TabNo = TabNo + 1>
        </div>
    	<div class="col-sm-3 col-md-2">
            <label for="CellProvider" class="control-label">Cell Provider</label>
        </div>
        <div class="col-sm-3 col-md-4">
            <select name="CellProvider" <cfif listfind(ErrorNo,"7") or listfind(ErrorNo,"8")>class="form-control  has-error"<cfelse>class="form-control"</cfif> <cfif IsDefined("form.VendorAdmin") AND form.VendorAdmin EQ "N"> disabled <cfelseif Not IsDefined("form.VendorAdmin")> disabled </cfif>  id="CellProvider" OnClick="ChangeCoordinator()">
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "None"> selected</cfif> value="None">None</option>
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "ATT"> selected</cfif> value="ATT">AT&amp;T</option>
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "Boost"> selected</cfif> value="Boost">Boost</option>
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "Cricket"> selected</cfif> value="Cricket">Cricket</option>
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "Sprint PCS"> selected</cfif> value="Sprint PCS">Sprint</option>
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "T-Mobile"> selected</cfif> value="T-Mobile">T-Mobile</option>
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "U.S. Cellular"> selected</cfif> value="U.S. Cellular">U.S. Cellular </option>
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "Verizon"> selected</cfif> value="Verizon">Verizon</option>
                <option <cfif isDefined("form.CellProvider") AND form.CellProvider EQ "Virgin Mobile"> selected</cfif> value="Virgin Mobile">Virgin Mobile </option>
            </select><cfset TabNo = TabNo + 1>
        </div>
    </div>
    <div class="form-group">
    	<div class="col-sm-3 col-md-2">
            <label for="CellPhone" class="control-label">Cell Phone</label>
        </div>
        <div class="col-sm-3 col-md-4">
            <input type="tel" class="form-control" id="CellPhone2" <cfif IsDefined("form.VendorAdmin") AND form.VendorAdmin EQ "N"> disabled <cfelseif Not IsDefined("form.VendorAdmin")> disabled </cfif>  placeholder="(999) 999-9999" name="CellPhone" <cfif IsDefined("form.CellPhone") AND form.CellPhone NEQ "">value="#form.CellPhone#"</cfif>><cfset TabNo = TabNo + 1>

        </div>
    </div>  
	<div class="text-center">
    	<button name="Add" id="Addbtn2" VALUE="Add" tabIndex="3" class="btn btn-primary">Add/Modify/E-Mail Verification</button>
		<cfif GetVendorUsersInfo.recordcount>
        <button name="Cancel" id="Cancelbtn2" VALUE="Cancel" tabIndex="3" class="btn btn-primary">Cancel</button>
        </cfif>
    </div>
	
   </cfoutput> 

   </form>
</cfif>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    

<script>
	$('#First').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click this button to position yourself on the first user's record."
        });
	$('#Next').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click this button to position yourself on the next user's record."
        });
	$('#Previous').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click this button to position yourself on the previous user's record."
        });
	$('#Last').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click this button to position yourself on the last user's record."
        });
	$('#New').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click this button to be able to add a new user."
        });
	$('#Addbtn').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After you supplied us with all of your registration information, click this ADD button."
        });
	$('#Addbtn2').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After you supplied us with all of your registration information, click this ADD button."
        });	
	$('#Cancelbtn').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click this button if you want to discard the entry for the new user."
        });
	$('#Cancelbtn2').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click this button if you want to discard the entry for the new user."
        });
	$('#FirstName').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your First Name."
	});
	$('#FirstNameRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your First Name."
	});
	$('#LastName').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your Last Name."
	});
	$('#LastNameRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your Last Name."
	});
	$('#Delete').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click on the 'Delete User' button to remove this user from having access to EVR."
	});
	$('#Reset').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click on the 'Reset Password' button to reset the user's password."
	});
	$('#ReSend').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click on the 'ReSend API' button to send the API Number to the user's Email Address."
	});
	$('#Validate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click on the 'Resend Validate Your E-mail' button to send the 'Validate Your E-Mail' to the user's Email Address."
	});
	$('#RemoveMobile').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click on the 'Remove Mobile' button to remove access to the EVR Mobile App."
	});
	$('#ContactPhone').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your contact phone number in the format of (999) 999-9999."
	});
	$('#ContactPhoneRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your contact phone number in the format of (999) 999-9999."
	});
	$('#Email').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter a valid Email where your registration information will be sent."
	});
	$('#EmailRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter a valid Email where your registration information will be sent."
	});
	$('#MobileApp').tooltip({
		'show': false,
			'placement': 'top',
			'title': "You will need to answer Yes to receive your API Number which is required to log into the mobile application.  The App is available for both the Android and IPhone."
	});
	$('#PaymentNotificationY').tooltip({
		'show': false,
			'placement': 'top',
			'title': "You will need to answer Yes to receive either an Email or Text message when your Vendor receives a payment."
	});
	$('#PaymentNotificationYRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "You will need to answer Yes to receive either an Email or Text message when your Vendor receives a payment."
	});
	$('#PaymentNotificationN').tooltip({
		'show': false,
			'placement': 'top',
			'title': "You will need to answer Yes to receive either an Email or Text message when your Vendor receives a payment."
	});
	$('#PaymentNotificationNRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "You will need to answer Yes to receive either an Email or Text message when your Vendor receives a payment."
	});
	$('#NotificationType').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If you answered YES to Payment Notification, select either Email or Text."
	});
	$('#NotificationTypeRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If you answered YES to Payment Notification, select either Email or Text."
	});
	$('#CellProvider').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Since you answered Text to Type of Notification, select either Cell Phone Provider."
	});
	$('#CellProviderRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Since you answered Text to Type of Notification, select either Cell Phone Provider."
	});
	$('#CellPhone2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your cell phone number in the format of (999) 999-9999.  You are responsible for any charges your provider might charge for such text messages."
	});
	$('#CellPhone2Red').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your cell phone number in the format of (999) 999-9999.  You are responsible for any charges your provider might charge for such text messages."
	});
	$('#CoordinatorY').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Answer Yes if you would like the user to be able to add/modify/delete users for your vendor and also to receive payment notifications."
	});
	$('#CoordinatorYRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Answer Yes if you would like the user to be able to add/modify/delete users for your vendor and also to receive payment notifications."
	});
	$('#CoordinatorN').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Answer No if you do not want the user to be able to add/modify/delete users for your vendor or to be able to receive payment notifications."
	});
	$('#CoordinatorNRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Answer No if you do not want the user to be able to add/modify/delete users for your vendor or to be able to receive payment notifications."
	});
	
	$('#ContactPhone').mask("(999) 999-9999");
	$('#ContactPhone2').mask("(999) 999-9999");
	$('#CellPhone2').mask("(999) 999-9999");
	$('#CellPhone2Red').mask("(999) 999-9999");
	</script>
</div>

<!---</body>
</html>--->