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
<liferay-ui:success key="businessTypeSavedSuccessfully" message="label.businessTypeSavedSuccessfully" />
<liferay-ui:success key="businessTypeUpdatedSuccessfully" message="label.businessTypeUpdatedSuccessfully" />
<liferay-ui:success key="businessTypeInactivateSuccessfully" message="label.businessTypeInactivateSuccessfully" />
<liferay-ui:success key="businessTypeActivateSuccessfully" message="label.businessTypeActivateSuccessfully" />
<liferay-ui:error key="ProcessorMDTR.updateBusinessType.BusinessTypeDAOException" message="error.ProcessorMDTR.updateBusinessType.BusinessTypeDAOException" />
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

	ArrayList<BusinessTypeVO> listBusinessTypes = (ArrayList<BusinessTypeVO>)session.getAttribute("listBusinessTypes");
	if(listBusinessTypes == null) listBusinessTypes = new ArrayList<BusinessTypeVO>();
%>

<portlet:renderURL var="newBusinessType">
	<portlet:param name="jspPage" value="/jsp/newBusinessType.jsp" />
</portlet:renderURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLBusinessType" />

<aui:form method="post">
	<div class="table">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLBusinessType%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
					listBusinessTypes = Methods.orderBusinessType(listBusinessTypes,orderByCol,orderByType);
						results = new ArrayList<BusinessTypeVO>(ListUtil.subList(listBusinessTypes, searchContainer.getStart(), searchContainer.getEnd()));
						total = listBusinessTypes.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.BusinessTypeVO" rowVar="posi" indexVar="indiceBusinessType" keyProperty="id" modelVar="businessTypeVO">
					
					<liferay-portlet:renderURL varImpl="rowURLBusinessType">
							<portlet:param name="indiceBusinessType" value="<%=String.valueOf(indiceBusinessType)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewBusinessTypeDetail.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="Name" property="description" value="description" orderable="false" orderableProperty="description" href="<%= rowURLBusinessType %>"/>
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<liferay-portlet:renderURL varImpl="editURLBusinessType">
								<portlet:param name="mvcPath" value="/jsp/editBusinessType.jsp" />
								<portlet:param name="indiceBusinessType" value="<%=String.valueOf(indiceBusinessType)%>"/>
							</liferay-portlet:renderURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURLBusinessType.toString()%>" />
							
							<portlet:actionURL var="inactivateURLBusinessType" name="inactivateBusinessType">
								<portlet:param name="indiceBusinessType" value="<%=String.valueOf(indiceBusinessType)%>"/>
							</portlet:actionURL>
							<% if(businessTypeVO.getStatus().equalsIgnoreCase("0")){%>
								<liferay-ui:icon-deactivate  label="label.inactivate" url="<%=inactivateURLBusinessType.toString()%>" />
							<%}else{ %>
								<liferay-ui:icon image="activate" label="label.inactivate" url="<%= inactivateURLBusinessType.toString() %>" />
							<%}%>
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		
		<a href="<%= newBusinessType %>"><fmt:message key="label.newBusinessType"/></a>
		
	</div>
</aui:form>