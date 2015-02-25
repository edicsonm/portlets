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
<liferay-ui:error key="ProcessorMDTR.saveCountryRestriction.CountryRestrictionDAOException" message="error.ProcessorMDTR.saveCountryRestriction.CountryRestrictionDAOException" />
<% 
	System.out.print("Ejecuta pa pagina viewCountryRestriction.jsp");	
	ArrayList<CountryRestrictionVO> resultsListSubscriptions = (ArrayList<CountryRestrictionVO>)session.getAttribute("results");
	CountryRestrictionVO countryRestrictionVO = (CountryRestrictionVO)resultsListSubscriptions.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("countryRestrictionVO", countryRestrictionVO);
%>

<portlet:actionURL name="editCountryRestriction" var="submitFormEditCountryRestriction">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackEditCountryRestriction">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitFormEditCountryRestriction %>" method="post">
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.informationCountryRestriction"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.country"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${countryRestrictionVO.countryVO.name}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.concept"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${countryRestrictionVO.concept}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.value"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${countryRestrictionVO.value}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.timeUnit"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${countryRestrictionVO.timeUnit}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBackEditCountryRestriction %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
				<div class="column2-2">
					<aui:button type="submit" name="save" value="label.save" />
				</div>
			</div>
		</div>
	</div>
</aui:form>