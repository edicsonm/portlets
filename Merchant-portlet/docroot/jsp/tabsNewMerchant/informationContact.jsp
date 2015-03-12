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
	<portlet:param name="jspPage" value="/jsp/tabsNewMerchant/informationBusiness.jsp" />
</portlet:renderURL>

<%-- <aui:form  action="<%= submitFormMerchant %>" method="post"> --%>
	<div class="table">
		<div class="section">
			
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
			
			<%-- <div class="row">
				<div class="column1-1">
					<aui:input name="lastName"  label="label.lastName" helpMessage="help.lastName" value="${merchantVO.lastName}" showRequiredLabel="false" type="text" required="true">
						<aui:validator name="alphanum"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="phoneNumber"  label="label.phoneNumber" helpMessage="help.phoneNumber" value="${merchantVO.phoneNumber}" showRequiredLabel="false" type="text" required="true">
						<aui:validator name="alphanum"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="faxNumber"  label="label.faxNumber" helpMessage="help.faxNumber" value="${merchantVO.faxNumber}" showRequiredLabel="false" type="text" required="true">
						<aui:validator name="alphanum"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="emailAddress"  label="label.emailAddress" helpMessage="help.emailAddress" value="${merchantVO.emailAddress}" showRequiredLabel="false" type="text" required="true">
						<aui:validator name="alphanum"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="alternateEmailAddress"  label="label.alternateEmailAddress" helpMessage="help.alternateEmailAddress" value="${merchantVO.alternateEmailAddress}" showRequiredLabel="false" type="text" required="true">
						<aui:validator name="alphanum"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="cityPersonalInformation"  label="label.cityPersonalInformation" helpMessage="help.cityPersonalInformation" value="${merchantVO.cityPersonalInformation}" showRequiredLabel="false" type="text" required="true">
						<aui:validator name="alphanum"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input name="postCodePersonalInformation"  label="label.postCodePersonalInformation" helpMessage="help.postCodePersonalInformation" value="${merchantVO.postCodePersonalInformation}" showRequiredLabel="false" type="text" required="true">
						<aui:validator name="alphanum"/>
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
			</div> --%>
			
			<a class="btn btn-primary" href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
			<%-- <a href="<%= goBack %>"><fmt:message key="label.goBack"/></a> --%>
			<!-- <aui:button  type="submit" name="save" value="label.next" /> --%>
			<!-- <aui:button  type="submit" name="goBack" value="label.goBack" /> -->
			<aui:button type="submit" name="save" value="label.save" />
		</div>
	</div>
<%-- </aui:form> --%>