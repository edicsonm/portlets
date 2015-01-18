<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ page import="javax.portlet.PortletPreferences"%>
<portlet:defineObjects />
<%
	PortletPreferences prefs = renderRequest.getPreferences();
	String greeting = (String)prefs.getValue("greeting", "Hello! Welcome to our portal. ja ja jaj");
%>
<p><%= greeting %></p>
<portlet:renderURL var="editarGreetingURL">
	<portlet:param name="jspPage" value="/jsp2/edit_tatata.jsp" />
</portlet:renderURL>
<p>
	<a href="<%= editarGreetingURL %>">Edit greeting</a>
</p>
