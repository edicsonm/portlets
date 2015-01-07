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
<liferay-ui:success key="planSavedSuccessfully" message="label.planSavedSuccessfully" />
<liferay-ui:success key="planUpdatedSuccessfully" message="label.planUpdatedSuccessfully" />
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

	ArrayList<PlanVO> listPlans = (ArrayList<PlanVO>)session.getAttribute("listPlans");
	if(listPlans == null) listPlans = new ArrayList<PlanVO>();
%>

<portlet:renderURL var="newPlan">
	<portlet:param name="jspPage" value="/jsp/newPlan.jsp" />
</portlet:renderURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form method="post">
	<div class="table">
		<div class="row">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listPlans = Methods.orderPlans(listPlans,orderByCol,orderByType);
						results = ListUtil.subList(listPlans, searchContainer.getStart(), searchContainer.getEnd());
						total = listPlans.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.PlanVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="planVO">
					
					<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewPlan.jsp" />
							<portlet:param name="planId" value="<%=String.valueOf(planVO.getId())%>"/>
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="Name" property="name" value="name" orderable="true" orderableProperty="name" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="Interval" property="interval" value="interval" orderable="true" orderableProperty="interval"/>
					<liferay-ui:search-container-column-text name="Amount" property="amount" value="amount" orderable="true" orderableProperty="amount"/>
					
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<liferay-portlet:renderURL varImpl="editURL">
								<portlet:param name="mvcPath" value="/jsp/editPlan.jsp" />
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="idPlan" value="<%=String.valueOf(planVO.getId())%>"/>
							</liferay-portlet:renderURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" />
							
							<portlet:actionURL var="deleteURL" name="deletePlan">
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
				<span class="newPlan" >
					<a href="<%= newPlan %>"><fmt:message key="label.newPlan"/></a>
				</span>
			</div>
			<div class="column2-2">
			</div>
		</div>
		
	</div>
</aui:form>