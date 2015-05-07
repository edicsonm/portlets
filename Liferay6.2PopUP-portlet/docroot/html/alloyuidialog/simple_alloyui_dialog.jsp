<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<portlet:renderURL var="simpleDialogExample" 
windowState="<%=LiferayWindowState.EXCLUSIVE.toString()%>">
<portlet:param name="mvcPath" 
value="/html/alloyuidialog/simple_alloyui_dialog-content.jsp"/>
<portlet:param name="message" value="Hello welcome"/>
</portlet:renderURL>
<a href="<portlet:renderURL />">&laquo;Home</a>
<div class="separator"></div>
<div>
<h1>Simple AUI Dialog Please click on button  and see </h1><br/>
<aui:button name="simple-dialog-example"  id="simple-dialog-example" 
 value="Click Here See Simple Allou UI Dialog"> </aui:button>
</div>
<aui:script>
AUI().use('aui-base',
	'aui-io-plugin-deprecated',
	'liferay-util-window', 
	function(A) {
A.one('#<portlet:namespace />simple-dialog-example').on('click', function(event){ 
	var popUpWindow=Liferay.Util.Window.getWindow(
						{
							dialog: {
								centered: true,
								constrain2view: true,
								//cssClass: 'yourCSSclassName',
								modal: true,
								resizable: false,
								width: 475
							}
						}
					).plug(
						A.Plugin.IO,
						{
							autoLoad: false
						}).render();
	popUpWindow.show();
	popUpWindow.titleNode.html("Liferay 6.2 Dialog Window");
	popUpWindow.io.set('uri','<%=simpleDialogExample%>');
	popUpWindow.io.start();

});
});
</aui:script>
