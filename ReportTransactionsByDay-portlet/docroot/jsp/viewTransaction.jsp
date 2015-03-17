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
<%@taglib uri="http://www.billingbuddy.com/.com/bbtlds" prefix="Utils" %>
<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<%
	ArrayList<TransactionVO> resultsListTransactionsByDay = (ArrayList<TransactionVO>)session.getAttribute("results");
	TransactionVO transactionVO = (TransactionVO)resultsListTransactionsByDay.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("transactionVO", transactionVO);
%>
<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form method="post">

	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.paymentDetails"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			
			<div class="details">
				<p id="sub-legend" class="description"><fmt:message key="label.paymentDetails"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-3">
							<dl class="property-list">
								<dt><fmt:message key="label.amount"/></dt>
								<dd><c:out value="${Utils:stripeToCurrency(transactionVO.chargeVO.amount, transactionVO.chargeVO.currency)}"/></dd>
							</dl>
						</div>
						<div id="columna2-3">
							<dl class="property-list">
								<dt><fmt:message key="label.currency"/></dt>
								<dd><c:out value="${Utils:toUpperCase(transactionVO.chargeVO.currency)}"/></dd>
							</dl>
						</div>
						<div id="columna3-3">
							<dl class="property-list">
								<dt><fmt:message key="label.creationTime"/></dt>
								<dd><c:out value="${Utils:formatDate(3,transactionVO.creationTime,3)}"/></dd>
							</dl>
						</div>
					</div>
				</div>
				<p id="sub-legend" class="description"><fmt:message key="label.cardDetails"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-3">
							<dl class="property-list">
								<dt><fmt:message key="label.name"/></dt>
								<dd><c:out value="${transactionVO.cardVO.name}"/></dd>
							</dl>
						</div>
						<div id="columna2-3">
							<dl class="property-list">
								<dt><fmt:message key="label.number"/></dt>
								<dd><c:out value="${Utils:printCardNumber(transactionVO.cardVO.number)}"/></dd>
							</dl>
						</div>
						<div id="columna3-3">
							<dl class="property-list">
								<dt><fmt:message key="label.brand"/></dt>
								<dd><c:out value="${transactionVO.cardVO.brand}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-3">
							<dl class="property-list">
								<dt><fmt:message key="label.type"/></dt>
								<dd><c:out value="${Utils:capitalize(transactionVO.cardVO.funding)}"/></dd>
							</dl>
						</div>
						<div id="columna2-3">
							<dl class="property-list">
								<dt><fmt:message key="label.expMonth"/></dt>
								<dd><c:out value="${transactionVO.cardVO.expMonth}"/></dd>
							</dl>
						</div>
						<div id="columna3-3">
							<dl class="property-list">
								<dt><fmt:message key="label.expYear"/></dt>
								<dd><c:out value="${transactionVO.cardVO.expYear}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-3">
							<dl class="property-list">
								<dt><fmt:message key="label.countryCard"/></dt>
								<dd><c:out value="${transactionVO.cardVO.country}"/></dd>
							</dl>
						</div>
					</div>
				</div>
				<p id="sub-legend" class="description"><fmt:message key="label.transactionDetails"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-4">
							<dl class="property-list">
								<dt><fmt:message key="label.ipCity"/></dt>
								<dd><c:out value="${transactionVO.ipCity}"/></dd>
							</dl>
						</div>
						<div id="columna2-4">
							<dl class="property-list">
								<dt><fmt:message key="label.ipRegionName"/></dt>
								<dd><c:out value="${transactionVO.ipRegionName}"/></dd>
							</dl>
						</div>
						<div id="columna3-4">
							<dl class="property-list">
								<dt><fmt:message key="label.countryCode"/></dt>
								<dd><c:out value="${transactionVO.countryCode}"/></dd>
							</dl>
						</div>
						<div id="columna4-4">
							<dl class="property-list">
								<dt><fmt:message key="label.countryName"/></dt>
								<dd><c:out value="${transactionVO.ipCountryName}"/></dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
			<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
		</div>
	</fieldset>
</aui:form>