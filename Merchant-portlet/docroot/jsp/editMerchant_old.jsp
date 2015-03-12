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
<liferay-ui:error key="ProcessorMDTR.updateMerchant.MerchantDAOException" message="error.ProcessorMDTR.updateMerchant.MerchantDAOException" />
<% 
	MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
	request.setAttribute("merchantVO", merchantVO);
	ArrayList<CountryVO> listCountries = (ArrayList<CountryVO>)session.getAttribute("listCountries");
%>

<portlet:actionURL name="editMerchant" var="submitForm">
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
						<label class="aui-field-label sub-title"><fmt:message key="label.informationBusiness"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.name" helpMessage="help.name" showRequiredLabel="false" type="text" required="true" name="name" value="${merchantVO.name}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.tradingName" helpMessage="help.tradingName" showRequiredLabel="false" type="text" required="true" name="tradingName" value="${merchantVO.tradingName}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="legalPhysicalAddress"  label="label.legalPhysicalAddress" helpMessage="help.legalPhysicalAddress" showRequiredLabel="false" type="text" required="true" value="${merchantVO.legalPhysicalAddress}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="statementAddress"  label="label.statementAddress" helpMessage="help.statementAddress" value="${merchantVO.statementAddress}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="taxFileNumber"  label="label.taxFileNumber" helpMessage="help.taxFileNumber" value="${merchantVO.taxFileNumber}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="cityBusinessInformation"  label="label.cityBusinessInformation" helpMessage="help.cityBusinessInformation" value="${merchantVO.cityBusinessInformation}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="postCodeBusinessInformation"  label="label.postCodeBusinessInformation" helpMessage="help.postCodeBusinessInformation" value="${merchantVO.postCodeBusinessInformation}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="countryBusinessInformation" helpMessage="help.countryBusinessInformation"  label="label.countryBusinessInformation" id="countryBusinessInformation">
						<c:forEach var="countryVO" items="${listCountries}">
							<aui:option value="${countryVO.numeric}" label="${countryVO.name}" selected="${countryVO.numeric==merchantVO.countryNumericMerchant}"/>
						</c:forEach>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="businessType" helpMessage="help.businessType"  label="label.businessType" id="businessType">
						<c:forEach var="businessTypeVO" items="${listBusinessTypes}">
							<%-- <aui:option value="${businessTypeVO.id}" label="${businessTypeVO.description}"/> --%>
							<aui:option value="${businessTypeVO.id}" label="${businessTypeVO.description}" selected="${businessTypeVO.id==merchantVO.businessTypeId}"/>
						</c:forEach>
					</aui:select>
					
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="industry" helpMessage="help.industry"  label="label.industry" id="industry">
						<c:forEach var="industryVO" items="${listIndustries}">
							<%-- <aui:option value="${industryVO.id}" label="${industryVO.description}"/> --%>
							<aui:option value="${industryVO.id}" label="${industryVO.description}" selected="${industryVO.id==merchantVO.industryId}"/>
						</c:forEach>
					</aui:select>
					
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="issuedBusinessID"  label="label.issuedBusinessID" helpMessage="help.issuedBusinessID" value="${merchantVO.issuedBusinessID}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="issuedPersonalID"  label="label.issuedPersonalID" helpMessage="help.issuedPersonalID" value="${merchantVO.issuedPersonalID}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="typeAccountApplication"  label="label.typeAccountApplication" helpMessage="help.typeAccountApplication" value="${merchantVO.typeAccountApplication}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="estimatedAnnualSales"  label="label.estimatedAnnualSales" helpMessage="help.estimatedAnnualSales" value="${merchantVO.estimatedAnnualSales}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
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
				<div class="column1-1">
					<aui:input name="firstName"  label="label.firstName" helpMessage="help.firstName" value="${merchantVO.firstName}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="lastName"  label="label.lastName" helpMessage="help.lastName" value="${merchantVO.lastName}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="phoneNumber"  label="label.phoneNumber" helpMessage="help.phoneNumber" value="${merchantVO.phoneNumber}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="faxNumber"  label="label.faxNumber" helpMessage="help.faxNumber" value="${merchantVO.faxNumber}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="emailAddress"  label="label.emailAddress" helpMessage="help.emailAddress" value="${merchantVO.emailAddress}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="alternateEmailAddress"  label="label.alternateEmailAddress" helpMessage="help.alternateEmailAddress" value="${merchantVO.alternateEmailAddress}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="cityPersonalInformation"  label="label.cityPersonalInformation" helpMessage="help.cityPersonalInformation" value="${merchantVO.cityPersonalInformation}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="postCodePersonalInformation"  label="label.postCodePersonalInformation" helpMessage="help.postCodePersonalInformation" value="${merchantVO.postCodePersonalInformation}" showRequiredLabel="false" type="text" required="true">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="countryPersonalInformation" helpMessage="help.countryPersonalInformation"  label="label.countryPersonalInformation" id="countryPersonalInformation">
						<c:forEach var="countryVO" items="${listCountries}">
							<aui:option value="${countryVO.numeric}" label="${countryVO.name}" selected="${countryVO.numeric==merchantVO.countryNumericPersonalInformation}"/>
						</c:forEach>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
				<div class="column2-2">
					<aui:button type="submit" name="save" value="label.save" />
				</div>
			</div>
		</div>
	</div>
</aui:form>