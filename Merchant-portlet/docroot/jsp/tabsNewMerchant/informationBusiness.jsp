<%--
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
--%>
<%-- <%@ include file="../init.jsp" %> --%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="au.com.billingbuddy.vo.objects.MerchantVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.CountryVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.BusinessTypeVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.IndustryVO" %>

<%-- <%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %> --%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<portlet:defineObjects />
<fmt:setBundle basename="Language"/>
<% 
	MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
	ArrayList<CountryVO> listCountries = (ArrayList<CountryVO>)session.getAttribute("listCountries");
	
	ArrayList<BusinessTypeVO> listBusinessTypes = (ArrayList<BusinessTypeVO>)session.getAttribute("listBusinessTypes");
	ArrayList<IndustryVO> listIndustries = (ArrayList<IndustryVO>)session.getAttribute("listIndustries");
	
%>
<portlet:actionURL name="saveMerchant" var="submitFormMerchant">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<portlet:renderURL var="nextTab">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
	<portlet:param name="action" value="saveBusinessInformation" />
</portlet:renderURL>


<%-- <aui:form  action="<%= submitFormMerchant %>" method="post"> --%>

<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationBusiness"/> </span>
	</legend>
	<div class="">
		<div class="control-group">
			<aui:input label="label.name" helpMessage="help.name" name="name" value="${merchantVO.name}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.tradingName" helpMessage="help.tradingName" name="tradingName" value="${merchantVO.tradingName}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.legalPhysicalAddress" helpMessage="help.legalPhysicalAddress" name="legalPhysicalAddress" value="${merchantVO.legalPhysicalAddress}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.taxFileNumber" helpMessage="help.taxFileNumber" name="taxFileNumber" value="${merchantVO.taxFileNumber}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		
		<div class="control-group">
			<aui:input label="label.cityBusinessInformation" helpMessage="help.cityBusinessInformation" name="cityBusinessInformation" value="${merchantVO.cityBusinessInformation}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.postCodeBusinessInformation" helpMessage="help.postCodeBusinessInformation" name="postCodeBusinessInformation" value="${merchantVO.postCodeBusinessInformation}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:select name="countryBusinessInformation" helpMessage="help.countryBusinessInformation"  label="label.countryBusinessInformation" id="countryBusinessInformation">
				<c:forEach var="countryVO" items="${listCountries}">
					<aui:option value="${countryVO.numeric}" label="${countryVO.name}" selected="${countryVO.numeric==merchantVO.countryNumericMerchant}"/>
				</c:forEach>
			</aui:select>
		</div>
		
		<div class="control-group">
			<aui:select name="businessType" helpMessage="help.businessType"  label="label.businessType" id="businessType">
				<c:forEach var="businessTypeVO" items="${listBusinessTypes}">
					<aui:option value="${businessTypeVO.id}" label="${businessTypeVO.description}" selected="${businessTypeVO.id==merchantVO.businessTypeId}"/>
				</c:forEach>
			</aui:select>
		</div>
		
		<div class="control-group">
			<aui:select name="industry" helpMessage="help.industry"  label="label.industry" id="industry">
				<c:forEach var="industryVO" items="${listIndustries}">
					<aui:option value="${industryVO.id}" label="${industryVO.description}" selected="${industryVO.id==merchantVO.industryId}"/>
				</c:forEach>
			</aui:select>
		</div>
		
		<div class="control-group">
			<aui:input label="label.issuedBusinessID" helpMessage="help.issuedBusinessID" name="issuedBusinessID" value="${merchantVO.issuedBusinessID}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.issuedPersonalID" helpMessage="help.issuedPersonalID" name="issuedPersonalID" value="${merchantVO.issuedPersonalID}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.typeAccountApplication" helpMessage="help.typeAccountApplication" name="typeAccountApplication" value="${merchantVO.typeAccountApplication}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.estimatedAnnualSales" helpMessage="help.estimatedAnnualSales" name="estimatedAnnualSales" value="${merchantVO.estimatedAnnualSales}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<%-- <a class="btn" href="<%= goBack %>"><fmt:message key="label.goBack"/></a> --%>
		<%-- <a class="btn btn-primary" href="<%= keepInformation %>"><fmt:message key="label.next"/></a> --%>
		<aui:button  type="submit" name="save" value="label.next" />
		
	</div>
</fieldset>
<%-- </aui:form> --%>