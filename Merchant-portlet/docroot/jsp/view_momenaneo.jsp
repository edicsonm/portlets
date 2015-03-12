<%--
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.portlet.PortletPreferences" %>

<portlet:defineObjects />

<%
 	String tabs1 = ParamUtil.getString(request, "tabs1","Business");
	System.out.println("tabs1: " + tabs1);

	PortletPreferences prefs = renderRequest.getPreferences();
	String greeting = (String)prefs.getValue("greeting", "Contact");
	System.out.println("greeting en la jsp: " + greeting);
	
    PortletURL portletURL = renderResponse.createRenderURL();
    portletURL.setParameter("tabs", tabs1);
%>

<%-- <portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL> --%>

<portlet:actionURL var="keepInformation" name="keepInformation">
	<portlet:param name="action" value="saveBusinessInformation" />
	<portlet:param name="greeting" value="<%=greeting%>"/>    
</portlet:actionURL>

<aui:form  action="<%= keepInformation %>" method="post">
    <liferay-ui:tabs names="Business,Contact" param="tabs" url="<%= portletURL.toString()%>"/>            
        <c:choose>
        <c:when test='<%=tabs1.equals("Business")%>'>
            <%@include file="/jsp/tabsNewMerchant/informationBusiness.jsp"%>
        </c:when>
        <c:when test='<%=tabs1.equals("Contact")%>'>
            <%@include file="/jsp/tabsNewMerchant/informationContact.jsp" %>
        </c:when>
    </c:choose>
</aui:form>

