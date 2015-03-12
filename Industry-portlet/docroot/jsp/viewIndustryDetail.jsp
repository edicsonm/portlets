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
	ArrayList<IndustryVO> resultsListCharge = (ArrayList<IndustryVO>)session.getAttribute("results");
	IndustryVO industryVO = (IndustryVO)resultsListCharge.get(Integer.parseInt(ParamUtil.getString(request, "indiceIndustry")));
	request.setAttribute("industryVO", industryVO);
%>
<portlet:renderURL var="goBackIndustry">
	<portlet:param name="mvc" value="/jsp/viewIndustry.jsp" />
</portlet:renderURL>

<aui:form method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationIndustry"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="details">
				<dl class="property-list">
					<dt><fmt:message key="label.description"/></dt>
					<dd><c:out value="${industryVO.description}"/></dd>
					<!-- <dt>Fecha de nacimiento</dt>
					<dd>1/01/70</dd>
					<dt>Género</dt>
					<dd>Hombre</dd> -->
				</dl>
			</div>
			<a href="<%= goBackIndustry %>"><fmt:message key="label.goBack"/></a>
		</div>
	</fieldset>
</aui:form>