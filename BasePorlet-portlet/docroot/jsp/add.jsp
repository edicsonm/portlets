<%
/**
 * Copyright (c) 2000-2012 Liferay, Inc. All rights reserved.
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
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.service.UserServiceUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>

<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="error" message="label.registroInsatisfactorio" />
<liferay-ui:error key="claveDuplicada" message="error.claveDuplicada"  />
<liferay-ui:success key="successAgregar" message="label.registroSatisfactorio" />

<liferay-ui:message key="label.informacion"/>
<aui:script use="aui-io-request,aui-node">
</aui:script>
<%
	
%>
<portlet:actionURL var="saveInformation" name="saveInformation"/>
<aui:form action="<%= saveInformation %>" method="post">
	<div class="tabla"> 
		<div class="fila">
			<div class="columna">
				<aui:input label="label.nombre" showRequiredLabel="false" required="true" name="nombre" value=""/>
			</div>
		</div>
		<div class="fila">
			<div class="columna">
				<aui:input label="label.descripcion" showRequiredLabel="false" required="true" name="descripcion" value=""/>
			</div>
		</div>
		<div class="fila">
			<div class="columna">
				<aui:button type="submit" name="Name" value="label.registrar" />
			</div>
		</div>
	</div>
</aui:form>