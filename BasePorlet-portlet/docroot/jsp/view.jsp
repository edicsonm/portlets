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

<portlet:defineObjects />
<liferay-ui:success key="successAgregar" message="label.registroSatisfactorio" />


<portlet:actionURL var="addInformation" name="addInformation">
    <portlet:param name="accion" value="addInformation" />
</portlet:actionURL>

<portlet:renderURL var="searchInformation">
	<portlet:param name="accion" value="searchInformation" />
</portlet:renderURL>

<aui:script use="aui">
	
	searchFuncion = function(){
		document.<portlet:namespace />operacion.action="<%=searchInformation%>";
	}
	
	addFuncion = function(){
		document.<portlet:namespace />operacion.action="<%=addInformation%>";
	}
	
</aui:script>


<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form name="operacion" method="post">
	<div class="tabla">
			<div class="fila">
				<div class="columnaIzquierda">
					<aui:input name="busqueda" label="" inlineLabel="false" value="entre raza" type="text"/>
				</div>
				<div class="columnaIzquierdaMargen">
					<aui:button type="submit" value="search" onClick="javascript:searchFuncion()"/>
			</div>
			<div class="columnaIzquierdaMargen">
				<aui:button type="submit" value="add" onClick="javascript:addFuncion()"/>
			</div>
		</div>
	</div>
</aui:form>
This is the <b>BasePorlet</b> portlet.