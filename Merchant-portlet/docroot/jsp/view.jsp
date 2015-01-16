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
<liferay-ui:success key="merchantSavedSuccessfully" message="label.merchantSavedSuccessfully" />
<liferay-ui:success key="merchantUpdatedSuccessfully" message="label.merchantUpdatedSuccessfully" />
<liferay-ui:success key="merchantDeletedSuccessfully" message="label.merchantDeletedSuccessfully" />
<% 
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

	ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
	if(listMerchants == null) listMerchants = new ArrayList<MerchantVO>();
%>

<portlet:actionURL var="listCountries" name="listCountries"/>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form method="post">
	<div class="table">
		<div class="row">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listMerchants = Methods.orderMerchant(listMerchants,orderByCol,orderByType);
						results = ListUtil.subList(listMerchants, searchContainer.getStart(), searchContainer.getEnd());
						total = listMerchants.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.MerchantVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="merchantVO">
					
					<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewMerchant.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.merchant" property="name" value="name" orderable="true" orderableProperty="name" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.country" property="countryVO.name" value="countryVO.name" orderable="false" orderableProperty="countryVO.name"/>
					<%-- <liferay-ui:search-container-column-text name="label.concept" property="concept" value="concept" orderable="false" orderableProperty="concept"/> --%>
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<portlet:actionURL var="editURL" name="listCountriesEditMerchant">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="mvcPath" value="/jsp/editMerchant.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" />
							
							<%-- <liferay-portlet:renderURL varImpl="editURL">
								<portlet:param name="mvcPath" value="/jsp/editMerchant.jsp" />
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							</liferay-portlet:renderURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" /> --%>
							
							<portlet:actionURL var="deleteURL" name="deleteMerchant">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							</portlet:actionURL>
							<liferay-ui:icon-delete message="label.delete" url="<%=deleteURL.toString()%>" />
							 
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</div>
		
		<div class="row">
			<div class="column1-2">
				<span class="newMerchant" >
					<a href="<%= listCountries %>"><fmt:message key="label.newMerchant"/></a>
				</span>
			</div>
			<div class="column2-2">
			</div>
		</div>
		
	</div>
</aui:form>