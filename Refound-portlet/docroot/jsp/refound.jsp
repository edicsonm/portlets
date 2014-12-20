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
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.service.UserServiceUtil" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.PortletURL"%>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="success" message="label.success" />
<liferay-ui:error key="error" message="label.unsatisfactoryRegistration" />
<liferay-ui:error key="claveDuplicada" message="error.claveDuplicada"  />

<liferay-ui:message key="label.title.refound"/>
<aui:script use="aui-io-request,aui-node">
</aui:script>
<%
String id = ParamUtil.getString(request, "id");
out.print(id);
%>

<aui:form name="operacion" method="post">
	<div class="tabla">
		<div class="fila">
			<div class="columnaIzquierda">
				<label class="aui-field-label"><fmt:message key="label.transactionNumber"/></label>
			</div>
			<div class="columnaDerecha">
				out.print(id);
				<c:out value="${id}"/>
			</div>
		</div>
	</div>
</aui:form>