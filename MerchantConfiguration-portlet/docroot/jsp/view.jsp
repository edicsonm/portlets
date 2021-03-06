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
<liferay-ui:success key="merchantConfigurationSavedSuccessfully" message="label.merchantConfigurationSavedSuccessfully" />
<liferay-ui:success key="merchantConfigurationUpdatedSuccessfully" message="label.merchantConfigurationUpdatedSuccessfully" />
<% 
	session.removeAttribute("merchantConfigurationVO");	
	String orderByColAnterior = (String)session.getAttribute("orderByCol");
	String orderByTypeAnterior = (String)session.getAttribute("orderByType");
	
	String orderByCol = (String)renderRequest.getParameter("orderByCol");
	String orderByType = (String)renderRequest.getAttribute("orderByType");
	
	if(orderByType == null){
		orderByType = "asc";
	}
	
	if(orderByCol == null){
		orderByCol = "id";
	}else if(orderByCol.equalsIgnoreCase(orderByColAnterior)){
		if (orderByTypeAnterior.equalsIgnoreCase("asc")){
			orderByType = "desc";
		}else{
			orderByType = "asc";
		}
	}else{
		orderByType = "asc";
	}	

	ArrayList<MerchantConfigurationVO> listMerchantConfigurations = (ArrayList<MerchantConfigurationVO>)session.getAttribute("listMerchantConfigurations");
	if(listMerchantConfigurations == null) listMerchantConfigurations = new ArrayList<MerchantConfigurationVO>();
%>

<portlet:actionURL var="listMerchantsMerchantConfiguration" name="listMerchantsMerchantConfiguration"/>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form method="post">
	<div class="table">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listMerchantConfigurations = Methods.orderMerchantConfiguration(listMerchantConfigurations,orderByCol,orderByType);
						results = new ArrayList(ListUtil.subList(listMerchantConfigurations, searchContainer.getStart(), searchContainer.getEnd()));
						total = listMerchantConfigurations.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.MerchantConfigurationVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="merchantConfigurationVO">
					
					<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewMerchantConfiguration.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.merchant" property="merchantVO.name" orderable="true" orderableProperty="merchantId" href="<%= rowURL %>"/>
					
					<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"MerchantAdministrator\", true) %>">
						<liferay-ui:search-container-column-text name="Accion">
							<liferay-ui:icon-menu>
								
								<portlet:actionURL var="editURL" name="listMerchantsEditMerchant">
									<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
									<portlet:param name="mvcPath" value="/jsp/editMerchantConfiguration.jsp" />
								</portlet:actionURL>
								<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" />
								 
							</liferay-ui:icon-menu>
						</liferay-ui:search-container-column-text>
					</c:if>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
			
			<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"MerchantAdministrator\", true) %>">
				<span class="newMerchant" >
					<a href="<%= listMerchantsMerchantConfiguration %>"><fmt:message key="label.newMerchantConfiguration"/></a>
				</span>
			</c:if>
		
	</div>
</aui:form>