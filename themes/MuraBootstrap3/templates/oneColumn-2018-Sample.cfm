<cfoutput>
	<cfinclude template="inc/html_head_2018.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<cfinclude template="inc/navbar_2018.cfm" />

		<div class="container">
			<section class="content">
				<!---
						The Content
						See the file located under '/display_objects/page_default/index.cfm' to override body styling
				--->
				<cfoutput>
					<!--- Primary Associated Image --->
						<cfif $.content().hasImage(usePlaceholder=false)>
							<cfscript>
								img = $.content().getImageURL(
									size = 'custom' // small, medium, large, custom, or any other pre-defined image size
                                    ,width = 110 // only needed if using size='custom'
                                    ,height = 110 // only needed if using size='custom'
									,complete = false // set to true to include the entire URL, not just the absolute path (default)
								);
							</cfscript>

						</cfif>
					<!--- /Primary Associated Image --->
					<cfif $.content( 'hidePageTitle' ) neq 'yes'>
						<cfif structKeyExists( variables, "img" )>
							<h1 class="mura-page-title pageTitle">
							    <img src="#img#" style="margin-right: 14px;"><span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						<cfelse>
							<h1 class="mura-page-title pageTitle">
							<span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						</cfif>
					</cfif>
					<div class="mura-body">
						#$.renderEditableAttribute(attribute="body",type="htmlEditor")#
					</div>
					<!--- /Body --->
				</cfoutput>
			</section>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>