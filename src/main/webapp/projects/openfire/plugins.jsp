<%@ page import="org.jivesoftware.site.PluginDownloadServlet"%>
<%@ page import="org.jivesoftware.site.PluginManager"%>
<%@ page import="java.io.File"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<html>
<head>
<title>Openfire Plugins</title>
<meta name="body-id" content="projects" />
<style type="text/css" media="screen">
    @import "../../styles/interior.css";
</style>
<%
    String openfirePluginsPath = config.getServletContext().getInitParameter("openfire-plugins-path");
    Path pluginDir = Paths.get( openfirePluginsPath );
%>

</head>
<body>

    <div id="ignite_subnav">
        <ul>
            <li id="subnav01"><a href="index.jsp" class="ignite_subnav_project">Openfire</a></li>
            <li id="subnav03"><a href="plugins.jsp" class="ignite_subnav_current">Plugins</a></li>
            <li id="subnav04"><a href="documentation.jsp">Documentation</a></li>
            <li id="subnav05"><a href="http://issues.igniterealtime.org/browse/JM">Issue Tracker</a></li>
            <li id="subnav06"><a href="http://download.igniterealtime.org/openfire/docs/latest/documentation/javadoc/">JavaDocs</a></li>
            <li id="subnav07"><a href="connection_manager.jsp">Connection Manager Module</a></li>
            <!--<li id="subnav08"><a href="../../roadmap.jsp">http://issues.igniterealtime.org/browse/OF#selectedTab=com.atlassian.jira.plugin.system.project%3Aroadmap-panel</a></li>-->
        </ul>
    </div>

    <!-- BEGIN body area -->
    <div id="ignite_body">
        
        <!-- BEGIN left column (main content) -->
        <div id="ignite_body_leftcol">
            
            <!-- BEGIN body content area -->
            <div id="ignite_int_body">
            
                <!-- BEGIN body header -->
                <div id="ignite_body_header">
                    <h2>Openfire Plugins</h2>
                </div>
                <!-- END body header -->
                
                
                <div class="ignite_int_body_padding">
                    <p>Plugins extend and enhance the functionality of Openfire (formerly Wildfire). Below is a list of
                    plugins available for <a href="index.jsp">Openfire</a>. To install plugins,
                    copy the .jar file into the <tt>plugins</tt> directory of your Openfire installation.
                    </p>

                <!-- BEGIN plugins -->
                <div id="plugins">
                <a name="opensource"></a>
                
                    <table cellpadding="3" cellspacing="0" border="0" width="100%">
                        <tr class="pluginTableHeader">
                            <td class="pluginType">Open Source Plugins</td>
                            <td style="text-align: center;">Info</td>
                            <td>File</td>
                            <td style="text-align: center;">Version</td>
                            <td style="text-align: center;">Released</td>
                            <td style="text-align: center;">Min Openfire Version</td>
                            <td style="text-align: center;">Other Versions</td>
                        </tr>
            <%
                final List<PluginManager.Metadata> plugins =
                    PluginManager.sortByNameVersionAndReleaseDate(
                        PluginManager.getLatestRelease( pluginDir )
                    );

                if (plugins == null || plugins.isEmpty()) { %>
                    <tbody>
                        <tr>
                            <td colspan="6">No plugins.</td>
                        </tr>
                    </tbody>
            <%  } %>
                    <tbody>
            <%
            final DateFormat formatter = DateFormat.getDateInstance(DateFormat.MEDIUM);
            for ( PluginManager.Metadata plugin : plugins )
            {
                final String pluginName = plugin.pluginFileName.substring( 0, plugin.pluginFileName.length() - 4 );
                try {
                    %>
                        <tr valign="middle">
                            <td class="c1">
                                <table cellpadding="1" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td width="1%">
                                            <span class="plugicon">
                                            <% if (plugin.hasIcon) { %>
                                                <img style="height: 16px; width: 16px;" src="plugins/<%= URLEncoder.encode(pluginName, "utf-8") %>/<%= URLEncoder.encode(plugin.iconFileName, "utf-8") %>" alt="Plugin" />
                                            <% } else { %>
                                                <img style="height: 16px; width: 16px;" src="../../images/icon_plugin.gif" alt="Plugin">
                                            <% } %>
                                            </span>
                                        </td>
                                        <td width="99%">
                                            <span class="plugname">
                                            <b><%= plugin.humanReadableName %></b>
                                            </span>
                                        </td>
                                    </tr>
                                    <%  if (plugin.humanReadableDescription != null) { %>
                                    <tr>
                                        <td colspan="2">
                                            <span class="description">
                                            <%= plugin.humanReadableDescription %>
                                            </span>
                                        </td>
                                    </tr>
                                    <%  } %>
                                </table>
                            </td>
                            <td class="c2" nowrap>
                                <% if( plugin.hasReadme) { %>
                                <a href="plugins/<%= URLEncoder.encode(plugin.pluginVersion, "utf-8") %>/<%= URLEncoder.encode(pluginName, "utf-8") %>/readme.html"><img src="../../images/doc-readme-16x16.gif" width="16" height="16" border="0" alt="README"></a>
                                <% } else { %>
                                &nbsp;
                                <% } if(plugin.hasChangelog) { %>
                                <a href="plugins/<%= URLEncoder.encode(plugin.pluginVersion, "utf-8") %>/<%= URLEncoder.encode(pluginName, "utf-8") %>/changelog.html"><img src="../../images/doc-changelog-16x16.gif" width="16" height="16" border="0" alt="Changelog"></a>
                                <% } %>
                            </td>
                            <td class="c3" nowrap>
                                <a href="plugins/<%= URLEncoder.encode(plugin.pluginVersion, "utf-8") %>/<%= URLEncoder.encode(plugin.pluginFileName, "utf-8") %>"><%= URLEncoder.encode(plugin.pluginFileName, "utf-8") %></a>
                            </td>
                            <td class="c4" align="center" nowrap>
                                <%= (plugin.pluginVersion != null ? plugin.pluginVersion : "&nbsp;") %>
                            </td>
                            <td class="c4" align="center" nowrap>
                                <%= (plugin.releaseDate != null ? formatter.format(plugin.releaseDate) : "&nbsp;") %>
                            </td>
                            <td class="c4" align="center" nowrap>
                                <%= (plugin.minimumRequiredOpenfireVersion != null ? plugin.minimumRequiredOpenfireVersion : "&nbsp;") %>
                            </td>
                            <td class="c5" nowrap>
                                <a href="plugin-archive.jsp?plugin=<%= URLEncoder.encode(pluginName, "utf-8") %>">Archive...</a>
                            </td>
                        </tr>
            <%  }
                catch ( Exception e )
                {
                    // Ignore one plugin, iterate to the next plugin.
                    e.printStackTrace();
                }
            }
            %>
                    </tbody>
                    </table>
                </div>
                <!-- END plugins -->
                
                </div>

            </div>
            <!-- END body content area -->
            
        </div>
        <!-- END left column (main content) -->
        
        <!-- BEGIN right column (sidebar) -->
        <div id="ignite_body_rightcol">
            
            <jsp:include page="/includes/sidebar_projectlead.jsp">
                <jsp:param name="project" value="openfire" />
            </jsp:include>
            
            <jsp:include page="/includes/sidebar_snapshot.jsp">
                <jsp:param name="project" value="openfire"/>
            </jsp:include>
            
            <%@ include file="/includes/sidebar_enterprise.jspf" %>
            
        </div>
        <!-- END right column (sidebar) -->
    
    </div>
    <!-- END body area -->



</body>
</html>
