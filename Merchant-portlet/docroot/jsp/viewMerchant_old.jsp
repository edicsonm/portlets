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
	ArrayList<MerchantVO> resultsListMerchants = (ArrayList<MerchantVO>)session.getAttribute("results");
	MerchantVO merchantVO = (MerchantVO)resultsListMerchants.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("merchantVO", merchantVO);
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
						<label class="aui-field-label sub-title"><fmt:message key="label.informationBusiness"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.name"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.name}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.tradingName"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.tradingName}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.legalPhysicalAddress"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.legalPhysicalAddress}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.statementAddress"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.statementAddress}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.taxFileNumber"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.legalPhysicalAddress}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"></label>
				</div>
				<div class="column4-4">
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.cityBusinessInformation"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.cityBusinessInformation}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.postCodeBusinessInformation"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.postCodeBusinessInformation}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.countryBusinessInformation"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.countryVOBusiness.name}"/>
				</div>
				<div class="column3-4">
				</div>
				<div class="column4-4">
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.businessType"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.businessTypeVO.description}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.industry"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.industryVO.description}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.issuedBusinessID"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.issuedBusinessID}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.issuedPersonalID"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.issuedPersonalID}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.typeAccountApplication"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.typeAccountApplication}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.estimatedAnnualSales"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.estimatedAnnualSales}"/>
				</div>
			</div>
			
			
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.informationPersonal"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.firstName"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.firstName}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.lastName"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.lastName}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.phoneNumber"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.phoneNumber}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.faxNumber"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.faxNumber}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.emailAddress"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.emailAddress}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.alternateEmailAddress"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.alternateEmailAddress}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.cityPersonalInformation"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.cityPersonalInformation}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.postCodePersonalInformation"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantVO.postCodePersonalInformation}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.countryPersonalInformation"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantVO.countryVOPersonalInformation.name}"/>
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