<#--
This Work is in the public domain and is provided on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied,
including, without limitation, any warranties or conditions of TITLE,
NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE.
You are solely responsible for determining the appropriateness of using
this Work and assume any risks associated with your use of this Work.

This Work includes contributions authored by David E. Jones, not as a
"work for hire", who hereby disclaims any copyright to the same.
-->

<#macro @element><p>=== Doing nothing for element ${.node?node_name}, not yet implemented. ===</p></#macro>

<#macro widgets>
<#if sri.doBoundaryComments()><!-- BEGIN screen[@location=${sri.getActiveScreenDef().location}].widgets --></#if>
<#recurse>
<#if sri.doBoundaryComments()><!-- END   screen[@location=${sri.getActiveScreenDef().location}].widgets --></#if>
</#macro>
<#macro "fail-widgets">
<#if sri.doBoundaryComments()><!-- BEGIN screen[@location=${sri.getActiveScreenDef().location}].fail-widgets --></#if>
<#recurse>
<#if sri.doBoundaryComments()><!-- END   screen[@location=${sri.getActiveScreenDef().location}].fail-widgets --></#if>
</#macro>

<#-- ================ Subscreens ================ -->
<#macro "subscreens-menu">
    <#assign displayMenu = sri.activeInCurrentMenu!>
    <#assign menuId = .node["@id"]!"subscreensMenu">
    <#if .node["@type"]! == "popup">
        <#assign menuTitle = .node["@title"]!sri.getActiveScreenDef().getDefaultMenuName()!"Menu">
        <#-- <#assign menuUrlInfo = sri.buildUrl("")> -->
        <#-- <ul id="${menuId}"<#if .node["@width"]?has_content> style="width: ${.node["@width"]};"</#if>> -->
            <#-- <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
                <#if urlInfo?exists && urlInfo.inCurrentScreenPath><#assign currentItemName = ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)></#if>
            </#list> -->
            <li id="${menuId}" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">${menuTitle} <i class="glyphicon glyphicon-chevron-right"></i></a>
                <ul class="dropdown-menu">
                    <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                        <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
                        <#if urlInfo.isPermitted()>
                            <li class="<#if urlInfo.inCurrentScreenPath>active</#if>"><a href="<#if urlInfo.disableLink>#<#else>${urlInfo.minimalPathUrlWithParams}</#if>">${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}</a></li>
                        </#if>
                    </#list>
                </ul>
            </li>
            <#--
            <li><a href="${menuUrlInfo.minimalPathUrlWithParams}">${menuTitle}<#-- very usable without this: <#if currentItemName?has_content> (${currentItemName})</#if> - -></a>
                <ul>
                    <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                        <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
                        <#if urlInfo.isPermitted()>
                            <li class="<#if urlInfo.inCurrentScreenPath>ui-state-active</#if>"><a href="<#if urlInfo.disableLink>#<#else>${urlInfo.minimalPathUrlWithParams}</#if>">${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}</a></li>
                        </#if>
                    </#list>
                </ul>
            </li>
            -->
        <#-- </ul> -->
        <#-- NOTE: not putting this script at the end of the document so that it doesn't appear unstyled for as long -->
        <script>
            <#-- move the menu to the header-menus container -->
            $("#${.node["@header-menus-id"]!"header-menus"}").append($("#${menuId}"));
            <#-- $("#${menuId}").menu({position: { my: "right top", at: "right bottom" }}); -->
        </script>
    <#elseif .node["@type"]! == "popup-tree">
    <#else>
        <#-- default to type=tab -->
        <#if displayMenu!>
        <div class="ui-tabs ui-tabs-collapsible">
            <ul<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if> class="ui-tabs-nav ui-helper-clearfix ui-widget-header ui-corner-all">
                <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                    <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
                    <#if urlInfo.isPermitted()>
                        <li class="ui-state-default ui-corner-top<#if urlInfo.inCurrentScreenPath> ui-tabs-selected ui-state-active</#if>"><#if urlInfo.disableLink>${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}<#else><a href="${urlInfo.minimalPathUrlWithParams}">${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}</a></#if></li>
                    </#if>
                </#list>
            </ul>
        </div>
        </#if>
    </#if>
</#macro>

<#macro "subscreens-active">
    <#-- NOTE DEJ20130803 is there any reason to do this, or even support an id? disabling for now as it complicates things with jquery layout:
    <#if .node["@id"]?has_content>
        <div class="ui-tabs">
            <div id="${.node["@id"]}" class="ui-tabs-panel">
            ${sri.renderSubscreen()}
            </div>
        </div>
    <#else>
    -->
        ${sri.renderSubscreen()}
    <#-- </#if> -->
</#macro>

<#macro "subscreens-panel">
    <#assign dynamic = .node["@dynamic"]! == "true" && .node["@id"]?has_content>
    <#assign dynamicActive = 0>
    <#assign displayMenu = sri.activeInCurrentMenu!>
    <#if .node["@type"]! == "popup">
        <#assign menuTitle = .node["@title"]!sri.getActiveScreenDef().getDefaultMenuName()!"Menu">
        <#assign menuId><#if .node["@id"]?has_content>${.node["@id"]}-menu<#else>subscreensPanelMenu</#if></#assign>
        <#-- <#assign menuUrlInfo = sri.buildUrl("")> -->
        <#-- <ul id="${menuId}"<#if .node["@width"]?has_content> style="width: ${.node["@menu-width"]};"</#if>>  ->
            <#-- <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
                <#if urlInfo.inCurrentScreenPath><#assign currentItemName = ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)></#if>
            </#list> -->
            <li id="${menuId}" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">${menuTitle} <i class="glyphicon glyphicon-chevron-right"></i></a>
                <ul class="dropdown-menu">
                    <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                        <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
                        <#if urlInfo.isPermitted()>
                            <li class="<#if urlInfo.inCurrentScreenPath>active</#if>"><a href="<#if urlInfo.disableLink>#<#else>${urlInfo.minimalPathUrlWithParams}</#if>">${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}</a></li>
                        </#if>
                    </#list>
                </ul>
            </li>
            <#--
            <li><a href="${menuUrlInfo.minimalPathUrlWithParams}">${menuTitle}<#-- very usable without this: <#if currentItemName?has_content> (${currentItemName})</#if> - -></a>
                <ul>
                    <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                        <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
                        <#if urlInfo.isPermitted()>
                            <li class="<#if urlInfo.inCurrentScreenPath>ui-state-active</#if>"><a href="<#if urlInfo.disableLink>#<#else>${urlInfo.minimalPathUrlWithParams}</#if>">${ec.l10n.getLocalizedMessage(subscreensItem.menuTitle)}</a></li>
                        </#if>
                    </#list>
                </ul>
            </li>
            -->
        <#-- </ul> -->
        <#-- NOTE: not putting this script at the end of the document so that it doesn't appear unstyled for as long -->
        <script>
            <#-- move the menu to the header menus section -->
            $("#${.node["@header-menus-id"]!"header-menus"}").append($("#${menuId}"));
            <#-- $("#${menuId}").menu({position: { my: "right top", at: "right bottom" }}); -->
        </script>

        ${sri.renderSubscreen()}
    <#elseif .node["@type"]! == "stack">
        <h1>LATER stack type subscreens-panel not yet supported.</h1>
    <#elseif .node["@type"]! == "wizard">
        <h1>LATER wizard type subscreens-panel not yet supported.</h1>
    <#else>
        <#-- default to type=tab -->
        <div<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if> class="ui-tabs ui-tabs-collapsible">
        <#if displayMenu!>
            <ul<#if .node["@id"]?has_content> id="${.node["@id"]}-menu"</#if> class="ui-tabs-nav ui-helper-clearfix ui-widget-header ui-corner-all">
            <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                <#assign urlInfo = sri.buildUrl(subscreensItem.name)>
                <#if urlInfo.isPermitted()>
                    <#if dynamic>
                        <#assign urlInfo = urlInfo.addParameter("lastStandalone", "true")>
                        <#if urlInfo.inCurrentScreenPath>
                            <#assign dynamicActive = subscreensItem_index>
                            <#assign urlInfo = urlInfo.addParameters(ec.web.requestParameters)>
                        </#if>
                    </#if>
                    <li class="ui-state-default ui-corner-top<#if urlInfo.disableLink> ui-state-disabled<#elseif urlInfo.inCurrentScreenPath> ui-tabs-selected ui-state-active</#if>"><a href="<#if urlInfo.disableLink>#<#else>${urlInfo.minimalPathUrlWithParams}</#if>"><span>${subscreensItem.menuTitle}</span></a></li>
                </#if>
            </#list>
            </ul>
        </#if>
        </div>
        <#if !dynamic || !displayMenu>
        <#-- these make it more similar to the HTML produced when dynamic, but not needed: <div<#if .node["@id"]?has_content> id="${.node["@id"]}-active"</#if> class="ui-tabs-panel"> -->
        ${sri.renderSubscreen()}
        <#-- </div> -->
        </#if>
        <#if dynamic && displayMenu!>
            <#assign afterScreenScript>
                $("#${.node["@id"]}").tabs({ collapsible: true, selected: ${dynamicActive},
                    spinner: '<span class="ui-loading">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>',
                    ajaxOptions: { error: function(xhr, status, index, anchor) { $(anchor.hash).html("Error loading screen..."); } },
                    load: function(event, ui) { <#-- activateAllButtons(); --> }
                });
            </#assign>
            <#t>${sri.appendToScriptWriter(afterScreenScript)}
        </#if>
    </#if>
</#macro>

<#-- ================ Section ================ -->
<#macro section>
    <#if sri.doBoundaryComments()><!-- BEGIN section[@name=${.node["@name"]}] --></#if>
    ${sri.renderSection(.node["@name"])}
    <#if sri.doBoundaryComments()><!-- END   section[@name=${.node["@name"]}] --></#if>
</#macro>
<#macro "section-iterate">
    <#if sri.doBoundaryComments()><!-- BEGIN section-iterate[@name=${.node["@name"]}] --></#if>
    ${sri.renderSection(.node["@name"])}
    <#if sri.doBoundaryComments()><!-- END   section-iterate[@name=${.node["@name"]}] --></#if>
</#macro>

<#-- ================ Containers ================ -->
<#macro container>    <div<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if><#if .node["@style"]?has_content> class="${.node["@style"]}"</#if>><#recurse>
    </div>
</#macro>

<#macro "container-panel">
    <#assign panelId = ec.resource.evaluateStringExpand(.node["@id"], "")>
    <#-- DEJ 24 Jan 2014: disabling dynamic panels for now, need to research with new Metis admin theme:
    <#if .node["@dynamic"]! == "true">
        <#assign afterScreenScript>
        $("#${panelId}").layout({
        defaults: { closable: true, resizable: true, slidable: false, livePaneResizing: true, spacing_open: 5 },
        <#if .node["panel-header"]?has_content><#assign panelNode = .node["panel-header"][0]>north: { showOverflowOnHover: true, closable: ${panelNode["@closable"]!"true"}, resizable: ${panelNode["@resizable"]!"false"}, spacing_open: ${panelNode["@spacing"]!"5"}, size: "${panelNode["@size"]!"auto"}"<#if panelNode["@size-min"]?has_content>, minSize: ${panelNode["@size-min"]}</#if><#if panelNode["@size-min"]?has_content>, maxSize: ${panelNode["@size-max"]}</#if> },</#if>
        <#if .node["panel-footer"]?has_content><#assign panelNode = .node["panel-footer"][0]>south: { showOverflowOnHover: true, closable: ${panelNode["@closable"]!"true"}, resizable: ${panelNode["@resizable"]!"false"}, spacing_open: ${panelNode["@spacing"]!"5"}, size: "${panelNode["@size"]!"auto"}"<#if panelNode["@size-min"]?has_content>, minSize: ${panelNode["@size-min"]}</#if><#if panelNode["@size-min"]?has_content>, maxSize: ${panelNode["@size-max"]}</#if> },</#if>
        <#if .node["panel-left"]?has_content><#assign panelNode = .node["panel-left"][0]>west: { closable: ${panelNode["@closable"]!"true"}, resizable: ${panelNode["@resizable"]!"true"}, spacing_open: ${panelNode["@spacing"]!"5"}, size: "${panelNode["@size"]!"180"}"<#if panelNode["@size-min"]?has_content>, minSize: ${panelNode["@size-min"]}</#if><#if panelNode["@size-min"]?has_content>, maxSize: ${panelNode["@size-max"]}</#if> },</#if>
        <#if .node["panel-right"]?has_content><#assign panelNode = .node["panel-right"][0]>east: { closable: ${panelNode["@closable"]!"true"}, resizable: ${panelNode["@resizable"]!"true"}, spacing_open: ${panelNode["@spacing"]!"5"}, size: "${panelNode["@size"]!"180"}"<#if panelNode["@size-min"]?has_content>, minSize: ${panelNode["@size-min"]}</#if><#if panelNode["@size-min"]?has_content>, maxSize: ${panelNode["@size-max"]}</#if> },</#if>
        center: { minWidth: 200 }
        });
        </#assign>
        <#t>${sri.appendToScriptWriter(afterScreenScript)}
        <div<#if panelId?has_content> id="${panelId}"</#if>>
            <#if .node["panel-header"]?has_content>
                <div<#if panelId?has_content> id="${panelId}-header"</#if> class="ui-layout-north ui-helper-clearfix"><#recurse .node["panel-header"][0]>
                </div></#if>
            <#if .node["panel-left"]?has_content>
                <div<#if panelId?has_content> id="${panelId}-left"</#if> class="ui-layout-west"><#recurse .node["panel-left"][0]>
                </div>
            </#if>
            <div<#if panelId?has_content> id="${panelId}-center"</#if> class="ui-layout-center"><#recurse .node["panel-center"][0]>
            </div>
            <#if .node["panel-right"]?has_content>
                <div<#if panelId?has_content> id="${panelId}-right"</#if> class="ui-layout-east"><#recurse .node["panel-right"][0]>
                </div>
            </#if>
            <#if .node["panel-footer"]?has_content>
                <div<#if panelId?has_content> id="${panelId}-footer"</#if> class="ui-layout-south"><#recurse .node["panel-footer"][0]>
                </div></#if>
        </div>
    <#else>
    -->
        <div<#if panelId?has_content> id="${panelId}"</#if> class="panel-outer">
            <#if .node["panel-header"]?has_content>
                <div<#if panelId?has_content> id="${panelId}-header"</#if> class="panel-header"><#recurse .node["panel-header"][0]>
                </div>
            </#if>
            <div class="panel-middle">
                <#if .node["panel-left"]?has_content>
                    <div<#if panelId?has_content> id="${panelId}-left"</#if> class="panel-left" style="width: ${.node["panel-left"][0]["@size"]!"180"}px;"><#recurse .node["panel-left"][0]>
                    </div>
                </#if>
                <#assign centerClass><#if .node["panel-left"]?has_content><#if .node["panel-right"]?has_content>panel-center-both<#else>panel-center-left</#if><#else><#if .node["panel-right"]?has_content>panel-center-right<#else>panel-center-only</#if></#if></#assign>
                <div<#if panelId?has_content> id="${panelId}-center"</#if> class="${centerClass}"><#recurse .node["panel-center"][0]>
            </div>
            <#if .node["panel-right"]?has_content>
                <div<#if panelId?has_content> id="${panelId}-right"</#if> class="panel-right" style="width: ${.node["panel-right"][0]["@size"]!"180"}px;"><#recurse .node["panel-right"][0]>
                </div>
            </#if>
            </div>
            <#if .node["panel-footer"]?has_content>
                <div<#if panelId?has_content> id="${panelId}-footer"</#if> class="panel-footer"><#recurse .node["panel-footer"][0]>
                </div>
            </#if>
        </div>
    <#-- </#if> -->
</#macro>

<#macro "container-dialog">
    <#assign buttonText = ec.resource.evaluateStringExpand(.node["@button-text"], "")>
    <button id="${.node["@id"]}-button" data-toggle="modal" data-target="#${.node["@id"]}" data-original-title="${buttonText}" data-placement="bottom" class="btn btn-primary btn-sm"><i class="glyphicon glyphicon-share"></i> ${buttonText}</button>
    <div id="${.node["@id"]}" class="modal fade" aria-hidden="true" style="display: none;">
        <div class="modal-dialog" style="width: ${.node["@width"]!"600"}px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">${buttonText}</h4>
                </div>
                <div class="modal-body">
                    <#recurse>
                </div>
                <#-- <div class="modal-footer"><button type="button" class="btn btn-primary" data-dismiss="modal">Close</button></div> -->
            </div>
        </div>
    </div>
    <#-- for jQuery dialog:
    <#assign afterScreenScript>
        $("#${.node["@id"]}").dialog({autoOpen:false, height:${.node["@height"]!"600"}, width:${.node["@width"]!"600"}, modal:false });
        <#--, buttons: { Close: function() { $(this).dialog("close"); } } - ->
        <#--, close: function() { } - ->
        $("#${.node["@id"]}-button").click(function() { $("#${.node["@id"]}").dialog("open"); });
    </#assign>
    <#t>${sri.appendToScriptWriter(afterScreenScript)}
    -->
</#macro>

<#macro "dynamic-container">
    <#assign divId>${.node["@id"]}<#if listEntryIndex?has_content>_${listEntryIndex}</#if></#assign>
    <#assign urlInfo = sri.makeUrlByType(.node["@transition"], "transition", .node, "true").addParameter("_dynamic_container_id", divId)>
    <div id="${divId}"><img src="/images/wait_anim_16x16.gif" alt="Loading..."></div>
    <#assign afterScreenScript>
        function load${divId}() { $("#${divId}").load("${urlInfo.passThroughSpecialParameters().urlWithParams}", function() { <#-- activateAllButtons() --> }) }
        load${divId}();
    </#assign>
    <#t>${sri.appendToScriptWriter(afterScreenScript)}
</#macro>

<#macro "dynamic-dialog">
    <#assign buttonText = ec.resource.evaluateStringExpand(.node["@button-text"], "")>
    <#assign urlInfo = sri.makeUrlByType(.node["@transition"], "transition", .node, "true")>
    <#assign divId>${ec.resource.evaluateStringExpand(.node["@id"], "")}<#if listEntryIndex?has_content>_${listEntryIndex}</#if></#assign>

    <button id="${divId}-button" data-toggle="modal" data-target="#${divId}" data-original-title="${buttonText}" data-placement="bottom" class="btn btn-primary btn-sm"><i class="glyphicon glyphicon-share"></i> ${buttonText}</button>
    <div id="${divId}" class="modal fade" aria-hidden="true" style="display: none;">
        <div class="modal-dialog" style="width: ${.node["@width"]!"600"}px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">${buttonText}</h4>
                </div>
                <div class="modal-body" id="${divId}-body">
                    <img src="/images/wait_anim_16x16.gif" alt="Loading...">
                </div>
                <#-- <div class="modal-footer"><button type="button" class="btn btn-primary" data-dismiss="modal">Close</button></div> -->
            </div>
        </div>
    </div>
    <script>$("#${divId}").on("show.bs.modal", function (e) { $("#${divId}-body").load('${urlInfo.urlWithParams}') })</script>
    <#-- jQuery dialog:
    <button id="${divId}-button"><i class="glyphicon glyphicon-share"></i> ${buttonText}</button>
    <div id="${divId}" title="${buttonText}"></div>
    <#assign afterScreenScript>
        $("#${divId}").dialog({autoOpen:false, height:${.node["@height"]!"600"}, width:${.node["@width"]!"600"},
            modal:false, open: function() { $(this).load('${urlInfo.urlWithParams}', function() { activateAllButtons() }) } });
        $("#${divId}-button").click(function() { $("#${divId}").dialog("open"); return false; });
    </#assign>
    <#t>${sri.appendToScriptWriter(afterScreenScript)}
    -->
</#macro>

<#-- ==================== Includes ==================== -->
<#macro "include-screen">
<#if sri.doBoundaryComments()><!-- BEGIN include-screen[@location=${.node["@location"]}][@share-scope=${.node["@share-scope"]!}] --></#if>
${sri.renderIncludeScreen(.node["@location"], .node["@share-scope"]!)}
<#if sri.doBoundaryComments()><!-- END   include-screen[@location=${.node["@location"]}][@share-scope=${.node["@share-scope"]!}] --></#if>
</#macro>

<#-- ============== Tree ============== -->
<#-- TABLED, not to be part of 1.0:
<#macro tree>
</#macro>
<#macro "tree-node">
</#macro>
<#macro "tree-sub-node">
</#macro>
-->

<#-- ============== Render Mode Elements ============== -->
<#macro "render-mode">
<#if .node["text"]?has_content>
    <#list .node["text"] as textNode>
        <#if textNode["@type"]?has_content && textNode["@type"] == sri.getRenderMode()><#assign textToUse = textNode/></#if>
    </#list>
    <#if !textToUse?has_content>
        <#list .node["text"] as textNode><#if !textNode["@type"]?has_content || textNode["@type"] == "any"><#assign textToUse = textNode/></#if></#list>
    </#if>
    <#if textToUse?exists>
        <#if textToUse["@location"]?has_content>
        <#assign textLocation = ec.resource.evaluateStringExpand(textToUse["@location"], "")>
<#if sri.doBoundaryComments()><!-- BEGIN render-mode.text[@location=${textLocation}][@template=${textToUse["@template"]?default("true")}] --></#if>
    <#-- NOTE: this still won't encode templates that are rendered to the writer -->
    <#if .node["@encode"]!"false" == "true">${sri.renderText(textLocation, textToUse["@template"]!)?html}<#else>${sri.renderText(textLocation, textToUse["@template"]!)}</#if>
<#if sri.doBoundaryComments()><!-- END   render-mode.text[@location=${textLocation}][@template=${textToUse["@template"]?default("true")}] --></#if>
        </#if>
        <#assign inlineTemplateSource = textToUse?string/>
        <#if inlineTemplateSource?has_content>
<#if sri.doBoundaryComments()><!-- BEGIN render-mode.text[inline][@template=${textToUse["@template"]?default("true")}] --></#if>
          <#if !textToUse["@template"]?has_content || textToUse["@template"] == "true">
            <#assign inlineTemplate = [inlineTemplateSource, sri.getActiveScreenDef().location + ".render_mode.text"]?interpret>
            <@inlineTemplate/>
          <#else>
            <#if .node["@encode"]!"false" == "true">${inlineTemplateSource?html}<#else>${inlineTemplateSource}</#if>
          </#if>
<#if sri.doBoundaryComments()><!-- END   render-mode.text[inline][@template=${textToUse["@template"]?default("true")}] --></#if>
        </#if>
    </#if>
</#if>
</#macro>

<#macro text><#-- do nothing, is used only through "render-mode" --></#macro>

<#-- ================== Standalone Fields ==================== -->
<#macro link>
    <#assign urlInfo = sri.makeUrlByType(.node["@url"], .node["@url-type"]!"transition", .node, .node["@expand-transition-url"]!"true")>
    <#assign linkNode = .node>
    <@linkFormForm linkNode linkNode["@id"]?if_exists urlInfo/>
    <@linkFormLink linkNode linkNode["@id"]?if_exists urlInfo/>
</#macro>
<#macro linkFormLink linkNode linkFormId urlInfo>
    <#if urlInfo.disableLink>
        <span<#if linkFormId?has_content> id="${linkFormId}"</#if>>${ec.resource.evaluateStringExpand(linkNode["@text"], "")}</span>
    <#else>
        <#assign confirmationMessage = ec.resource.evaluateStringExpand(linkNode["@confirmation"]!, "")/>
        <#if (linkNode["@link-type"]! == "anchor" || linkNode["@link-type"]! == "anchor-button") ||
            ((!linkNode["@link-type"]?has_content || linkNode["@link-type"] == "auto") &&
             ((linkNode["@url-type"]?has_content && linkNode["@url-type"] != "transition") || (!urlInfo.hasActions)))>
            <a href="${urlInfo.urlWithParams}"<#if linkFormId?has_content> id="${linkFormId}"</#if><#if linkNode["@target-window"]?has_content> target="${linkNode["@target-window"]}"</#if><#if confirmationMessage?has_content> onclick="return confirm('${confirmationMessage?js_string}')"</#if><#if linkNode["@link-type"]! == "anchor-button"> class="btn btn-primary btn-sm"</#if>><#if linkNode["@icon"]?has_content><i class="${linkNode["@icon"]}"></i></#if>
            <#t><#if linkNode["image"]?has_content><#visit linkNode["image"]><#else>${ec.resource.evaluateStringExpand(linkNode["@text"], "")}</#if>
            <#t></a>
        <#else>
            <#if linkFormId?has_content>
            <button type="submit" form="${linkFormId}"<#if confirmationMessage?has_content> onclick="return confirm('${confirmationMessage?js_string}')"</#if> class="btn btn-primary btn-sm<#if linkNode["@link-type"]! == "hidden-form-link"> btn-flat</#if>"><#if linkNode["@icon"]?has_content><i class="${linkNode["@icon"]}"></i> </#if>
                <#if linkNode["image"]?has_content>
                    <#t><img src="${sri.makeUrlByType(imageNode["@url"],imageNode["@url-type"]!"content",null,"true")}"<#if imageNode["@alt"]?has_content> alt="${imageNode["@alt"]}"</#if>/>
                <#else>
                    <#t>${ec.resource.evaluateStringExpand(linkNode["@text"], "")}
                </#if>
            </button>
            </#if>
        </#if>
    </#if>
</#macro>
<#macro linkFormForm linkNode linkFormId urlInfo>
    <#if urlInfo.disableLink>
        <#-- do nothing -->
    <#else>
        <#if (linkNode["@link-type"]! == "anchor" || linkNode["@link-type"]! == "anchor-button") ||
            ((!linkNode["@link-type"]?has_content || linkNode["@link-type"] == "auto") &&
             ((linkNode["@url-type"]?has_content && linkNode["@url-type"] != "transition") || (!urlInfo.hasActions)))>
            <#-- do nothing -->
        <#else>
            <form method="post" action="${urlInfo.url}" name="${linkFormId!""}"<#if linkFormId?has_content> id="${linkFormId}"</#if><#if linkNode["@target-window"]?has_content> target="${linkNode["@target-window"]}"</#if>>
                <#assign targetParameters = urlInfo.getParameterMap()>
                <#-- NOTE: using .keySet() here instead of ?keys because ?keys was returning all method names with the other keys, not sure why -->
                <#if targetParameters?has_content><#list targetParameters.keySet() as pKey>
                    <input type="hidden" name="${pKey?html}" value="${targetParameters.get(pKey)?default("")?html}"/>
                </#list></#if>
                <#if !linkFormId?has_content>
                    <#assign confirmationMessage = ec.resource.evaluateStringExpand(linkNode["@confirmation"]!, "")/>
                    <#if linkNode["image"]?has_content><#assign imageNode = linkNode["image"][0]/>
                        <input type="image" src="${sri.makeUrlByType(imageNode["@url"],imageNode["@url-type"]!"content",null,"true")}"<#if imageNode["@alt"]?has_content> alt="${imageNode["@alt"]}"</#if><#if confirmationMessage?has_content> onclick="return confirm('${confirmationMessage?js_string}')"</#if>>
                    <#else>
                        <button type="submit"<#if confirmationMessage?has_content> onclick="return confirm('${confirmationMessage?js_string}')"</#if> class="btn btn-primary btn-sm<#if linkNode["@link-type"]! == "hidden-form-link"> btn-flat</#if>"><#if linkNode["@icon"]?has_content><i class="${linkNode["@icon"]}"></i> </#if>${ec.resource.evaluateStringExpand(linkNode["@text"], "")}</button>
                    </#if>
                </#if>
            </form>
        </#if>
    </#if>
</#macro>

<#macro image><img src="${sri.makeUrlByType(.node["@url"],.node["@url-type"]!"content",null,"true")}" alt="${.node["@alt"]!"image"}"<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if><#if .node["@width"]?has_content> width="${.node["@width"]}"</#if><#if .node["@height"]?has_content> height="${.node["@height"]}"</#if>/></#macro>
<#macro label>
    <#assign labelType = .node["@type"]?default("span")/>
    <#assign labelValue = ec.resource.evaluateStringExpand(.node["@text"], "")/>
    <#if (labelValue?has_content && labelValue?length < 255)><#assign labelValue = ec.l10n.getLocalizedMessage(labelValue)/></#if>
    <#if labelValue?trim?has_content>
        <${labelType}<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if>><#if !.node["@encode"]?has_content || .node["@encode"] == "true">${labelValue?html?replace("\n", "<br>")}<#else>${labelValue}</#if></${labelType}>
    </#if>
</#macro>
<#macro editable>
    <#-- for docs on JS usage see: http://www.appelsiini.net/projects/jeditable -->
    <#assign urlInfo = sri.makeUrlByType(.node["@transition"], "transition", .node, "true")>
    <#assign urlParms = urlInfo.getParameterMap()>
    <#assign divId>${.node["@id"]}<#if listEntryIndex?has_content>_${listEntryIndex}</#if></#assign>
    <#assign labelType = .node["@type"]?default("span")>
    <#assign labelValue = ec.resource.evaluateStringExpand(.node["@text"], "")>
    <#assign parameterName = .node["@parameter-name"]!"value">
    <#if labelValue?trim?has_content>
        <${labelType} id="${divId}"><#if .node["@encode"]! == "true">${labelValue?html?replace("\n", "<br>")}<#else>${labelValue}</#if></${labelType}>
        <#assign afterScreenScript>
        $("#${divId}").editable("${urlInfo.url}", { indicator:"${ec.l10n.getLocalizedMessage("Saving")}",
            tooltip:"${ec.l10n.getLocalizedMessage("Click to edit")}", cancel:"${ec.l10n.getLocalizedMessage("Cancel")}",
            submit:"${ec.l10n.getLocalizedMessage("Save")}", name:"${parameterName}",
            type:"${.node["@widget-type"]!"textarea"}", cssclass:"editable-form",
            submitdata:{<#list urlParms.keySet() as parameterKey>${parameterKey}:"${urlParms[parameterKey]}", </#list>parameterName:"${parameterName}"}
            <#if .node["editable-load"]?has_content>
                <#assign loadNode = .node["editable-load"][0]>
                <#assign loadUrlInfo = sri.makeUrlByType(loadNode["@transition"], "transition", loadNode, "true")>
                <#assign loadUrlParms = loadUrlInfo.getParameterMap()>
            , loadurl:"${loadUrlInfo.url}", loadtype:"POST", loaddata:function(value, settings) { return {<#list loadUrlParms.keySet() as parameterKey>${parameterKey}:"${loadUrlParms[parameterKey]}", </#list>currentValue:value}; }
            </#if>});
        </#assign>
        <#t>${sri.appendToScriptWriter(afterScreenScript)}
    </#if>
</#macro>
<#macro parameter><#-- do nothing, used directly in other elements --></#macro>

<#-- ====================================================== -->
<#-- ======================= Form ========================= -->
<#macro "form-single">
<#if sri.doBoundaryComments()><!-- BEGIN form-single[@name=${.node["@name"]}] --></#if>
    <#-- Use the formNode assembled based on other settings instead of the straight one from the file: -->
    <#assign formNode = sri.getFtlFormNode(.node["@name"])>
    ${sri.setSingleFormMapInContext(formNode)}
    <#assign skipStart = (formNode["@skip-start"]! == "true")>
    <#assign skipEnd = (formNode["@skip-end"]! == "true")>
    <#assign urlInfo = sri.makeUrlByType(formNode["@transition"], "transition", null, "false")>
    <#assign formId = ec.resource.evaluateStringExpand(formNode["@name"], "")>
    <#assign listEntryIndex = "">
    <#assign inFieldRow = false>
    <#assign bigRow = false>
    <#assign bigRowFirst = false>
    <#if !skipStart>
    <form name="${formId}" id="${formId}" class="validation-engine-init" method="post" action="${urlInfo.url}"<#if sri.isFormUpload(formNode["@name"])> enctype="multipart/form-data"</#if>>
        <input type="hidden" name="moquiFormName" value="${formNode["@name"]}">
    </#if>
        <fieldset class="form-horizontal"><#-- was form-single-outer -->
    <#if formNode["field-layout"]?has_content>
        <#assign fieldLayout = formNode["field-layout"][0]>
            <#assign accordionId = fieldLayout["@id"]?default(formId + "-accordion")>
            <#assign collapsible = (fieldLayout["@collapsible"]! == "true")>
            <#assign active = fieldLayout["@active"]!>
            <#assign collapsibleOpened = false>
            <#list formNode["field-layout"][0]?children as layoutNode>
                <#if layoutNode?node_name == "field-ref">
                  <#if collapsibleOpened>
                    <#assign collapsibleOpened = false>
                    </div><!-- /collapsible accordionId ${accordionId} -->
                    <#assign afterFormScript>
                        $("#${accordionId}").accordion({ collapsible: true,<#if active?has_content> active: ${active},</#if> heightStyle: "content" });
                    </#assign>
                    <#t>${sri.appendToScriptWriter(afterFormScript)}
                    <#assign accordionId = accordionId + "_A"><#-- set this just in case another accordion is opened -->
                  </#if>
                    <#assign fieldRef = layoutNode["@name"]>
                    <#assign fieldNode = "invalid">
                    <#list formNode["field"] as fn><#if fn["@name"] == fieldRef><#assign fieldNode = fn><#break></#if></#list>
                    <#if fieldNode == "invalid">
                        <div>Error: could not find field with name [${fieldRef}] referred to in a field-ref.@name attribute.</div>
                    <#else>
                        <@formSingleSubField fieldNode/>
                    </#if>
                <#elseif layoutNode?node_name == "fields-not-referenced">
                    <#assign nonReferencedFieldList = sri.getFtlFormFieldLayoutNonReferencedFieldList(.node["@name"])>
                    <#list nonReferencedFieldList as nonReferencedField><@formSingleSubField nonReferencedField/></#list>
                <#elseif layoutNode?node_name == "field-row">
                  <#if collapsibleOpened>
                    <#assign collapsibleOpened = false>
                    </div><!-- /collapsible accordionId ${accordionId} -->
                    <#assign afterFormScript>
                        $("#${accordionId}").accordion({ collapsible: true,<#if active?has_content> active: ${active},</#if> heightStyle: "content" });
                    </#assign>
                    <#t>${sri.appendToScriptWriter(afterFormScript)}
                    <#assign accordionId = accordionId + "_A"><#-- set this just in case another accordion is opened -->
                  </#if>
                    <div class="row"><#-- was field-row -->
                    <#assign inFieldRow = true>
                    <#assign bigRow = (layoutNode?children?size > 2)>
                    <#assign bigRowFirst = bigRow>
                    <#list layoutNode?children as rowChildNode>
                        <#if rowChildNode?node_name == "field-ref">
                            <#if !bigRow><div class="col-lg-6"></#if><#-- was field-row-item -->
                                <#assign fieldRef = rowChildNode["@name"]>
                                <#assign fieldNode = "invalid">
                                <#list formNode["field"] as fn><#if fn["@name"] == fieldRef><#assign fieldNode = fn><#break></#if></#list>
                                <#if fieldNode == "invalid">
                                    <div>Error: could not find field with name [${fieldRef}] referred to in a field-ref.@name attribute.</div>
                                <#else>
                                    <@formSingleSubField fieldNode/>
                                </#if>
                            <#if !bigRow></div><!-- /col-lg-6 not bigRow --></#if>
                        <#elseif rowChildNode?node_name == "fields-not-referenced">
                            <#assign nonReferencedFieldList = sri.getFtlFormFieldLayoutNonReferencedFieldList(.node["@name"])>
                            <#list nonReferencedFieldList as nonReferencedField><@formSingleSubField nonReferencedField/></#list>
                        </#if>
                    </#list>
                    <#if bigRow></div><!-- /col-lg-12 bigRow --></#if><#-- this is a bit weird, closes col-lg-12 opened by first in row in the formSingleWidget macro -->
                    <#assign bigRow = false>
                    <#assign inFieldRow = false>
                    </div><!-- /row -->
                <#elseif layoutNode?node_name == "field-group">
                  <#if collapsible && !collapsibleOpened><#assign collapsibleOpened = true>
                    <div id="${accordionId}">
                  </#if>
                    <h3><a href="#">${layoutNode["@title"]?default("Section " + layoutNode_index)}</a></h3>
                    <div<#if layoutNode["@style"]?has_content> class="${layoutNode["@style"]}"</#if>>
                        <#list layoutNode?children as groupNode>
                            <#if groupNode?node_name == "field-ref">
                                <#assign fieldRef = groupNode["@name"]>
                                <#assign fieldNode = "invalid">
                                <#list formNode["field"] as fn><#if fn["@name"] == fieldRef><#assign fieldNode = fn><#break></#if></#list>
                                <@formSingleSubField fieldNode/>
                            <#elseif groupNode?node_name == "fields-not-referenced">
                                <#assign nonReferencedFieldList = sri.getFtlFormFieldLayoutNonReferencedFieldList(.node["@name"])>
                                <#list nonReferencedFieldList as nonReferencedField><@formSingleSubField nonReferencedField/></#list>
                            <#elseif groupNode?node_name == "field-row">
                                <div class="row"><#-- was field-row -->
                                <#assign inFieldRow = true>
                                <#assign bigRow = (groupNode?children?size > 2)>
                                <#assign bigRowFirst = bigRow>
                                <#list groupNode?children as rowChildNode>
                                    <#if rowChildNode?node_name == "field-ref">
                                        <#if !bigRow><div class="col-lg-6"></#if><#-- was field-row-item -->
                                            <#assign fieldRef = rowChildNode["@name"]>
                                            <#assign fieldNode = "invalid">
                                            <#list formNode["field"] as fn><#if fn["@name"] == fieldRef><#assign fieldNode = fn><#break></#if></#list>
                                            <#if fieldNode == "invalid">
                                                <div>Error: could not find field with name [${fieldRef}] referred to in a field-ref.@name attribute.</div>
                                            <#else>
                                                <@formSingleSubField fieldNode/>
                                            </#if>
                                        <#if !bigRow></div><!-- /col-lg-6 not bigRow --></#if>
                                    <#elseif rowChildNode?node_name == "fields-not-referenced">
                                        <#assign nonReferencedFieldList = sri.getFtlFormFieldLayoutNonReferencedFieldList(.node["@name"])>
                                        <#list nonReferencedFieldList as nonReferencedField><@formSingleSubField nonReferencedField/></#list>
                                    </#if>
                                </#list>
                                <#if bigRow></div><!-- /col-lg-12 bigRow --></#if><#-- this is a bit weird, closes col-lg-12 opened by first in row in the formSingleWidget macro -->
                                <#assign bigRow = false>
                                <#assign inFieldRow = false>
                                </div><!-- /row -->
                            </#if>
                        </#list>
                    </div><!-- /layoutNode -->
                </#if>
            </#list>
            <#if collapsibleOpened>
                </div><!-- /accordion id ${accordionId} -->
                <#assign afterFormScript>
                    $("#${accordionId}").accordion({ collapsible: true,<#if active?has_content> active: ${active},</#if> heightStyle: "content" });
                </#assign>
                <#t>${sri.appendToScriptWriter(afterFormScript)}
            </#if>
    <#else>
        <#list formNode["field"] as fieldNode><@formSingleSubField fieldNode/></#list>
    </#if>
        </fieldset>
    <#if !skipEnd></form></#if>
    <#if !skipStart>
        <#assign afterFormScript>
            $("#${formId}").validate({ errorClass: 'help-block', errorElement: 'span',
                highlight: function(element, errorClass, validClass) { $(element).parents('.form-group').removeClass('has-success').addClass('has-error'); },
                unhighlight: function(element, errorClass, validClass) { $(element).parents('.form-group').removeClass('has-error').addClass('has-success'); }
            });
            <#-- TODO init tooltips
            $(document).tooltip();
            -->

            <#-- if background-submit=true init ajaxForm; for examples see http://www.malsup.com/jquery/form/#ajaxForm -->
            <#if formNode["@background-submit"]! == "true">
            function backgroundSuccess${formId}(responseText, statusText, xhr, $form) {
                <#if formNode["@background-reload-id"]?has_content>
                    load${formNode["@background-reload-id"]}();
                </#if>
                <#if formNode["@background-message"]?has_content>
                <#-- TODO: do something much fancier than a dumb alert box -->
                    alert("${formNode["@background-message"]}");
                </#if>
            }
            $("#${formId}").ajaxForm({ success: backgroundSuccess${formId}, dataType: 'json', resetForm: false });
            </#if>
        </#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    </#if>
    <#if formNode["@focus-field"]?has_content>
        <#assign afterFormScript>
            $("#${formId}_${formNode["@focus-field"]}").focus();
        </#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    </#if>
    <#if sri.doBoundaryComments()><!-- END   form-single[@name=${.node["@name"]}] --></#if>
</#macro>
<#macro formSingleSubField fieldNode>
    <#list fieldNode["conditional-field"] as fieldSubNode>
        <#if ec.resource.evaluateCondition(fieldSubNode["@condition"], "")>
            <@formSingleWidget fieldSubNode/>
            <#return>
        </#if>
    </#list>
    <#if fieldNode["default-field"]?has_content>
        <@formSingleWidget fieldNode["default-field"][0]/>
        <#return>
    </#if>
</#macro>
<#macro formSingleWidget fieldSubNode>
    <#if fieldSubNode["ignored"]?has_content && (fieldSubNode?parent["@hide"]! != "false")><#return></#if>
    <#if fieldSubNode["hidden"]?has_content && (fieldSubNode?parent["@hide"]! != "false")><#recurse fieldSubNode/><#return></#if>
    <#if fieldSubNode?parent["@hide"]! == "true"><#return></#if>
    <#assign curFieldTitle><@fieldTitle fieldSubNode/></#assign>
    <#if bigRow>
        <#if bigRowFirst>
            <div class="col-lg-12">
            <#assign bigRowFirst = false>
        </#if>
        <div class="field-row-item">
            <div class="form-group">
                <#if curFieldTitle?has_content && !fieldSubNode["submit"]?has_content>
                    <label class="control-label" for="${formId}_${fieldSubNode?parent["@name"]}">${curFieldTitle}</label><#-- was form-title -->
                </#if>
    <#else>
        <#if fieldSubNode["submit"]?has_content>
        <div class="form-group"><#-- was single-form-field -->
            <div class="<#if inFieldRow>col-lg-4<#else>col-lg-2</#if>"> </div>
            <div class="<#if inFieldRow>col-lg-8<#else>col-lg-10</#if>">
        <#elseif !(inFieldRow?if_exists && !curFieldTitle?has_content)>
        <div class="form-group"><#-- was single-form-field -->
            <label class="control-label <#if inFieldRow>col-lg-4<#else>col-lg-2</#if>" for="${formId}_${fieldSubNode?parent["@name"]}">${curFieldTitle}</label><#-- was form-title -->
            <div class="<#if inFieldRow>col-lg-8<#else>col-lg-10</#if>">
        </#if>
    </#if>
    <#-- NOTE: this style is only good for 2 fields in a field-row! in field-row cols are double size because are inside a col-lg-6 element -->
    ${sri.pushContext()}
    <#list fieldSubNode?children as widgetNode><#if widgetNode?node_name == "set">${sri.setInContext(widgetNode)}</#if></#list>
    <#list fieldSubNode?children as widgetNode>
        <#if widgetNode?node_name == "link">
            <#assign linkNode = widgetNode>
            <#assign linkUrlInfo = sri.makeUrlByType(linkNode["@url"], linkNode["@url-type"]!"transition", linkNode, linkNode["@expand-transition-url"]!"true")>
            <#assign linkFormId><@fieldId linkNode/></#assign>
            <#assign afterFormText><@linkFormForm linkNode linkFormId linkUrlInfo/></#assign>
            <#t>${sri.appendToAfterScreenWriter(afterFormText)}
            <#t><@linkFormLink linkNode linkFormId linkUrlInfo/>
        <#elseif widgetNode?node_name == "set"><#-- do nothing, handled above -->
        <#else><#t><#visit widgetNode>
        </#if>
    </#list>
    ${sri.popContext()}
    <#if bigRow>
        <#if curFieldTitle?has_content>
        </#if>
            </div><!-- /form-group -->
        </div><!-- /field-row-item -->
    <#else>
        <#if fieldSubNode["submit"]?has_content>
            </div><!-- /col -->
        </div><!-- /form-group -->
        <#elseif !(inFieldRow?if_exists && !curFieldTitle?has_content)>
            </div><!-- /col -->
        </div><!-- /form-group -->
        </#if>
    </#if>
</#macro>

<#macro "form-list">
<#if sri.doBoundaryComments()><!-- BEGIN form-list[@name=${.node["@name"]}] --></#if>
    <#-- Use the formNode assembled based on other settings instead of the straight one from the file: -->
    <#assign formNode = sri.getFtlFormNode(.node["@name"])>
    <#assign formId = ec.resource.evaluateStringExpand(formNode["@name"], "")>
    <#assign isMulti = formNode["@multi"]! == "true">
    <#assign isMultiFinalRow = false>
    <#assign skipStart = (formNode["@skip-start"]! == "true")>
    <#assign skipEnd = (formNode["@skip-end"]! == "true")>
    <#assign skipForm = (formNode["@skip-form"]! == "true")>
    <#assign urlInfo = sri.makeUrlByType(formNode["@transition"], "transition", null, "false")>
    <#assign listName = formNode["@list"]>
    <#assign listObject = ec.resource.evaluateContextField(listName, "")!>
    <#assign formListColumnList = formNode["form-list-column"]!>
    <#if !(formNode["@paginate"]! == "false") && context[listName + "Count"]?exists &&
            (context[listName + "Count"]! > 0) &&
            (!formNode["@paginate-always-show"]?has_content || formNode["@paginate-always-show"]! == "true" || (context[listName + "PageMaxIndex"] > 0))>
        <div class="form-list-paginate">
            <!-- page ${context[listName + "PageIndex"]} of ${context[listName + "PageMaxIndex"]} -->
            <#if (context[listName + "PageIndex"] > 0)>
                <#assign firstUrlInfo = sri.getCurrentScreenUrl().cloneUrlInfo().addParameter("pageIndex", 0)>
                <#assign previousUrlInfo = sri.getCurrentScreenUrl().cloneUrlInfo().addParameter("pageIndex", (context[listName + "PageIndex"] - 1))>
                <a href="${firstUrlInfo.getUrlWithParams()}">|&lt;</a>
                <a href="${previousUrlInfo.getUrlWithParams()}">&lt;</a>
            <#else>
                <span>|&lt;</span>
                <span>&lt;</span>
            </#if>
            <span>${context[listName + "PageRangeLow"]} - ${context[listName + "PageRangeHigh"]} / ${context[listName + "Count"]}</span>
            <#if (context[listName + "PageIndex"] < context[listName + "PageMaxIndex"])>
                <#assign lastUrlInfo = sri.getCurrentScreenUrl().cloneUrlInfo().addParameter("pageIndex", context[listName + "PageMaxIndex"])>
                <#assign nextUrlInfo = sri.getCurrentScreenUrl().cloneUrlInfo().addParameter("pageIndex", context[listName + "PageIndex"] + 1)>
                <a href="${nextUrlInfo.getUrlWithParams()}">&gt;</a>
                <a href="${lastUrlInfo.getUrlWithParams()}">&gt;|</a>
            <#else>
                <span>&gt;</span>
                <span>&gt;|</span>
            </#if>
        </div>
    </#if>
    <#if formListColumnList?? && (formListColumnList?size > 0)>
        <#if !skipStart>
        <div class="form-list-outer" id="${formId}-table">
            <div class="form-header-group">
                <#assign needHeaderForm = sri.isFormHeaderForm(formNode["@name"])>
                <#if needHeaderForm && !skipForm>
                    <#assign curUrlInfo = sri.getCurrentScreenUrl()>
                    <#assign headerFormId>${formId}-header</#assign>
                <form name="${headerFormId}" id="${headerFormId}" class="form-header-row" method="post" action="${curUrlInfo.url}">
                    <input type="hidden" name="moquiFormName" value="${formNode["@name"]}">
                    <#assign nonReferencedFieldList = sri.getFtlFormListColumnNonReferencedHiddenFieldList(.node["@name"])>
                    <#list nonReferencedFieldList as nonReferencedField><#if nonReferencedField["header-field"]?has_content><#recurse nonReferencedField["header-field"][0]/></#if></#list>
                <#else>
                <div class="form-header-row">
                </#if>
                    <#list formListColumnList as fieldListColumn>
                        <div class="form-header-cell">
                        <#list fieldListColumn["field-ref"] as fieldRef>
                            <#assign fieldRefName = fieldRef["@name"]>
                            <#assign fieldNode = "invalid">
                            <#list formNode["field"] as fn><#if fn["@name"] == fieldRefName><#assign fieldNode = fn><#break></#if></#list>
                            <#if fieldNode == "invalid">
                                <div>Error: could not find field with name [${fieldRefName}] referred to in a form-list-column.field-ref.@name attribute.</div>
                            <#else>
                                <#if !(fieldNode["@hide"]! == "true" ||
                                        ((!fieldNode["@hide"]?has_content) && fieldNode?children?size == 1 &&
                                        (fieldNode?children[0]["hidden"]?has_content || fieldNode?children[0]["ignored"]?has_content)))>
                                    <div><@formListHeaderField fieldNode/></div>
                                </#if>
                            </#if>
                        </#list>
                        </div>
                    </#list>
                <#if needHeaderForm && !skipForm>
                </form>
                    <#if _dynamic_container_id?has_content>
                        <#-- if we have an _dynamic_container_id this was loaded in a dynamic-container so init ajaxForm; for examples see http://www.malsup.com/jquery/form/#ajaxForm -->
                        <#assign afterFormScript>
                            $("#${headerFormId}").ajaxForm({ target: '#${_dynamic_container_id}', <#-- success: activateAllButtons, --> resetForm: false });
                        </#assign>
                        <#t>${sri.appendToScriptWriter(afterFormScript)}
                    </#if>
                <#else>
                </div>
                </#if>
            </div>
            <#if isMulti && !skipForm>
                <form name="${formId}" id="${formId}" class="form-body" method="post" action="${urlInfo.url}">
                    <input type="hidden" name="moquiFormName" value="${formNode["@name"]}">
                    <input type="hidden" name="_isMulti" value="true">
            <#else>
                <div class="form-body">
            </#if>
        </#if>
        <#list listObject! as listEntry>
            <#assign listEntryIndex = listEntry_index>
            <#-- NOTE: the form-list.@list-entry attribute is handled in the ScreenForm class through this call: -->
            ${sri.startFormListRow(formNode["@name"], listEntry, listEntry_index, listEntry_has_next)}
            <#if isMulti || skipForm>
            <div class="form-row">
            <#else>
            <form name="${formId}_${listEntryIndex}" id="${formId}_${listEntryIndex}" class="form-row" method="post" action="${urlInfo.url}">
            </#if>
            <#assign nonReferencedFieldList = sri.getFtlFormListColumnNonReferencedHiddenFieldList(.node["@name"])>
            <#list nonReferencedFieldList as nonReferencedField><@formListSubField nonReferencedField/></#list>
            <#list formNode["form-list-column"] as fieldListColumn>
                <div class="form-cell">
                <#list fieldListColumn["field-ref"] as fieldRef>
                    <#assign fieldRefName = fieldRef["@name"]>
                    <#assign fieldNode = "invalid">
                    <#list formNode["field"] as fn><#if fn["@name"] == fieldRefName><#assign fieldNode = fn><#break></#if></#list>
                    <#if fieldNode == "invalid">
                        <div>Error: could not find field with name [${fieldRefName}] referred to in a form-list-column.field-ref.@name attribute.</div>
                    <#else>
                        <#assign formListSkipClass = true>
                        <@formListSubField fieldNode/>
                    </#if>
                </#list>
                </div>
            </#list>
            <#if isMulti || skipForm>
            </div>
            <#else>
                <#assign afterFormScript>
                    $("#${formId}_${listEntryIndex}").validate();
                </#assign>
                <#t>${sri.appendToScriptWriter(afterFormScript)}
            </form>
            </#if>
            ${sri.endFormListRow()}
        </#list>
        <#assign listEntryIndex = "">
        ${sri.safeCloseList(listObject)}<#-- if listObject is an EntityListIterator, close it -->
        <#if !skipEnd>
            <#if isMulti && !skipForm>
                <div class="form-bottom-row">
                    <#assign isMultiFinalRow = true>
                    <#list formNode["field"] as fieldNode><@formListSubField fieldNode/></#list>
                </div>
                </form>
            <#else>
                </div><!-- close form-body -->
            </#if>
            </div><!-- close table -->
        </#if>
        <#if isMulti && !skipStart && !skipForm>
            <#assign afterFormScript>
                $("#${formId}").validate();
                <#-- TODO $(document).tooltip(); -->
            </#assign>
            <#t>${sri.appendToScriptWriter(afterFormScript)}
        </#if>
    <#else>
        <#if !skipStart>
        <div class="form-list-outer" id="${formId}-table">
            <div class="form-header-group">
                <#assign needHeaderForm = sri.isFormHeaderForm(formNode["@name"])>
                <#if needHeaderForm && !skipStart && !skipForm>
                    <#assign curUrlInfo = sri.getCurrentScreenUrl()>
                    <form name="${formId}-header" id="${formId}-header" class="form-header-row" method="post" action="${curUrlInfo.url}">
                <#else>
                    <div class="form-header-row">
                </#if>
                    <#list formNode["field"] as fieldNode>
                        <#assign allHidden = true>
                        <#list fieldNode?children as fieldSubNode><#if !(fieldSubNode["hidden"]?has_content || fieldSubNode["ignored"]?has_content)><#assign allHidden = false></#if></#list>
                        <#if !(fieldNode["@hide"]! == "true" || allHidden ||
                                ((!fieldNode["@hide"]?has_content) && fieldNode?children?size == 1 &&
                                (fieldNode["header-field"][0]?if_exists["hidden"]?has_content || fieldNode["header-field"][0]?if_exists["ignored"]?has_content))) &&
                                !(isMulti && fieldNode["default-field"]?has_content && fieldNode["default-field"][0]["submit"]?has_content)>
                            <div class="form-header-cell"><@formListHeaderField fieldNode/></div>
                        <#elseif fieldNode["header-field"][0]?if_exists["hidden"]?has_content>
                            <#recurse fieldNode["header-field"][0]/>
                        </#if>
                    </#list>
                <#if needHeaderForm && !skipStart && !skipForm>
                    </form>
                <#else>
                    </div>
                </#if>
            </div>
            <#if isMulti && !skipForm>
                <form name="${formId}" id="${formId}" class="form-body" method="post" action="${urlInfo.url}">
                    <input type="hidden" name="moquiFormName" value="${formNode["@name"]}">
                    <input type="hidden" name="_isMulti" value="true">
            <#else>
                <div class="form-body">
            </#if>
        </#if>
        <#list listObject! as listEntry>
            <#assign listEntryIndex = listEntry_index>
            <#-- NOTE: the form-list.@list-entry attribute is handled in the ScreenForm class through this call: -->
            ${sri.startFormListRow(formNode["@name"], listEntry, listEntry_index, listEntry_has_next)}
            <#if isMulti || skipForm>
                <div class="form-row">
            <#else>
                <form name="${formId}_${listEntryIndex}" id="${formId}_${listEntryIndex}" class="form-row" method="post" action="${urlInfo.url}">
            </#if>
                <#list formNode["field"] as fieldNode><@formListSubField fieldNode/></#list>
            <#if isMulti || skipForm>
                </div>
            <#else>
                <#assign afterFormScript>
                    $("#${formId}_${listEntryIndex}").validate();
                </#assign>
                <#t>${sri.appendToScriptWriter(afterFormScript)}
                </form>
            </#if>
            ${sri.endFormListRow()}
        </#list>
        <#assign listEntryIndex = "">
        ${sri.safeCloseList(listObject)}<#-- if listObject is an EntityListIterator, close it -->
        <#if !skipEnd>
            <#if isMulti && !skipForm>
                <div class="form-bottom-row">
                    <#assign isMultiFinalRow = true>
                    <#list formNode["field"] as fieldNode><@formListSubField fieldNode/></#list>
                </div>
                </form>
            <#else>
                </div>
            </#if>
            </div>
        </#if>
        <#if isMulti && !skipStart && !skipForm>
            <#assign afterFormScript>
                $("#${formId}").validate();
                <#-- TODO $(document).tooltip(); -->
            </#assign>
            <#t>${sri.appendToScriptWriter(afterFormScript)}
        </#if>
    </#if>
<#if sri.doBoundaryComments()><!-- END   form-list[@name=${.node["@name"]}] --></#if>
</#macro>
<#macro formListHeaderField fieldNode>
    <#if fieldNode["header-field"]?has_content>
        <#assign fieldSubNode = fieldNode["header-field"][0]>
    <#elseif fieldNode["default-field"]?has_content>
        <#assign fieldSubNode = fieldNode["default-field"][0]>
    <#else>
        <#-- this only makes sense for fields with a single conditional -->
        <#assign fieldSubNode = fieldNode["conditional-field"][0]>
    </#if>
    <#assign headerFieldNode = fieldNode["header-field"][0]!>
    <#assign defaultFieldNode = fieldNode["default-field"][0]!>
    <div class="form-title">
        <#if fieldSubNode["submit"]?has_content>&nbsp;<#else><#if headerFieldNode["@title"]?has_content><@fieldTitle headerFieldNode/><#elseif defaultFieldNode["@title"]?has_content><@fieldTitle defaultFieldNode/><#else><@fieldTitle fieldSubNode/></#if></#if>
        <#if fieldSubNode["@show-order-by"]! == "true" || fieldSubNode["@show-order-by"]! == "case-insensitive">
            <#assign caseInsensitive = fieldSubNode["@show-order-by"]! == "case-insensitive">
            <#assign orderByField = ec.web.requestParameters.orderByField!>
            <#assign ascActive = orderByField?has_content && orderByField?contains(fieldNode["@name"]) && !orderByField?starts_with("-")>
            <#assign ascOrderByUrlInfo = sri.getCurrentScreenUrl().cloneUrlInfo().addParameter("orderByField", "+" + caseInsensitive?string("^","") + fieldNode["@name"])>
            <#assign descActive = orderByField?has_content && orderByField?contains(fieldNode["@name"]) && orderByField?starts_with("-")>
            <#assign descOrderByUrlInfo = sri.getCurrentScreenUrl().cloneUrlInfo().addParameter("orderByField", "-" + caseInsensitive?string("^","") + fieldNode["@name"])>
            <a href="${ascOrderByUrlInfo.getUrlWithParams()}" class="form-order-by<#if ascActive> active</#if>">+</a><a href="${descOrderByUrlInfo.getUrlWithParams()}" class="form-order-by<#if descActive> active</#if>">-</a>
            <#-- the old way, show + or -:
            <#if !orderByField?has_content || orderByField?starts_with("-") || !orderByField?contains(fieldNode["@name"])><#assign orderByField = ("+" + fieldNode["@name"])><#else><#assign orderByField = ("-" + fieldNode["@name"])></#if>
            <#assign orderByUrlInfo = sri.getCurrentScreenUrl().cloneUrlInfo().addParameter("orderByField", orderByField)>
            <a href="${orderByUrlInfo.getUrlWithParams()}" class="form-order-by">${orderByField?substring(0,1)}</a>
            -->
        </#if>
    </div>
    <#if fieldNode["header-field"]?has_content && fieldNode["header-field"][0]?children?has_content>
    <div class="form-header-field">
        <@formListWidget fieldNode["header-field"][0] true/>
        <#-- <#recurse fieldNode["header-field"][0]/> -->
    </div>
    </#if>
</#macro>
<#macro formListSubField fieldNode>
    <#list fieldNode["conditional-field"] as fieldSubNode>
        <#if ec.resource.evaluateCondition(fieldSubNode["@condition"], "")>
            <@formListWidget fieldSubNode/>
            <#return>
        </#if>
    </#list>
    <#if fieldNode["default-field"]?has_content>
        <#assign isHeaderField=false>
        <@formListWidget fieldNode["default-field"][0]/>
        <#return>
    </#if>
</#macro>
<#macro formListWidget fieldSubNode isHeaderField=false>
    <#if fieldSubNode["ignored"]?has_content><#return/></#if>
    <#if fieldSubNode?parent["@hide"]! == "true"><#return></#if>
    <#-- don't do a column for submit fields, they'll go in their own row at the bottom -->
    <#t><#if !isHeaderField && isMulti && !isMultiFinalRow && fieldSubNode["submit"]?has_content><#return/></#if>
    <#t><#if !isHeaderField && isMulti && isMultiFinalRow && !fieldSubNode["submit"]?has_content><#return/></#if>
    <#if fieldSubNode["hidden"]?has_content><#recurse fieldSubNode/><#return/></#if>
    <#if !isMultiFinalRow><div<#if !formListSkipClass?if_exists> class="form-cell"</#if>></#if>
        ${sri.pushContext()}
        <#list fieldSubNode?children as widgetNode><#if widgetNode?node_name == "set">${sri.setInContext(widgetNode)}</#if></#list>
        <#list fieldSubNode?children as widgetNode>
            <#if widgetNode?node_name == "link">
                <#assign linkNode = widgetNode>
                <#assign linkUrlInfo = sri.makeUrlByType(linkNode["@url"], linkNode["@url-type"]!"transition", linkNode, linkNode["@expand-transition-url"]!"true")>
                <#assign linkFormId><@fieldId linkNode/></#assign>
                <#assign afterFormText><@linkFormForm linkNode linkFormId linkUrlInfo/></#assign>
                <#t>${sri.appendToAfterScreenWriter(afterFormText)}
                <#t><@linkFormLink linkNode linkFormId linkUrlInfo/>
            <#elseif widgetNode?node_name == "set"><#-- do nothing, handled above -->
            <#else><#t><#visit widgetNode></#if>
        </#list>
        ${sri.popContext()}
    <#if !isMultiFinalRow></div></#if>
</#macro>
<#macro "row-actions"><#-- do nothing, these are run by the SRI --></#macro>

<#macro fieldName widgetNode><#assign fieldNode=widgetNode?parent?parent/>${fieldNode["@name"]?html}<#if isMulti?exists && isMulti && listEntryIndex?has_content>_${listEntryIndex}</#if></#macro>
<#macro fieldId widgetNode><#assign fieldNode=widgetNode?parent?parent/>${ec.resource.evaluateStringExpand(fieldNode?parent["@name"], "")}_${fieldNode["@name"]}<#if listEntryIndex?has_content>_${listEntryIndex}</#if></#macro>
<#macro fieldTitle fieldSubNode><#assign titleValue><#if fieldSubNode["@title"]?has_content>${ec.resource.evaluateStringExpand(fieldSubNode["@title"], "")}<#else><#list fieldSubNode?parent["@name"]?split("(?=[A-Z])", "r") as nameWord>${nameWord?cap_first?replace("Id", "ID")}<#if nameWord_has_next> </#if></#list></#if></#assign>${ec.l10n.getLocalizedMessage(titleValue)}</#macro>

<#macro field><#-- shouldn't be called directly, but just in case --><#recurse/></#macro>
<#macro "conditional-field"><#-- shouldn't be called directly, but just in case --><#recurse/></#macro>
<#macro "default-field"><#-- shouldn't be called directly, but just in case --><#recurse/></#macro>
<#macro set><#-- shouldn't be called directly, but just in case --><#recurse/></#macro>

<#-- ================== Form Field Widgets ==================== -->

<#macro check>
    <#assign options = {"":""}/><#assign options = sri.getFieldOptions(.node)>
    <#assign currentValue = sri.getFieldValueString(.node?parent?parent, "", null)>
    <#if !currentValue?has_content><#assign currentValue = ec.resource.evaluateStringExpand(.node["@no-current-selected-key"]!, "")/></#if>
    <#assign id><@fieldId .node/></#assign>
    <#assign curName><@fieldName .node/></#assign>
    <#list (options.keySet())! as key>
        <#assign allChecked = ec.resource.evaluateStringExpand(.node["@all-checked"]!, "")>
        <span id="${id}<#if (key_index > 0)>_${key_index}</#if>"><input type="checkbox" name="${curName}" value="${key?html}"<#if allChecked! == "true"> checked="checked"<#elseif currentValue?has_content && currentValue==key> checked="checked"</#if><#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>${options.get(key)?default("")}</span>
    </#list>
</#macro>

<#macro "date-find">
<span class="form-date-find">
    <#assign curFieldName><@fieldName .node/></#assign>
    <#if .node["@type"]! == "time"><#assign size=9/><#assign maxlength=12/><#elseif .node["@type"]! == "date"><#assign size=10/><#assign maxlength=10/><#else><#assign size=23/><#assign maxlength=23/></#if>
    <#assign id><@fieldId .node/></#assign>
    <span>${ec.l10n.getLocalizedMessage("From")}&nbsp;</span><input type="text" class="form-control" name="${curFieldName}_from" value="${ec.web.parameters.get(curFieldName + "_from")!?default(.node["@default-value-from"]!"")?html}" size="${size}" maxlength="${maxlength}" id="${id}_from"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
    <span>${ec.l10n.getLocalizedMessage("Thru")}&nbsp;</span><input type="text" class="form-control" name="${curFieldName}_thru" value="${ec.web.parameters.get(curFieldName + "_thru")!?default(.node["@default-value-thru"]!"")?html}" size="${size}" maxlength="${maxlength}" id="${id}_thru"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
    <#if .node["@type"]! != "time">
        <#-- TODO: replace datepicker()
        <#assign afterFormScript>
            <#if .node["@type"]! == "date">
            $("#${id}_from,#${id}_thru").datepicker({
            <#else>
            $("#${id}_from,#${id}_thru").datetimepicker({showSecond: true, timeFormat: 'hh:mm:ss', stepHour: 1, stepMinute: 5, stepSecond: 5,
            </#if>showOn: 'button', buttonImage: '', buttonText: '...', buttonImageOnly: false, dateFormat: 'yy-mm-dd'});
        </#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
        -->
    </#if>
</span>
</#macro>

<#--
Bootstrap datepicker format refer to https://github.com/smalot/bootstrap-datetimepicker
Java simple date format refer to http://docs.oracle.com/javase/6/docs/api/java/text/SimpleDateFormat.html
Java	Datepicker	Description
a	    p	        am/pm
a	    P	        AM/PM
s	    s	        seconds without leading zeros
ss	    ss	        seconds, 2 digits with leading zeros
m	    i	        minutes without leading zeros
mm	    ii	        minutes, 2 digits with leading zeros
H	    h	        hour without leading zeros - 24-hour format
HH	    hh	        hour, 2 digits with leading zeros - 24-hour format
h	    H	        hour without leading zeros - 12-hour format
hh	    HH	        hour, 2 digits with leading zeros - 12-hour format
d	    d	        day of the month without leading zeros
dd	    dd	        day of the month, 2 digits with leading zeros
M	    m	        numeric representation of month without leading zeros
MM	    mm	        numeric representation of the month, 2 digits with leading zeros
MMM	    M	        short textual representation of a month, three letters
MMMM	MM	        full textual representation of a month, such as January or March
yy	    yy	        two digit representation of a year
yyyy	yyyy	    full numeric representation of a year, 4 digits

The java format that requires to be translate to bootstrap datepicker format, others not in this list but in SimpleDateFormat should not be used:
a -> p, m -> i, h -> H, H -> h, M -> m, MMM -> M, MMMM -> MM
-->
<#-- if condition to avoid recursion of replacing "h" and "H" -->
<#macro getBootstrapDateFormat dateFormat><#if dateFormat?contains("h")>${dateFormat?replace("a","p")?replace("m","i")?replace("h","H")?replace("M","m")?replace("mmmm","MM")?replace("mmm","M")}<#else>${dateFormat?replace("a","p")?replace("m","i")?replace("H","h")?replace("M","m")?replace("mmmm","MM")?replace("mmm","M")}</#if></#macro>

<#macro "date-time">
<span class="form-date-time">
    <#if .node["@type"]! == "time"><#assign size=9><#assign maxlength=13><#assign defaultFormat="HH:mm:ss">
    <#elseif .node["@type"]! == "date"><#assign size=10><#assign maxlength=10><#assign defaultFormat="yyyy-MM-dd">
    <#else><#assign size=19><#assign maxlength=23><#assign defaultFormat="yyyy-MM-dd HH:mm:ss">
    </#if>
    <#assign fieldValue = sri.getFieldValueString(.node?parent?parent, .node["@default-value"]!"", .node["@format"]!defaultFormat)>
    <#assign id><@fieldId .node/></#assign>
    <#assign datepickerFormat><@getBootstrapDateFormat .node["@format"]!defaultFormat/></#assign>
    <#assign size = .node["@size"]?default(size)>
    <#assign maxlength = .node["@max-length"]?default(maxlength)>
    <#if .node["@type"]! != "time">
        <#if .node["@type"]! == "date">
            <div class="input-group input-append date" id="${id}" data-date="${fieldValue?html}" data-date-format="${datepickerFormat}">
                <input type="text" class="form-control" name="<@fieldName .node/>" value="${fieldValue?html}" size="${size}" maxlength="${maxlength}"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
                <#-- <span class="input-group-addon add-on"><i class="glyphicon glyphicon-remove"></i></span> -->
                <span class="input-group-addon add-on"><i class="glyphicon glyphicon-calendar"></i></span>
            </div>
            <#assign afterFormScript>$('#${id}').datetimepicker({minView:2, pickerPosition:'bottom-left'});</#assign>
            <#t>${sri.appendToScriptWriter(afterFormScript)}
        <#else>
            <div class="input-group input-append date" id="${id}" data-date="${fieldValue?html}" data-date-format="${datepickerFormat}">
                <input type="text" class="form-control" name="<@fieldName .node/>" value="${fieldValue?html}" size="${size}" maxlength="${maxlength}"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
            <#-- <span class="input-group-addon add-on"><i class="glyphicon glyphicon-remove"></i></span> -->
                <span class="input-group-addon add-on"><i class="glyphicon glyphicon-calendar"></i></span>
            </div>
            <#assign afterFormScript>$('#${id}').datetimepicker({pickerPosition:'bottom-left'});</#assign>
            <#t>${sri.appendToScriptWriter(afterFormScript)}
        </#if>
    <#else>
        <div class="input-group input-append date" id="${id}" data-date="${fieldValue?html}" data-date-format="${datepickerFormat}">
            <input type="text" class="form-control" name="<@fieldName .node/>" value="${fieldValue?html}" size="${size}" maxlength="${maxlength}"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
        <#-- <span class="input-group-addon add-on"><i class="glyphicon glyphicon-remove"></i></span> -->
            <span class="input-group-addon add-on"><i class="glyphicon glyphicon-time"></i></span>
        </div>
        <#assign afterFormScript>$('#${id}').datetimepicker({startView:1, maxView:1, pickerPosition:'bottom-left'});</#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    </#if>

    <#-- old jquery stuff:
    <input type="text" name="<@fieldName .node/>" value="${fieldValue?html}" size="${size}" maxlength="${maxlength}" id="${id}"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
    <#if .node["@type"]! != "time">
        <#assign afterFormScript>
                <#if .node["@type"]! == "date">
                $("#${id}").datepicker({
                <#else>
                $("#${id}").datetimepicker({showSecond: true, timeFormat: 'hh:mm:ss', stepHour: 1, stepMinute: 1, stepSecond: 1,
                </#if>showOn: 'button', buttonImage: '/images/icon-calendar.png', buttonText: 'Calendar', buttonImageOnly: true, dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true, showButtonPanel: true});
        </#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    </#if>
    -->
</span>
</#macro>

<#macro display>
    <#assign fieldValue = ""/>
    <#if .node["@text"]?has_content>
        <#assign fieldValue = ec.resource.evaluateStringExpand(.node["@text"], "")>
        <#if .node["@currency-unit-field"]?has_content>
            <#assign fieldValue = ec.l10n.formatCurrency(fieldValue, ec.resource.evaluateContextField(.node["@currency-unit-field"], ""), 2)>
        </#if>
    <#elseif .node["@currency-unit-field"]?has_content>
        <#assign fieldValue = ec.l10n.formatCurrency(sri.getFieldValue(.node?parent?parent, ""), ec.resource.evaluateContextField(.node["@currency-unit-field"], ""), 2)>
    <#else>
        <#assign fieldValue = sri.getFieldValueString(.node?parent?parent, "", .node["@format"]!)>
    </#if>
    <#t><span id="<@fieldId .node/>" class="${sri.getFieldValueClass(.node?parent?parent)}<#if .node["@currency-unit-field"]?has_content> currency</#if>"><#if .node["@encode"]! == "false">${fieldValue!"&nbsp;"}<#else>${(fieldValue!" ")?html?replace("\n", "<br>")}</#if></span>
    <#t><#if !.node["@also-hidden"]?has_content || .node["@also-hidden"] == "true">
        <#-- use getFieldValuePlainString() and not getFieldValueString() so we don't do timezone conversions, etc -->
        <input type="hidden" name="<@fieldName .node/>" value="${sri.getFieldValuePlainString(.node?parent?parent, fieldValue!"")?html}">
    </#if>
</#macro>
<#macro "display-entity">
    <#assign fieldValue = ""/><#assign fieldValue = sri.getFieldEntityValue(.node)/>
    <#t><#if formNode?node_name == "form-single"><span id="<@fieldId .node/>"></#if><#if .node["@encode"]!"true" == "false">${fieldValue!"&nbsp;"}<#else>${(fieldValue!" ")?html?replace("\n", "<br>")}</#if><#if formNode?node_name == "form-single"></span></#if>
    <#t><#if !.node["@also-hidden"]?has_content || .node["@also-hidden"] == "true"><input type="hidden" name="<@fieldName .node/>" value="${sri.getFieldValuePlainString(.node?parent?parent, fieldValue!"")?html}"></#if>
</#macro>

<#macro "drop-down">
    <#assign options = {"":""}/><#assign options = sri.getFieldOptions(.node)/>
    <#assign currentValue = sri.getFieldValueString(.node?parent?parent, "", null)/>
    <#if !currentValue?has_content><#assign currentValue = ec.resource.evaluateStringExpand(.node["@no-current-selected-key"]!, "")/></#if>
    <#assign currentDescription = (options.get(currentValue))!/>
    <#if !currentDescription?has_content && .node["@current-description"]?has_content>
        <#assign currentDescription = ec.resource.evaluateStringExpand(.node["@current-description"], "")/>
    </#if>
    <#assign id><@fieldId .node/></#assign>
    <select name="<@fieldName .node/>" class="form-control" id="${id}"<#if .node["@allow-multiple"]! == "true"> multiple="multiple"</#if><#if .node["@size"]?has_content> size="${.node["@size"]}"</#if><#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
    <#if currentValue?has_content && (.node["@current"]! != "selected") && !(.node["@allow-multiple"]! == "true")>
        <option selected="selected" value="${currentValue}"><#if currentDescription?has_content>${currentDescription}<#else>${currentValue}</#if></option><#rt/>
        <option value="${currentValue}">---</option><#rt/>
    </#if>
    <#assign allowEmpty = ec.resource.evaluateStringExpand(.node["@allow-empty"]!, "")/>
    <#if (allowEmpty! == "true") || !(options?has_content)>
        <option value="">&nbsp;</option>
    </#if>

    <#if !.node["dynamic-options"]?has_content>
        <#list (options.keySet())! as key>
            <option<#if currentValue?has_content && currentValue == key> selected="selected"</#if> value="${key}">${options.get(key)}</option>
        </#list>
    </#if>
    </select>
    <#if .node["@combo-box"]! == "true">
    <#-- TODO: find a real combobox that allows entering additional elements; make sure chosen style removed for whatever it is
        <#assign afterFormScript>$("#${id}").combobox();</#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    -->
        <#assign afterFormScript>$("#${id}").chosen({ search_contains:true, disable_search_threshold:10 });</#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    <#elseif .node["@search"]! != "false">
        <#assign afterFormScript>$("#${id}").chosen({ search_contains:true, disable_search_threshold:10 });</#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    </#if>

    <#if .node["dynamic-options"]?has_content>
        <#assign doNode = .node["dynamic-options"][0]>
        <#assign depNodeList = doNode["depends-on"]>
        <#assign formName = ec.resource.evaluateStringExpand(formNode["@name"], "")>
        <#assign afterFormScript>
            function populate_${id}() {
                $.ajax({ type:'POST', url:'${sri.screenUrlInfo.url}/${doNode["@transition"]}', data:{ <#list depNodeList as depNode>'${depNode["@field"]}': $('#${formName}_${depNode["@field"]}').val()<#if depNode_has_next>, </#if></#list> }, dataType:'json' }).done(
                    function(list) {
                        if (list) {
                            $('#${id}').html(""); /* clear out the drop-down */
                            <#if allowEmpty! == "true">
                            $('#${id}').append('<option value="">&nbsp;</option>');
                            </#if>
                            $.each(list, function(key, value) {
                                var optionValue = value["${doNode["@value-field"]!"value"}"];
                                if (optionValue == "${currentValue}") {
                                    $('#${id}').append("<option selected='selected' value='" + optionValue + "'>" + value["${doNode["@label-field"]!"label"}"] + "</option>");
                                } else {
                                    $('#${id}').append("<option value='" + optionValue + "'>" + value["${doNode["@label-field"]!"label"}"] + "</option>");
                                }
                            });
                            $("#${id}").trigger("chosen:updated");
                }; } ); };
            $(document).ready(function() {
                <#list depNodeList as depNode>
                    $("#${formName}_${depNode["@field"]}").change(function() { populate_${id}(); });
                </#list>
                populate_${id}();
            });
        </#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    </#if>
</#macro>

<#macro file><input type="file" class="form-control" name="<@fieldName .node/>" value="${sri.getFieldValueString(.node?parent?parent, .node["@default-value"]!"", null)?html}" size="${.node.@size!"30"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if><#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>></#macro>

<#macro hidden>
    <#-- use getFieldValuePlainString() and not getFieldValueString() so we don't do timezone conversions, etc -->
    <#assign id><@fieldId .node/></#assign>
    <input type="hidden" name="<@fieldName .node/>" value="${sri.getFieldValuePlainString(.node?parent?parent, .node["@default-value"]!"")?html}" id="${id}">
</#macro>

<#macro ignored><#-- shouldn't ever be called as it is checked in the form-* macros --></#macro>

<#-- TABLED, not to be part of 1.0:
<#macro "lookup">
    <#assign curFieldName = .node?parent?parent["@name"]?html/>
    <#assign curFormName = .node?parent?parent?parent["@name"]?html/>
    <#assign id><@fieldId .node/></#assign>
    <input type="text" name="${curFieldName}" value="${sri.getFieldValueString(.node?parent?parent, .node["@default-value"]!"", null)?html}" size="${.node.@size!"30"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if><#if ec.resource.evaluateCondition(.node.@disabled!"false", "")> disabled="disabled"</#if> id="${id}">
    <#assign ajaxUrl = ""/><#- - LATER once the JSON service stuff is in place put something real here - ->
    <#- - LATER get lookup code in place, or not... - ->
    <script>
        $(document).ready(function() {
            new ConstructLookup("${.node["@target-screen"]}", "${id}", document.${curFormName}.${curFieldName},
            <#if .node["@secondary-field"]?has_content>document.${curFormName}.${.node["@secondary-field"]}<#else>null</#if>,
            "${curFormName}", "${width!""}", "${height!""}", "${position!"topcenter"}", "${fadeBackground!"true"}", "${ajaxUrl!""}", "${showDescription!""}", ''); });
    </script>
</#macro>
-->

<#macro password><input type="password" class="form-control" name="<@fieldName .node/>" size="${.node.@size!"25"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if> id="<@fieldId .node/>"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>></#macro>

<#macro radio>
    <#assign options = {"":""}/><#assign options = sri.getFieldOptions(.node)/>
    <#assign currentValue = sri.getFieldValueString(.node?parent?parent, "", null)/>
    <#if !currentValue?has_content><#assign currentValue = ec.resource.evaluateStringExpand(.node["@no-current-selected-key"]!, "")/></#if>
    <#assign id><@fieldId .node/></#assign>
    <#assign curName><@fieldName .node/></#assign>
    <#list (options.keySet())! as key>
        <span id="${id}<#if (key_index > 0)>_${key_index}</#if>"><input type="radio" name="${curName}" value="${key?html}"<#if currentValue?has_content && currentValue==key> checked="checked"</#if><#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>&nbsp;${options.get(key)?default("")}</span>
    </#list>
</#macro>

<#macro "range-find">
<span class="form-range-find">
    <#assign curFieldName><@fieldName .node/></#assign>
    <#assign id><@fieldId .node/></#assign>
    <span>${ec.l10n.getLocalizedMessage("From")}&nbsp;</span><input type="text" class="form-control" name="${curFieldName}_from" value="${ec.web.parameters.get(curFieldName + "_from")!?default(.node["@default-value-from"]!"")?html}" size="${.node.@size!"10"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if> id="${id}_from"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
    <span>${ec.l10n.getLocalizedMessage("Through")}&nbsp;</span><input type="text" class="form-control" name="${curFieldName}_thru" value="${ec.web.parameters.get(curFieldName + "_thru")!?default(.node["@default-value-thru"]!"")?html}" size="${.node.@size!"10"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if> id="${id}_thru"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
</span>
</#macro>

<#macro reset><input type="reset" name="<@fieldName .node/>" value="<@fieldTitle .node?parent/>" id="<@fieldId .node/>"<#if .node["@icon"]?has_content> iconcls="ui-icon-${.node["@icon"]}"</#if><#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>></#macro>

<#macro submit>
    <#assign confirmationMessage = ec.resource.evaluateStringExpand(.node["@confirmation"]!, "")/>
    <button type="submit" name="<@fieldName .node/>" id="<@fieldId .node/>"<#if confirmationMessage?has_content> onclick="return confirm('${confirmationMessage?js_string}');"</#if><#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if> class="btn btn-primary"><#if .node["@icon"]?has_content><i class="${.node["@icon"]}"></i> </#if>
    <#if .node["image"]?has_content><#assign imageNode = .node["image"][0]>
        <img src="${sri.makeUrlByType(imageNode["@url"],imageNode["@url-type"]!"content",null,"true")}" alt="<#if imageNode["@alt"]?has_content>${imageNode["@alt"]}<#else><@fieldTitle .node?parent/></#if>"<#if imageNode["@width"]?has_content> width="${imageNode["@width"]}"</#if><#if imageNode["@height"]?has_content> height="${imageNode["@height"]}"</#if>>
    <#else>
        <#t><@fieldTitle .node?parent/>
    </#if>
    </button>
</#macro>

<#macro "text-area"><textarea class="form-control" name="<@fieldName .node/>" cols="${.node["@cols"]!"60"}" rows="${.node["@rows"]!"3"}"<#if .node["@read-only"]!"false" == "true"> readonly="readonly"</#if><#if .node["@maxlength"]?has_content> maxlength="${.node["@maxlength"]}"</#if> id="<@fieldId .node/>"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>${sri.getFieldValueString(.node?parent?parent, .node["@default-value"]!"", null)?html}</textarea></#macro>

<#macro "text-line">
    <#assign id><@fieldId .node/></#assign>
    <#assign name><@fieldName .node/></#assign>
    <#assign fieldValue = sri.getFieldValueString(.node?parent?parent, .node["@default-value"]!"", .node["@format"]!)>
    <#assign validationClasses = sri.getFormFieldValidationClasses(.node?parent?parent?parent["@name"], .node?parent?parent["@name"])>
    <#assign regexpInfo = sri.getFormFieldValidationRegexpInfo(.node?parent?parent?parent["@name"], .node?parent?parent["@name"])!>
    <#-- NOTE: removed number type (<#elseif validationClasses?contains("number")>number) because on Safari, maybe others, ignores size and behaves funny for decimal values -->
    <input type="<#if validationClasses?contains("email")>email<#elseif validationClasses?contains("url")>url<#else>text</#if>" name="${name}" value="${fieldValue?html}" size="${.node.@size!"70"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if><#if ec.resource.evaluateCondition(.node.@disabled!"false", "")> disabled="disabled"</#if> id="${id}" class="form-control<#if validationClasses?has_content> ${validationClasses}</#if>"<#if validationClasses?has_content> data-vv-validations="${validationClasses}"</#if><#if validationClasses?contains("required")> required</#if><#if regexpInfo?has_content> pattern="${regexpInfo.regexp}"</#if><#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>
    <#if .node["@ac-transition"]?has_content>
        <span id="${id}_value" class="form-autocomplete-value">&nbsp;</span>
        <#assign afterFormScript>
            $("#${id}").autocomplete({
                source: function(request, response) { $.ajax({
                    url: "${sri.screenUrlInfo.url}/${.node["@ac-transition"]}", type: "POST", dataType: "json", data: { term: request.term },
                    success: function(data) { response($.map(data, function(item) { return { label: item.label, value: item.value } })); }
                }); },
                <#t><#if .node["@ac-delay"]?has_content>delay: ${.node["@ac-delay"]},</#if>
                <#t><#if .node["@ac-min-length"]?has_content>minLength: ${.node["@ac-min-length"]},</#if>
                select: function( event, ui ) {
                    if (ui.item) { this.value = ui.item.value; if (ui.item.label) { $("#${id}_value").html(ui.item.label); } }
                }
            });
        </#assign>
        <#t>${sri.appendToScriptWriter(afterFormScript)}
    </#if>
    <#-- OLD approach for validate() with regexp (with validVal just goes in pattern attribute):
    <#assign regexpInfo = sri.getFormFieldValidationRegexpInfo(.node?parent?parent?parent["@name"], .node?parent?parent["@name"])!>
    <#if regexpInfo?has_content>
    <#assign afterFormScript>
    $("#${ec.resource.evaluateStringExpand(formNode["@name"], "")}").validate();
    $.validator.addMethod("${id}_v", function (value, element) { return this.optional(element) || /${regexpInfo.regexp}/.test(value); }, "${regexpInfo.message!"Input invalid"}");
    $("#${id}").rules("add", { ${id}_v:true })
    </#assign>
    <#t>${sri.appendToScriptWriter(afterFormScript)}
    </#if>
    -->
</#macro>

<#macro "text-find">
<span class="form-text-find">
    <#assign defaultOperator = .node["@default-operator"]?default("contains")>
    <#assign curFieldName><@fieldName .node/></#assign>
    <#if .node["@hide-options"]! == "true" || .node["@hide-options"]! == "operator">
        <input type="hidden" name="${curFieldName}_op" value="${defaultOperator}">
    <#else>
        <span><input type="checkbox" class="form-control" name="${curFieldName}_not" value="Y"<#if ec.web.parameters.get(curFieldName + "_not")! == "Y"> checked="checked"</#if>>&nbsp;${ec.l10n.getLocalizedMessage("Not")}</span>
        <select name="${curFieldName}_op">
            <option value="equals"<#if defaultOperator == "equals"> selected="selected"</#if>>${ec.l10n.getLocalizedMessage("Equals")}</option>
            <option value="like"<#if defaultOperator == "like"> selected="selected"</#if>>${ec.l10n.getLocalizedMessage("Like")}</option>
            <option value="contains"<#if defaultOperator == "contains"> selected="selected"</#if>>${ec.l10n.getLocalizedMessage("Contains")}</option>
            <option value="empty"<#rt/><#if defaultOperator == "empty"> selected="selected"</#if>>${ec.l10n.getLocalizedMessage("Empty")}</option>
        </select>
    </#if>

    <input type="text" class="form-control" name="${curFieldName}" value="${sri.getFieldValueString(.node?parent?parent, .node["@default-value"]!"", null)?html}" size="${.node.@size!"30"}"<#if .node.@maxlength?has_content> maxlength="${.node.@maxlength}"</#if> id="<@fieldId .node/>"<#if .node?parent["@tooltip"]?has_content> title="${.node?parent["@tooltip"]}"</#if>>

    <#assign ignoreCase = (ec.web.parameters.get(curFieldName + "_ic")! == "Y") || !(.node["@ignore-case"]?has_content) || (.node["ignore-case"] == "true")>
    <#if .node["@hide-options"]! == "true" || .node["@hide-options"]! == "ignore-case">
        <input type="hidden" name="${curFieldName}_ic" value="Y"<#if ignoreCase> checked="checked"</#if>>
    <#else>
        <span><input type="checkbox" class="form-control" name="${curFieldName}_ic" value="Y"<#if ignoreCase> checked="checked"</#if>>&nbsp;${ec.l10n.getLocalizedMessage("Ignore Case")}</span>
    </#if>
</span>
</#macro>
