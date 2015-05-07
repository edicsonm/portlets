<%@ include file="init.jsp"%>
<style>
#anchorListDiv a {
	color: blue;
	font-weight: bold;
	font-size: 16pt;
}
</style>

<portlet:renderURL var="simpleDialog">
	<portlet:param name="mvcPath" value="/html/alloyuidialog/simple_alloyui_dialog.jsp" />
</portlet:renderURL>

<portlet:renderURL var="iFremeDialog">
	<portlet:param name="mvcPath" value="/html/alloyuidialog/iframe_alloyui_dialog.jsp" />
</portlet:renderURL>

<portlet:renderURL var="portletInDialog">
	<portlet:param name="mvcPath" value="/html/alloyuidialog/open_portlet_in_iframe_alloyui_dialog.jsp" />
</portlet:renderURL>

<div id="anchorListDiv">
	<aui:layout>
		<aui:column>
			<aui:a href="<%=simpleDialog%>">Simple Alloy UI Dialog.</aui:a>
		</aui:column>
	</aui:layout>
	<aui:layout>
		<aui:column>
			<aui:a href="<%=iFremeDialog%>">Alloy UI IFrame Dialog.</aui:a>
		</aui:column>
	</aui:layout>
	<aui:layout>
		<aui:column>
			<aui:a href="<%=portletInDialog%>">Open Portlet In Dialog</aui:a>
		</aui:column>
	</aui:layout>
</div>
