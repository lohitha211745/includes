<cfparam name="max" default="20">
<cfparam name="StartRow" default="1">

<cfoutput>
<CFIF IsDefined ("form.FY") AND IsDefined ("form.FundSel") AND IsDefined ("form.AgcySel")>
    <CFSET variables.FY= form.FY>
    <CFSET variables.ShowBudg = form.ShowBudg>
    <CFSET variables.ShowExp = form.ShowExp>
    <CFSET variables.ShowMo = form.ShowMo>
    <CFSET variables.ShowLapse = form.ShowLapse>
    <CFSET variables.View = TRIM(form.View)>
    <CFSET variables.FundSel = form.FundSel>
    <CFSET variables.ShowExp = form.ShowExp>
    <CFSET variables.AgcySel = form.AgcySel>
    <CFSET variables.ApprSel = form.ApprSel>
    <CFSET variables.OrgSel = form.OrgSel>
    <CFSET variables.Obj_Exp = "">

 <cfelseif IsDefined ("URL.FY")>
    <CFSET variables.FY= URL.FY>
    <CFSET variables.ShowBudg = URL.ShowBudg>
    <CFSET variables.ShowExp = URL.ShowExp>
    <CFSET variables.ShowMo = URL.ShowMo>
    <CFSET variables.ShowLapse = URL.ShowLapse>
    <CFSET variables.View = TRIM(URL.View)>
    <CFSET variables.FundSel = URL.FundSel>
    <CFSET variables.ShowExp = URL.ShowExp>
    <CFSET variables.AgcySel = URL.AgcySel>
    <CFSET variables.ApprSel = URL.ApprSel>
    <CFSET variables.OrgSel = TRIM(URLDECODE(URL.OrgSel, 'utf-8'))>
  <CFIF IsDefined ("URL.Obj_Exp")>
    <CFSET variables.Obj_Exp = TRIM(URLDECODE(URL.Obj_Exp, 'utf-8'))>
   <cfelse>
   	<CFSET variables.Obj_Exp = "">
  </CFIF>  

<cfelse>
    <cflocation url="#cgi.REMOTE_HOST#" addtoken="no">
</CFIF>

<cfif IsDefined ("form.FormInput") AND variables.View IS "Budg">
    <CFSET ShowExp = "No">
<cfelse>
     <CFSET ShowExp = "Yes">
</cfif> 
  <div class="col-sm-offset-4 col-sm-7">
 <h1>#$.getTitle()#</h1>
 </div>
 <div class="col-sm-offset-2 col-sm-10">
   <p>The calculations below are based on the selection criteria you submitted and therefore represent only data specific to that criteria.</p>
 </div>


 <!--- Create a cookie that retains the users form submitted values  --->
    <!--- Because there is a limit to the number of cookies per domain each page that requires it gets 1 cookie per page. --->
    <!---  The cookie stores the selected values as a CSV string   --->
    <!--- Cookie CSV position legend:
    	1) FundSel
    	2) Fiscal Year
    	3) AgcySel
    	4) ApprSel
		5) View
		6) ShowMo
		7) ShowLapse
		8) OrgSel
    	 --->


     <CFIF TRIM(variables.FundSel) IS "">
        <CFSET Postion1 = "Default">
     <cfelse>
       <CFSET Postion1 = variables.FundSel>
     </CFIF>
     <CFIF TRIM(variables.FY) IS "" OR TRIM(variables.FY) IS "0">
        <CFSET Postion2 = "Default">
     <cfelse>
       <CFSET Postion2 = variables.FY>
     </CFIF>
     <CFIF TRIM(variables.AgcySel) IS "" OR TRIM(variables.AgcySel) IS "Default">
        <CFSET Postion3 = "Default">
     <cfelse>
       <CFSET Postion3 = variables.AgcySel>
     </CFIF>
    
     <!--- ApprSel--->
     <CFIF TRIM(variables.ApprSel) IS "">
        <CFSET Postion4 = "Default">
     <cfelse>
       <CFSET Postion4 = variables.ApprSel>
     </CFIF>
     
     <CFIF TRIM(variables.View) IS "">
        <CFSET Postion5 = "Default">
     <cfelse>
       <CFSET Postion5 = variables.View>
     </CFIF>
     
     
     <CFIF TRIM(variables.ShowMo) IS "">
        <CFSET Postion6 = "No">
     <cfelse>
       <CFSET Postion6 = variables.ShowMo>
     </CFIF>
     
     <CFIF TRIM(variables.ShowLapse) IS "">
        <CFSET Postion7 = "No">
     <cfelse>
       <CFSET Postion7 = variables.ShowLapse>
     </CFIF>
     
      <CFIF TRIM(variables.OrgSel) IS "">
        <CFSET Postion8 = "Default">
     <cfelse>
       <CFSET Postion8 = variables.OrgSel>
     </CFIF>
     
      <CFIF TRIM(variables.Obj_Exp) IS "">
        <CFSET Postion9 = "Default">
     <cfelse>
       <CFSET Postion9 = variables.Obj_Exp>
     </CFIF>
     
     


<cfcookie name="ExpenseAppropriationInquires" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#,#Postion7#,#Postion8#,#Postion9#" expires="never">
   <!--- CFTRY is used to prevent displaying database errors from incoming URL.GroupBy variables that have been manipulated in the URL string.  The revenues query should be rewritten to prevent this from happening.   --->

<CFIF IsDefined ("cookie.ExpenseAppropriationInquires") AND ListLen(cookie.ExpenseAppropriationInquires) IS 9>
     <!--- Get the clients cookie values and set them as variables  --->
	<CFSET C1_FundSel = ListGetAt(cookie.ExpenseAppropriationInquires,1)>
    <CFSET C1_FY = ListGetAt(cookie.ExpenseAppropriationInquires,2)>
    <CFSET C1_AgcySel = ListGetAt(cookie.ExpenseAppropriationInquires,3)>
    <CFSET C1_ApprSel = ListGetAt(cookie.ExpenseAppropriationInquires,4)>
    <CFSET C1_View = ListGetAt(cookie.ExpenseAppropriationInquires,5)>
    <CFSET C1_ShowMo = ListGetAt(cookie.ExpenseAppropriationInquires,6)>
    <CFSET C1_Lapse = ListGetAt(cookie.ExpenseAppropriationInquires,7)>
    <CFSET C1_OrgSel = ListGetAt(cookie.ExpenseAppropriationInquires,8)>
    <CFSET C1_Obj_Exp = ListGetAt(cookie.ExpenseAppropriationInquires,9)>
   
      <!--- Get Friend Names from the cookie values. --->
    <cfinvoke component="Queries.expenditures"
        method="GetFreindlyName_Expense_AppropriationInquires"
        returnvariable="FN1">
    </cfinvoke>
</CFIF>





  <div class="col-sm-offset-2 col-sm-6">
  
	<CFIF C1_FundSel IS NOT "Default" AND C1_FundSel IS NOT "">
      Fund: #FN1.val1#<BR />
    </CFIF>
    <CFIF C1_FY IS NOT "Default" AND C1_FY IS NOT "">
      Fiscal Year: #FN1.val2#<BR />
    </CFIF>
    <CFIF C1_AgcySel IS NOT "Default" AND C1_AgcySel IS NOT "">
      Agency: #FN1.val3#<BR />
    </CFIF>
    <CFIF C1_ApprSel IS NOT "Default" AND C1_ApprSel IS NOT "">
      Appropriation: #FN1.val4#<BR />
    </CFIF>
    <CFIF C1_View IS NOT "Default" AND C1_View IS NOT "">
      View: #FN1.val5#<BR />
    </CFIF>
	<CFIF C1_ShowMo IS NOT "Default" AND C1_ShowMo IS NOT "">
      Show Monthly: #FN1.val6#<BR />
    </CFIF>
    <CFIF C1_Lapse IS NOT "Default" AND C1_Lapse IS NOT "">
    	Show Lapse: #FN1.val7#<BR />
    </CFIF> 
      <CFIF C1_OrgSel IS NOT "Default" AND C1_OrgSel IS NOT "">
    	Organization: #FN1.val8#<BR />
    </CFIF> 
  
      <!--- <CFIF FundSel is not "">
       <CFQUERY NAME="FundName" DATASOURCE="DB2PRD">
        SELECT Fund, Name
              FROM #application.whOwner#FUND_#FY#
              WHERE Fund = '#FundSel#'
       </CFQUERY>
          <p>Fund: #FundName.Fund# - #FundName.Name#</p>
       </cfif>
       <CFIF AgcySel is not "">
        <CFQUERY NAME="AgcyName"  DATASOURCE="DB2PRD">
         SELECT Agency, Name
               FROM #application.whOwner#AGENCY_#FY#
               WHERE Agency = '#AgcySel#'
        </CFQUERY>
         <p>Agency: #AgcyName.Agency# - #AgcyName.Name#</p>
       </cfif>

       <CFQUERY NAME="OrgList" DATASOURCE="DB2PRD">
        SELECT  Organization, Name
        FROM #application.whOwner#ORGN_#FY#
        WHERE Agency = '#AgcySel#'
       </CFQUERY>
         <p>Organization: #OrgList.Organization# - #OrgList.Name#</p>

  <p>for Fiscal Year: #FY#</p> --->
  </div>
  <div class="col-sm-offset-6 col-sm-12"><button type="button" class="btn btn-info custom-pad-around"
  <CFIF TRIM(variables.ApprSel) IS NOT "">onclick="window.history.go(-2);"<cfelse>onclick="window.history.go(-1);"</cfif> >Back to Inquiry Screen</button></div>
</cfoutput>


<cftry>
    <cfinvoke component="Queries.expenditures"
        method="appropriationInquiries"
        returnvariable="results"
        Max="20"
        FY="#variables.FY#"
        ShowBudg="#variables.ShowBudg#"
        ShowExp="#variables.ShowExp#"
        ShowMo="#variables.ShowMo#"
        ShowLapse="#variables.ShowLapse#"
        View="#variables.View#"
        FundSel="#variables.FundSel#"
        AgcySel="#variables.AgcySel#"
        ApprSel="#variables.ApprSel#"
        OrgSel="#variables.OrgSel#"
        sortName="no">
    </cfinvoke>
  <cfcatch type="any"><CFSET Error = 1></cfcatch>
</cftry>


<CFIF Results.recordcount GT 0 AND Not IsDefined ("Error")>

<CFIF TRIM(variables.ApprSel) IS NOT "">
  <cfinclude template="outputs/ar_old.cfm">
 <cfelse>
  <cfinclude template="outputs/ar_new.cfm">
 </cfif>

<cfelse>
 <div class="col-sm-offset-5 col-sm-7"><div class="custom-pad-around">NO RECORDS FOUND</div></div>


</CFIF>





