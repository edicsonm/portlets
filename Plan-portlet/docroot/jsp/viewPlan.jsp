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
	ArrayList<PlanVO> resultsListCharge = (ArrayList<PlanVO>)session.getAttribute("results");
	PlanVO planVO = (PlanVO)resultsListCharge.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("planVO", planVO);
%>
<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form method="post">
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationPlan"/> </span>
	</legend>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
			<div id="contenedor">
				
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.merchantName"/></dt>
							<dd><c:out value="${planVO.merchantVO.name}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.name"/></dt>
							<dd><c:out value="${planVO.name}"/></dd>
						</dl>
					</div>
				</div>
				
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.currency"/></dt>
							<dd><c:out value="${planVO.currency}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.amount"/></dt>
							<dd><c:out value="${planVO.amount}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.interval"/></dt>
							<dd><c:out value="${planVO.interval}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.intervalCount"/></dt>
							<dd><c:out value="${planVO.intervalCount}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.statementDescriptor"/></dt>
							<dd><c:out value="${planVO.statementDescriptor}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.trialPeriodDays"/></dt>
							<dd><c:out value="${planVO.trialPeriodDays}"/></dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
		<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
	</div>
</fieldset>
</aui:form>