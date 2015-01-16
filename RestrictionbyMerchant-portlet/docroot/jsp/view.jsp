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
<liferay-ui:success key="merchantRestrictionSavedSuccessfully" message="label.merchantRestrictionSavedSuccessfully" />
<liferay-ui:success key="merchantRestrictionUpdatedSuccessfully" message="label.merchantRestrictionUpdatedSuccessfully" />
<liferay-ui:success key="merchantRestrictionDeletedSuccessfully" message="label.merchantRestrictionDeletedSuccessfully" />
<liferay-ui:error key="ProcessorMDTR.deleteMerchantRestriction.MerchantRestrictionDAOException" message="error.ProcessorMDTR.deleteMerchantRestriction.MerchantRestrictionDAOException" />

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

	ArrayList<MerchantRestrictionVO> listMerchantRestrictions = (ArrayList<MerchantRestrictionVO>)session.getAttribute("listMerchantRestrictions");
	if(listMerchantRestrictions == null) listMerchantRestrictions = new ArrayList<MerchantRestrictionVO>();
%>

<%-- <portlet:renderURL var="newSubscription">
	<portlet:param name="jspPage" value="/jsp/newSubscription.jsp" />
</portlet:renderURL> --%>

<portlet:actionURL var="listMerchants" name="listMerchants"/>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form method="post">
	<div class="table">
		<div class="row">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listMerchantRestrictions = Methods.orderMerchantRestriction(listMerchantRestrictions,orderByCol,orderByType);
						results = ListUtil.subList(listMerchantRestrictions, searchContainer.getStart(), searchContainer.getEnd());
						total = listMerchantRestrictions.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.MerchantRestrictionVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="merchantRestrictionVO">
					
					<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewMerchantRestriction.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.merchant" property="merchantVO.name" value="merchantVO.name" orderable="true" orderableProperty="countryVO.name" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.value" property="value" value="value" orderable="false" orderableProperty="value"/>
					<liferay-ui:search-container-column-text name="label.concept" property="concept" value="concept" orderable="false" orderableProperty="concept"/>
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<portlet:actionURL var="editURL" name="listMerchantsEditMerchantRestriction">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="mvcPath" value="/jsp/editCountryRestriction.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" />
							
							<%-- <liferay-portlet:renderURL varImpl="editURL">
								<portlet:param name="mvcPath" value="/jsp/editSubscription.jsp" />
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							</liferay-portlet:renderURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" /> --%>
							
							<portlet:actionURL var="deleteURL" name="deleteCountryRestriction">
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
				<span class="newSubscription" >
					<a href="<%= listMerchants %>"><fmt:message key="label.newMerchantRestriction"/></a>
				</span>
			</div>
			<div class="column2-2">
			</div>
		</div>
		
	</div>
</aui:form>