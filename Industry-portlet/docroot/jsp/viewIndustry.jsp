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
<liferay-ui:success key="industrySavedSuccessfully" message="label.industrySavedSuccessfully" />
<liferay-ui:success key="industryUpdatedSuccessfully" message="label.industryUpdatedSuccessfully" />
<liferay-ui:success key="industryInactivateSuccessfully" message="label.industryInactivateSuccessfully" />
<liferay-ui:success key="industryActivateSuccessfully" message="label.industryActivateSuccessfully" />
<liferay-ui:error key="ProcessorMDTR.updateIndustry.IndustryDAOException" message="error.ProcessorMDTR.updateIndustry.IndustryDAOException" />
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

	ArrayList<IndustryVO> listIndustries = (ArrayList<IndustryVO>)session.getAttribute("listIndustries");
	if(listIndustries == null) listIndustries = new ArrayList<IndustryVO>();
%>

<portlet:renderURL var="newIndustry">
	<portlet:param name="jspPage" value="/jsp/newIndustry.jsp" />
</portlet:renderURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLIndustry" />

<aui:form method="post">
	<div class="table">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLIndustry%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listIndustries = Methods.orderIndustry(listIndustries,orderByCol,orderByType);
						results = new ArrayList<IndustryVO>(ListUtil.subList(listIndustries, searchContainer.getStart(), searchContainer.getEnd()));
						total = listIndustries.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.IndustryVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="industryVO">
					
					<liferay-portlet:renderURL varImpl="rowURLIndustry">
							<portlet:param name="indiceIndustry" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewIndustryDetail.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="Name" property="description" value="description" orderable="false" orderableProperty="description" href="<%= rowURLIndustry %>"/>
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<liferay-portlet:renderURL varImpl="editURLIndustry">
								<portlet:param name="mvcPath" value="/jsp/editIndustry.jsp" />
								<portlet:param name="indiceIndustry" value="<%=String.valueOf(indice)%>"/>
							</liferay-portlet:renderURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURLIndustry.toString()%>" />
							
							<portlet:actionURL var="inactivateURLIndustry" name="inactivateIndustry">
								<portlet:param name="indiceIndustry" value="<%=String.valueOf(indice)%>"/>
							</portlet:actionURL>
							<% if(industryVO.getStatus().equalsIgnoreCase("0")){%>
								<liferay-ui:icon-deactivate  label="label.inactivate" url="<%=inactivateURLIndustry.toString()%>" />
							<%}else{ %>
								<liferay-ui:icon image="activate" label="label.inactivate" url="<%= inactivateURLIndustry.toString() %>" />
							<%}%>
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		
		<span class="newElement" >
			<a href="<%= newIndustry %>"><fmt:message key="label.newIndustry"/></a>
		</span>
		
		<%-- <div class="row">
			<div class="column1-2">
				<span class="newElement" >
					<a href="<%= newIndustry %>"><fmt:message key="label.newIndustry"/></a>
				</span>
			</div>
			<div class="column2-2">
			</div>
		</div> --%>
		
	</div>
</aui:form>