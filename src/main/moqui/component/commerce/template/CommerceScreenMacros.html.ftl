<#--
	This is the customized screen macros for commerce

-->

<#-- Include the default macros for override -->
<#include "classpath://template/screen-macro/DefaultScreenMacros.html.ftl"/>

<#-- ================ Subscreens ================ -->
<#-- Customized version for commerce only -->
<#macro "subscreens-menu">
    <#assign displayMenu = sri.activeInCurrentMenu!>
    <#assign menuId = .node["@id"]!"subscreensMenu">
    <#if .node["@type"]! == "popup">
    	<h1>popup type is not yet supported.</h1>
    <#elseif .node["@type"]! == "popup-tree">
    <#else>
        <#-- default to type=tab -->
        <#if displayMenu!>
        <div class="header-bottom">
        	<div class="container">
        		<div class="row">
        			<div class="col-sm-9">
        				<#-- response menu button definition -->
        				<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
						</div>
						<#-- menu group population start -->
						<div class="mainmenu pull-left">
							<ul <#if .node["@id"]?has_content> id="${.node["@id"]}"</#if> class="nav navbar-nav collapse navbar-collapse">
								<#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
				                    <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
				                    <#if urlInfo.isPermitted()>
				                    	<#-- Checks if there is a second level menu available. -->
				                    	<#assign subMenuItems = sri.getSfi().getScreenDefinition(subscreensItem.location).getMenuSubscreensItems()>
				                    	<#if subMenuItems?size gt 0 >
				                    		<#-- Render with submenu style if submenu is found-->
				                    		<li class="dropdown"><a href="#" class="<#if urlInfo.inCurrentScreenPath>active</#if>">${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}<i class="fa fa-angle-down"></i></a>
				                    			<ul role="menu" class="sub-menu">
				                    				<#list subMenuItems as subMenuItem>
				                    					<#assign subMenuUrlInfo = sri.buildUrl(subMenuItem.name)>
				                    					<li><a class="<#if subMenuUrlInfo.inCurrentScreenPath>active</#if>" href="${subMenuUrlInfo.minimalPathUrlWithParams}">${ec.l10n.getLocalizedMessage(subMenuItem.menuTitle)}</a></li>
				                    				</#list>
				                    			</ul>
				                    		</li>
				                    	<#else>
				                    	<li><#if urlInfo.disableLink>${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}<#else><a class="<#if urlInfo.inCurrentScreenPath>active</#if>" href="${urlInfo.minimalPathUrlWithParams}">${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}</a></#if></li>
				                    	</#if>
				                    </#if>
				                </#list>
							</ul>
						</div>
        			</div> <#--End of menu group -->
        		</div>
        	</div>
        </div>
        </#if>
    </#if>
</#macro>

