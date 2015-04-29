<%
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
%>
<%@ include file="init.jsp" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.liferay.portal.theme.ThemeDisplay" %>
<%@ page import="com.liferay.portlet.PortletURLUtil" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="ProcessorMDTR.saveSubscription.SubscriptionDAOException" message="error.ProcessorMDTR.saveSubscription.SubscriptionDAOException" />

<portlet:renderURL var="sendEmailURL" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
    <portlet:param name="jspPage" value="/jsp/prueba.jsp"/>
    <portlet:param name="struts_action" value="/ir" />
	<portlet:param name="redirect" value="<%= PortletURLUtil.getCurrent(renderRequest, renderResponse).toString() %>" />
  </portlet:renderURL>
  
<portlet:actionURL name="saveSubscription" var="saveSubscription">
</portlet:actionURL>

<portlet:actionURL var="uploadURL">
	<portlet:param name="struts_action" value="/ir" />
</portlet:actionURL>

<aui:form action="<%=saveSubscription.toString()%>" method="post">
    <aui:input type="text" id="parametro" name="parametro" value="la la la"/>
    <aui:button-row>
   		<button type="submit" class="btn btn-primary" /><liferay-ui:message key="label.upload"/></button>
    </aui:button-row>
</aui:form>