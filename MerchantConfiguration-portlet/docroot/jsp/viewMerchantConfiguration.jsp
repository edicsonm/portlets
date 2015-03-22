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
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<% 
	ArrayList<MerchantConfigurationVO> resultsListMerchantConfigurations = (ArrayList<MerchantConfigurationVO>)session.getAttribute("results");
	MerchantConfigurationVO merchantConfigurationVO = (MerchantConfigurationVO)resultsListMerchantConfigurations.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
%>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form method="post">
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationMerchantConfiguration"/> </span>
	</legend>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
			<div id="contenedor">
				<div id="contenidos">
					<div id="columna1-1">
						<dl class="property-list">
							<dt><fmt:message key="label.merchant"/></dt>
							<dd><c:out value="${merchantConfigurationVO.merchantVO.name}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-1">
						<dl class="property-list">
							<dt><fmt:message key="label.urlApproved"/></dt>
							<dd><c:out value="${merchantConfigurationVO.urlApproved}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-1">
						<dl class="property-list">
							<dt><fmt:message key="label.urlDeny"/></dt>
							<dd><c:out value="${merchantConfigurationVO.urlDeny}"/></dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
		<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
	</div>
</fieldset>
</aui:form>