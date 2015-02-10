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
System.out.println("Ejecuta esto ---");	
ArrayList<MerchantConfigurationVO> resultsListMerchantConfigurations = (ArrayList<MerchantConfigurationVO>)session.getAttribute("results");
	MerchantConfigurationVO merchantConfigurationVO = (MerchantConfigurationVO)resultsListMerchantConfigurations.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
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
						<label class="aui-field-label sub-title"><fmt:message key="label.informationMerchantConfiguration"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.merchant"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantConfigurationVO.id}"/>
				</div>
				<div class="column3-4">
					<%-- <label class="aui-field-label"><fmt:message key="label.urlApproved"/></label> --%>
				</div>
				<div class="column4-4">
					<%-- <c:out value="${merchantConfigurationVO.urlApproved}"/> --%>
				</div>
			</div>
			
			<div class="row">
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.urlApproved"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantConfigurationVO.urlApproved}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.urlDeny"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${merchantConfigurationVO.urlDeny}"/>
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