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
<liferay-ui:success key="subscriptionSavedSuccessfully" message="label.subscriptionSavedSuccessfully" />
<liferay-ui:success key="subscriptionUpdatedSuccessfully" message="label.subscriptionUpdatedSuccessfully" />
<liferay-ui:success key="subscriptionDeletedSuccessfully" message="label.subscriptionDeletedSuccessfully" />
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

	ArrayList<SubscriptionVO> listSubscriptions = (ArrayList<SubscriptionVO>)session.getAttribute("listSubscriptions");
	if(listSubscriptions == null) listSubscriptions = new ArrayList<SubscriptionVO>();
%>

<portlet:actionURL var="listPlanSubscriptions" name="listPlanSubscriptions"/>
<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLSubscriptions"/>

<aui:form method="post">
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationSubscription"/> </span>
	</legend>
	<div class="">
		<div id="contenedor">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLSubscriptions%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listSubscriptions = Methods.orderSubscriptions(listSubscriptions,orderByCol,orderByType);
						results = new ArrayList<SubscriptionVO>(ListUtil.subList(listSubscriptions, searchContainer.getStart(), searchContainer.getEnd()));
						total = listSubscriptions.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.SubscriptionVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="subscriptionVO">
					
					<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewSubscription.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.plan" property="planVO.name" value="planVO.name" orderable="true" orderableProperty="planVO.name" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.status" property="status" value="status" orderable="false" orderableProperty="status"/>
					<liferay-ui:search-container-column-text name="label.quantity" property="quantity" value="quantity" orderable="false" orderableProperty="quantity"/>
					<liferay-ui:search-container-column-text name="label.start" value="<%=Utilities.formatDate(subscriptionVO.getStart()) %>" orderable="false" orderableProperty="start"/>
					
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<portlet:actionURL var="editURL" name="listPlanEditPlan">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="mvcPath" value="/jsp/editSubscription.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" />
							
							<portlet:actionURL var="deleteURL" name="deleteSubscription">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							</portlet:actionURL>
							<liferay-ui:icon-delete message="label.delete" url="<%=deleteURL.toString()%>" />
							 
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		
		
		
			<%-- <liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLCountryRestriction%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listCountryRestrictions = Methods.orderCountryRestriction(listCountryRestrictions,orderByCol,orderByType);
						results = new ArrayList(ListUtil.subList(listCountryRestrictions, searchContainer.getStart(), searchContainer.getEnd()));
						total = listCountryRestrictions.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.CountryRestrictionVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="countryRestrictionVO">
					
					<liferay-portlet:renderURL varImpl="rowURLCountryRestriction">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="mvcPath" value="/jsp/viewCountryRestriction.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.country" property="countryVO.name" value="countryVO.name" orderable="true" orderableProperty="countryVO.name" href="<%= rowURLCountryRestriction %>"/>
					<liferay-ui:search-container-column-text name="label.value" property="value" value="value" orderable="false" orderableProperty="value"/>
					<liferay-ui:search-container-column-text name="label.concept" property="concept" value="concept" orderable="false" orderableProperty="concept"/>
					
					<%if(!countryRestrictionVO.getStatus().equalsIgnoreCase("1")) {%>
							<liferay-ui:search-container-column-text name="label.status" value="<%=active%>" orderable="false" orderableProperty="status"/>
					<%}else{%> 
							<liferay-ui:search-container-column-text name="label.status" value="<%=inactive%>" orderable="false" orderableProperty="status"/>
					<%}%>
					
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<portlet:actionURL var="editURLCountryRestriction" name="listCountriesEditCountryRestriction">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="mvcPath" value="/jsp/editCountryRestriction.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURLCountryRestriction.toString()%>" />
							
							<portlet:actionURL var="inactivateURLCountryRestriction" name="updateStatusCountryRestriction">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							</portlet:actionURL>
							<%if(!countryRestrictionVO.getStatus().equalsIgnoreCase("1")) {%>
									<liferay-ui:icon onClick="return confirm('Are you sure do you want to change this Country Restriction status?')" image="edit" message="label.inactivate"  url="<%=inactivateURLCountryRestriction.toString()%>" />
							<%}else{%> 
									<liferay-ui:icon onClick="return confirm('Are you sure do you want to change this Country Restriction status?')" image="edit" message="label.activate" url="<%=inactivateURLCountryRestriction.toString()%>" />
							<%}%> 
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container> --%>
			<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"MerchantAdministrator\", true) %>">
				<span class="newSubscription" >
					<a href="<%= listPlanSubscriptions %>"><fmt:message key="label.newSubscription"/></a>
				</span>
			</c:if>
			
			
		</div>
	</div>
</fieldset>
</aui:form>