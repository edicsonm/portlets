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
<portlet:renderURL var="goBackViewCountryRestriction">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationCountryRestriction"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="details">
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.country"/></dt>
								<dd><c:out value="${countryRestrictionVO.countryVO.name}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.concept"/></dt>
								<dd><c:out value="${countryRestrictionVO.concept}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.value"/></dt>
								<dd><c:out value="${countryRestrictionVO.value}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.timeUnit"/></dt>
								<dd><c:out value="${countryRestrictionVO.timeUnit}"/></dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
			<a href="<%= goBackViewCountryRestriction %>"><fmt:message key="label.goBack"/></a>
		</div>
	</fieldset>
</aui:form>