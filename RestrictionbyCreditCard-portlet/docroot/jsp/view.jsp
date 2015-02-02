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
<liferay-ui:success key="creditCardRestrictionSavedSuccessfully" message="label.creditCardRestrictionSavedSuccessfully" />
<liferay-ui:success key="creditCardRestrictionUpdatedSuccessfully" message="label.creditCardRestrictionUpdatedSuccessfully" />
<liferay-ui:success key="creditCardRestrictionDeletedSuccessfully" message="label.creditCardRestrictionDeletedSuccessfully" />
<liferay-ui:error key="ProcessorMDTR.deleteCreditCardRestriction.CreditCardRestrictionDAOException" message="error.ProcessorMDTR.deleteCreditCardRestriction.MerchantRestrictionDAOException" />

<% 
	session.removeAttribute("creditCardRestrictionVO");

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

	ArrayList<CreditCardRestrictionVO> listCreditCardRestrictions = (ArrayList<CreditCardRestrictionVO>)session.getAttribute("listCreditCardRestrictions");
	if(listCreditCardRestrictions == null) listCreditCardRestrictions = new ArrayList<CreditCardRestrictionVO>();
%>

<%-- <portlet:renderURL var="newSubscription">
	<portlet:param name="jspPage" value="/jsp/newSubscription.jsp" />
</portlet:renderURL> --%>

<portlet:renderURL var="newCreditCardRestriction">
	<portlet:param name="jspPage" value="/jsp/newCreditCardRestriction.jsp" />
</portlet:renderURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form method="post">
	<div class="table">
		<div class="row">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listCreditCardRestrictions = Methods.orderCreditCardRestriction(listCreditCardRestrictions,orderByCol,orderByType);
						results = ListUtil.subList(listCreditCardRestrictions, searchContainer.getStart(), searchContainer.getEnd());
						total = listCreditCardRestrictions.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.CreditCardRestrictionVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="creditCardRestrictionVO">
					
					<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewCreditCardRestriction.jsp" />
					</liferay-portlet:renderURL>
					
					<%-- <liferay-ui:search-container-column-text name="label.merchant" property="merchantVO.name" value="merchantVO.name" orderable="true" orderableProperty="countryVO.name" href="<%= rowURL %>"/> --%>
					<liferay-ui:search-container-column-text name="label.value" property="value" value="value" orderable="false" orderableProperty="value" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.concept" property="concept" value="concept" orderable="false" orderableProperty="concept"/>
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<%-- <portlet:actionURL var="editURL" name="listMerchantsEditMerchantRestriction">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="mvcPath" value="/jsp/editCountryRestriction.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" /> --%>
							
							<liferay-portlet:renderURL varImpl="editURL">
								<portlet:param name="mvcPath" value="/jsp/editCreditCardRestriction.jsp" />
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							</liferay-portlet:renderURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" />
							
							<portlet:actionURL var="deleteURL" name="deleteCreditCardRestriction">
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
				<span class="newCreditCardRestriction" >
					<a href="<%= newCreditCardRestriction %>"><fmt:message key="label.newCreditCardRestriction"/></a>
				</span>
			</div>
			<div class="column2-2">
			</div>
		</div>
		
	</div>
</aui:form>