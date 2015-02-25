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
<liferay-ui:success key="countryBlockListSavedSuccessfully" message="label.countryBlockListSavedSuccessfully" />
<liferay-ui:success key="countryBlockListUpdatedSuccessfully" message="label.countryBlockListUpdatedSuccessfully" />
<% 
	String orderByColAnterior = (String)session.getAttribute("orderByCol");
	String orderByTypeAnterior = (String)session.getAttribute("orderByType");
	
	String orderByCol = (String)renderRequest.getParameter("orderByCol");
	String orderByType = (String)renderRequest.getAttribute("orderByType");
	
	if(orderByType == null){
		orderByType = "asc";
	}
	
	if(orderByCol == null){
		orderByCol = "countryVO.name";
	}else if(orderByCol.equalsIgnoreCase(orderByColAnterior)){
		if (orderByTypeAnterior.equalsIgnoreCase("asc")){
			orderByType = "desc";
		}else{
			orderByType = "asc";
		}
	}else{
		orderByType = "asc";
	}	

	ArrayList<CountryBlockListVO> listCountryBlockList = (ArrayList<CountryBlockListVO>)session.getAttribute("listCountryBlockList");
	if(listCountryBlockList == null) listCountryBlockList = new ArrayList<CountryBlockListVO>();
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLCountryBlockList" />

<portlet:actionURL name="savePlan" var="submitFormManageRestrictionsByContry">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</portlet:actionURL>

<aui:form action="<%= submitFormManageRestrictionsByContry %>" method="post">
	<div class="table">
		<div class="row">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30"  id="containerCountries"  iteratorURL="<%=renderURLCountryBlockList%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listCountryBlockList = Methods.orderCountryBlockList(listCountryBlockList,orderByCol,orderByType);
						results = ListUtil.subList(listCountryBlockList, searchContainer.getStart(), searchContainer.getEnd());
						total = listCountryBlockList.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row  className="au.com.billingbuddy.vo.objects.CountryBlockListVO"  rowVar="posi" indexVar="indice" keyProperty="countryVO.numeric" modelVar="countryBlockListVO">
					<%-- <liferay-portlet:renderURL varImpl="rowURLCountryRestriction">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="mvcPath" value="/jsp/viewCountryRestriction.jsp" />
					</liferay-portlet:renderURL> --%>
					<%-- <liferay-ui:search-container-column-text name="label.country" property="countryVO.name" value="countryVO.name" orderable="true" orderableProperty="countryVO.name" href="<%= rowURLCountryRestriction %>"/> --%>
					<liferay-ui:search-container-column-text name="label.country" property="countryVO.name" value="countryVO.name" orderable="true" orderableProperty="countryVO.name"/>
					<%-- <liferay-ui:search-container-column-text name="label.transaction" property="transaction" value="transaction" orderable="false" orderableProperty="value"/>
					<liferay-ui:search-container-column-text name="label.merchantServerLocation" property="merchantServerLocation" value="merchantServerLocation" orderable="false" orderableProperty="merchantServerLocation"/>
					 --%>
					
					<liferay-ui:search-container-column-text name="label.transaction">
						<input type="checkbox" name="transaction_<%=countryBlockListVO.getCountryVO().getNumeric()%>" id="transaction_<%=countryBlockListVO.getCountryVO().getNumeric()%>" value="<%=countryBlockListVO.getCountryVO().getNumeric()%>">
					</liferay-ui:search-container-column-text>
					
					<liferay-ui:search-container-column-text name="label.merchantServerLocation">
						<input type="checkbox" name="merchantServerLocation_<%=countryBlockListVO.getCountryVO().getNumeric()%>" id="merchantServerLocation_<%=countryBlockListVO.getCountryVO().getNumeric()%>" value="<%=countryBlockListVO.getCountryVO().getNumeric()%>">
					</liferay-ui:search-container-column-text>
					
					
					<%-- <liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<portlet:actionURL var="editURLCountryRestriction" name="listCountriesEditCountryRestriction">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="mvcPath" value="/jsp/editCountryRestriction.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURLCountryRestriction.toString()%>" />
							
							<liferay-portlet:renderURL varImpl="editURL">
								<portlet:param name="mvcPath" value="/jsp/editSubscription.jsp" />
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							</liferay-portlet:renderURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" />
							
							<portlet:actionURL var="deleteURLCountryRestriction" name="deleteCountryRestriction">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							</portlet:actionURL>
							<liferay-ui:icon-delete message="label.delete" url="<%=deleteURLCountryRestriction.toString()%>" />
							 
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text> --%>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</div>
		
		<%-- <div class="row">
			<div class="column1-2">
				<span class="newSubscription" >
					<a href="<%= listCountriesCountryRestriction %>"><fmt:message key="label.newCountryRestriction"/></a>
				</span>
			</div>
			<div class="column2-2">
			</div>
		</div> --%>
		
		<div class="row">
			<div class="column1-2">
				<span class="newSubscription" >
					<aui:button type="submit" name="save" value="label.save" />
				</span>
			</div>
			<div class="column2-2">
			</div>
		</div> 
		
	</div>
</aui:form>