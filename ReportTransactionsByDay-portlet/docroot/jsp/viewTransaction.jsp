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
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.paymentDetails"/></label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="column1-2">
					<label class="aui-field-label"><fmt:message key="label.amount"/></label>
				</div>
				<div class="column2-3">
					<c:out value="${transactionVO.chargeVO.amount}"/>
				</div>
			</div>
			<div class="row">
				<div class="column1-2">
					<label class="aui-field-label"><fmt:message key="label.currency"/></label>
				</div>
				<div class="column2-2">
					<c:out value="${fn:toUpperCase(transactionVO.chargeVO.currency)}"/>
				</div>
			</div>
			<div class="row">
				<div class="column1-2">
					<label class="aui-field-label"><fmt:message key="label.creationTime"/></label>
				</div>
				<div class="column2-2">
					<c:out value="${transactionVO.chargeVO.creationTime}"/>
				</div>
			</div>
		</div>
		
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.cardDetails"/></label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.name"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${transactionVO.cardVO.name}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.number"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${transactionVO.cardVO.last4}"/>
				</div>
			</div>
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.brand"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${transactionVO.cardVO.brand}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.type"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${Utils:capitalize(transactionVO.cardVO.funding)}"/>
				</div>
			</div>
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.expMonth"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${transactionVO.cardVO.expMonth}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.expYear"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${transactionVO.cardVO.expYear}"/>
				</div>
			</div>
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.countryCard"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${transactionVO.cardVO.country}"/>
				</div>
				<div class="column3-4">
				</div>
				<div class="column4-4">
				</div>
			</div>
		</div>
		
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.transactionDetails"/></label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.ipCity"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${transactionVO.ipCity}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.ipRegionName"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${transactionVO.ipRegionName}"/>
				</div>
			</div>
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.countryCode"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${transactionVO.countryCode}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.countryName"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${transactionVO.ipCountryName}"/>
				</div>
			</div>
			
			
		</div>
		<div class="row">
				<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
				<div class="column2-2">
				</div>
			</div>
	</div>
</aui:form>