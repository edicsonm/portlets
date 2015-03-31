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
<liferay-ui:error key="ProcessorMDTR.updateCountryRestriction.CountryRestrictionDAOException" message="error.ProcessorMDTR.updateCountryRestriction.CountryRestrictionDAOException" />
<liferay-ui:error key="ProcessorMDTR.updateCountryRestriction.CountryRestrictionDAOException.UNIQUE_CounNumeric_Mere_Concept" message="error.ProcessorMDTR.updateCountryRestriction.CountryRestrictionDAOException.UNIQUE_CounNumeric_Mere_Concept"/>
<% 
	CountryRestrictionVO countryRestrictionVO = (CountryRestrictionVO)session.getAttribute("countryRestrictionVO");
	request.setAttribute("countryRestrictionVO", countryRestrictionVO);
	ArrayList<CountryVO> listCountries = (ArrayList<CountryVO>)session.getAttribute("listCountries");
%>
<portlet:actionURL name="editCountryRestriction" var="submitFormEditCountryRestriction">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackCountryRestriction">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitFormEditCountryRestriction %>" method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationCountryRestriction"/></span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="control-group">
				<aui:select name="country" helpMessage="help.country"  label="label.country" id="country">
					<c:forEach var="countryVO" items="${listCountries}">
						<aui:option value="${countryVO.numeric}" label="${countryVO.name}" selected="${countryVO.numeric==countryRestrictionVO.countryNumeric}"/>
					</c:forEach>
				</aui:select>
			</div>
			
			<div class="control-group">
				<aui:select name="concept" helpMessage="help.concept" label="label.concept" id="concept">
					<aui:option value="Amount" label="label.amount" selected="${countryRestrictionVO.concept=='Amount'}"/>
					<aui:option value="Transactions" label="label.transactions" selected="${countryRestrictionVO.concept=='Transactions'}"/>
				</aui:select>
			</div>
			
			<div class="control-group">
				<aui:input label="label.value" helpMessage="help.value" showRequiredLabel="false" type="text" required="true" name="value" value="${countryRestrictionVO.value}">
					<aui:validator name="digits"/>
				</aui:input>
			</div>
			
			<div class="control-group">
				<aui:input label="label.timeUnit" helpMessage="help.timeUnit" showRequiredLabel="false" type="text" required="true" name="timeUnit" value="${countryRestrictionVO.timeUnit}">
					<aui:validator name="digits"/>
				</aui:input>
			</div>
			
			<a href="<%= goBackCountryRestriction %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="save" value="label.save" />
			
		</div>
	</fieldset>
</aui:form>