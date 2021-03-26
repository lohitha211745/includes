<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<div id="layout">
			<cfinclude template="inc/navbar.cfm" />

			<!--- <!-- START SUBMENU -->
			<cfset getSubNav = $.getSubNav() />
			<div id="submenu" class="hidden-xs">
				<div class="container">
					<ul>
						#getSubNav#
					</ul>
				</div>
			</div>
			<!-- END SUBMENU --> --->

			<!-- START EXPENSE -->
			#$.setDynamicContent( $.getBody() )#
			

			<!--- this is here so the parent object gets pushed to the first child --->
			#$.dspObjects(2)#

			<cfinclude template="inc/footer.cfm" />
		</div>
	</body>
	<cfinclude template="inc/html_foot.cfm" />
	
</cfoutput>