
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>

<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>

<portlet:resourceURL var="testURL">
    <portlet:param name="jspPage" value="/jsp/time.jsp" />
</portlet:resourceURL>

<portlet:renderURL var="iFremeDialog">
	<portlet:param name="mvcPath" value="/jsp/iframe_alloyui_dialog.jsp" />
</portlet:renderURL>

<portlet:renderURL var="simpleDialogIframeExample" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="mvcPath" value="/jsp/newCard.jsp" />
</portlet:renderURL>

<aui:script>
	AUI().use(
			'aui-base',
			'aui-io-plugin-deprecated',
			'liferay-util-window',
			'aui-dialog-iframe-deprecated',
			function(A) {A.one('#<portlet:namespace />dialog-iframe-example').on('click',
						function(event) {
							var popUpWindow = Liferay.Util.Window
									.getWindow(
											{
												dialog : {
													centered : true,
													constrain2view : true,
													//cssClass: 'yourCSSclassName',
													modal : true,
													resizable : false,
													width : 500
												}
											})
									.plug(
											A.Plugin.DialogIframe,
											{
												autoLoad : true,
												iframeCssClass : 'dialog-iframe',
												uri : '<%=simpleDialogIframeExample.toString()%>'
											}).render();
							popUpWindow.show();
							popUpWindow.titleNode.html("Liferay 6.2 Iframe Dialog Window");
							popUpWindow.io.start();

						});
					});
</aui:script>


<a href="<portlet:renderURL />">&laquo;Home</a>
<div class="separator"></div>
<div>
	<h1>Iframe AUI Dialog Please click on button and see</h1>
	<br />
	<aui:button name="dialog-iframe-example" id="dialog-iframe-example" value="Click Here to add a record ... "></aui:button>
</div>

<div class="separator"></div>
<%-- <div id="anchorListDiv">
	<aui:layout>
		<aui:column>
			<aui:a href="<%=iFremeDialog%>">Alloy UI IFrame Dialog.</aui:a>
		</aui:column>
	</aui:layout>
</div> --%>

<div id="time"></div>

<%-- <button type="button" name="test-button" id="test-button" class="btn btn-primary"><liferay-ui:message key="label.addCard"/></button> --%>

<script>

<%-- $( "#time" ).load("<%= testURL %>"); --%>

<%-- $("#test-button").click(function() {
    $.ajax({
   	  method: "POST",
   	  url: "<%= testURL %>",
   	  data: { name: "John", location: "Boston" }
   	})
	  .done(function( msg ) {
		$("#time").html(msg);
	  });
}) --%>
</script>
<aui:script use="aui-base"> 
	window.recharge = function() {
		$( "#time" ).load("<%= testURL %>");
	};
</aui:script>
