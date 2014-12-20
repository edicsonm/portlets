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
<liferay-ui:error key="errorActualizacion" message="label.actualizacionInsatisfactoria" />
<liferay-ui:message key="label.actualizacion"/>
<aui:script use="aui-io-request,aui-node">
</aui:script>
<%
/* 	RazaVO razaVO = (RazaVO)session.getAttribute("razaVO");*/
%>
<portlet:actionURL var="actualizarInformacion" name="actualizarInformacion"/>
<aui:form action="<%= actualizarInformacion %>" method="post">
	<div class="tabla"> 
		<div class="fila">
			<div class="columna">
				<aui:input label="label.nombreRaza" showRequiredLabel="false" required="true" name="nombreRaza" value="${razaVO.nombre}"/>
			</div>
		</div>
		<div class="fila">
			<div class="columna">
				<aui:input label="label.descripcionRaza" showRequiredLabel="false" required="true" name="descripcionRaza" value="${razaVO.descripcion}"/>
			</div>
		</div>
		<div class="fila">
			<div class="columna">
				<aui:button type="submit" name="Name" value="label.actualizar" />
			</div>
		</div>
	</div>
</aui:form>