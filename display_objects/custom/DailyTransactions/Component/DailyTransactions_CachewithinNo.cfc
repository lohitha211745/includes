
<!--- 
Date Created: 11-7-12
Created By: Gary Ashbaugh

Description: The component contains 3 functions: 

	GetDailyCashBalance: Get list of the General Funds
	GetBondRating: Get the 3 bond ratings from General Database, BondRating table
	GetBacklogs: Get the current backlogs
	GetVoucherBacklogs: Get the current voucher backlogs
	
--->

<cfcomponent hint="Daily Transactions">
	
<cffunction name="GetSSISDt" ACCESS="Public" output="False" hint="Get SSIS Update Date" returntype="any" >
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>
	<cfoutput>
		
	
	<cfquery DATASOURCE="#Srce#" NAME="GetSSISDt">
		SELECT Date,TimeStamp
		FROM SSISPackageLog
		order by Date desc
	</cfquery>		
	
	<cfif GetSSISDt.recordcount>
		<cfreturn "#GetSSISDt#">
	</cfif>
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>
	
<cffunction name="GetLastUpdt" ACCESS="Public" output="False" hint="Get last Update Date" returntype="any" >
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>
	<cfoutput>
			  
    <cfquery DATASOURCE="#Srce#" NAME="GetLastUpdt" cachedwithin="#CreateTimeSpan(0,8,0,0)#">
    SELECT distinct BALANCE_DATE
    FROM WH_SUMM_DAILY_CASH
    order by BALANCE_DATE desc
    </cfquery>
	
	<cfif GetLastUpdt.recordcount>
		<cfreturn "#GetLastUpdt.BALANCE_DATE#">
	</cfif>
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>

<cffunction name="GetDailyCashBalance" ACCESS="Public" output="False" hint="Get list of General Funds" returntype="any">
	<cfargument name="LastUpdt" type="date" required="Yes">
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>
	<cfoutput>
    <cfquery DATASOURCE="#Srce#" NAME="getDailyCashBalance" cachedwithin="#CreateTimeSpan(0,8,0,0)#">
    SELECT BALANCE_DATE, sum(BEGIN_DAILY_AMT) AS SumOfBEGIN_DAILY_AMT, 
        Sum(END_DAILY_AMT) AS SumOfEND_DAILY_AMT, Sum(RECEIPT_AMT) AS SumOfRECEIPT_AMT, 
        Sum(TRANS_IN_AMT) AS SumOfTRANS_IN_AMT, Sum(TRANS_OUT_AMT) AS SumOfTRANS_OUT_AMT 
        ,Sum((WARR_ISSUED_AMT+WARR_VOIDED_AMT+MISCELLANEOUS_AMT+REFUND_AMT)) AS NET_WARRANTS
    FROM WH_SUMM_DAILY_CASH
    GROUP BY BALANCE_DATE
    HAVING (((BALANCE_DATE)= '#LastUpdt#'))
    </cfquery>	
	
	<cfif getDailyCashBalance.recordcount>
		<cfreturn "#getDailyCashBalance#">
	</cfif>
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>

<cffunction name="GetBondRating" ACCESS="Public" output="False" hint="Get the current Bond Ratings" returntype="any">
	<cfargument name="Srce" type="string" required="Yes">


	<cftry>		
	<cfoutput>
    <cfquery DATASOURCE="#Srce#" NAME="getBondRating" cachedwithin="#CreateTimeSpan(0,8,0,0)#">
    select Moodys, SandP, Fitch, Updt_Date
    from BondRatings
    </cfquery>	
	
	<cfif getBondRating.recordcount>
		<cfreturn "#getBondRating#">
	</cfif>
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>


</cffunction>

<cffunction name="GetBacklogs" ACCESS="Public" output="False" hint="Get the current backlog of unpaid bills" returntype="any">
	<cfargument name="LastUpdt" type="Date" required="Yes">
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>		
	<cfoutput>	
    <cfquery DATASOURCE="#Srce#" NAME="getBacklogs" cachedwithin="#CreateTimeSpan(0,8,0,0)#">
    SELECT Sum(END_OF_DAY_BALANCE) AS SumOfEND_OF_DAY_BALANCE 
    FROM WH_BLNCESHT_ENDNG_BAL
    GROUP BY BALANCE_DATE
    HAVING (((BALANCE_DATE)= '#LastUpdt#'))
    </cfquery>	
	
	<cfif getBacklogs.recordcount>
		<cfreturn "#getBacklogs#">
	</cfif>
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>

<cffunction name="GetVoucherBacklogs" ACCESS="Public" output="False" hint="Get list of backlogs for vouchers" returntype="any">
	<cfargument name="Srce" type="string" required="Yes">


	<cftry>

	<cfoutput>		
    <cfquery DATASOURCE="#Srce#" NAME="GetVoucherBacklogs" cachedwithin="#CreateTimeSpan(0,8,0,0)#">
    SELECT VOUCHER_LINE, Count(*) AS TotVoucherBacklog
    FROM CM_CASH_MGMT
    GROUP BY VOUCHER_LINE
    HAVING (((VOUCHER_LINE)='01'))
    </cfquery>
    
	<cfif GetVoucherBacklogs.recordcount>
		<cfreturn "#GetVoucherBacklogs#">
	</cfif>
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>


</cfcomponent>