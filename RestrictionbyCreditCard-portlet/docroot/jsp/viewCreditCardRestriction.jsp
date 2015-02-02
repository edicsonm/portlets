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
<liferay-ui:error key="ProcessorMDTR.saveCreditCardRestriction.CreditCardRestrictionDAOException" message="error.ProcessorMDTR.saveCreditCardRestriction.CreditCardRestrictionDAOException" />
<% 
	ArrayList<CreditCardRestrictionVO> resultsListMerchants = (ArrayList<CreditCardRestrictionVO>)session.getAttribute("results");
	CreditCardRestrictionVO creditCardRestrictionVO = (CreditCardRestrictionVO)resultsListMerchants.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
%>

<portlet:actionURL name="editCreditCardRestriction" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitForm %>" method="post">
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.informationCreditCardRestriction"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.concept"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${creditCardRestrictionVO.concept}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.value"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${creditCardRestrictionVO.value}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.timeUnit"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${creditCardRestrictionVO.timeUnit}"/>
				</div>
				<div class="column3-4">
				</div>
				<div class="column4-4">
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
					<span class="goBack" >
						<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
					</span>
				</div>
			</div>
		</div>
	</div>
</aui:form>