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
<%@ page import="com.liferay.portal.kernel.language.LanguageUtil" %>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:success key="merchantSavedSuccessfully" message="label.merchantSavedSuccessfully" />
<liferay-ui:success key="merchantUpdatedSuccessfully" message="label.merchantUpdatedSuccessfully" />
<liferay-ui:success key="updateStatusMerchant.Inactivate" message="label.updateStatusMerchant.Inactivate"/>
<liferay-ui:success key="updateStatusMerchant.Activate" message="label.updateStatusMerchant.Activate"/>


<liferay-ui:success key="ProcessorMDTR.deleteMerchant.MerchantDAOException" message="label.ProcessorMDTR.changeStatusMerchant.MerchantDAOException" />

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
	String active = "Active";
	String inactive = "Inactive";
%>

<portlet:actionURL var="newMerchant" name="newMerchant"/>
<portlet:actionURL var="listFilter" name="listFilter"/>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLMerchant">
	<portlet:param name="action" value="listAllMerchantsFilter" />
	<portlet:param name="nameMerchant" value="<%= nameMerchant %>" />
	<portlet:param name="status" value="<%= status %>" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL varImpl="merchantSearchURL">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</liferay-portlet:renderURL>

<%-- <aui:form action="<%=merchantSearchURL %>" method="post"> --%>

<aui:form action="<%=listFilter %>" method="post">

		<div class="table">
			<liferay-ui:search-container displayTerms="<%= new DisplayTerms(renderRequest) %>" emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLMerchant%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				
				<liferay-ui:search-form page="/jsp/merchant_search.jsp" servletContext="<%= application %>"/>
				
				<liferay-ui:search-container-results>
					<%
						DisplayTerms displayTerms =searchContainer.getDisplayTerms();
						System.out.println("displayTerms.isAndOperator()? ... " + displayTerms.isAndOperator());
						System.out.println("displayTerms.isAdvancedSearch()? ... " + displayTerms.isAdvancedSearch());
						/* Methods.searchBusiness(listBusinessTypes, orderByCol, orderByType); */
						if (displayTerms.isAdvancedSearch()) {
							System.out.println("nameMerchant ... " + nameMerchant);
							System.out.println("status ... " + status);
						}else{
							String searchkeywords = displayTerms.getKeywords();
							System.out.println("searchkeywords: " + searchkeywords);
							String numbesearchkeywords = Validator.isNumber(searchkeywords) ? searchkeywords : String.valueOf(0);
							System.out.println("numbesearchkeywords: " + numbesearchkeywords);
							System.out.println("nameMerchant ... " + nameMerchant);
							System.out.println("status ... " + status);
						}
						System.out.println("\n\n\n\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ... ");	
					
					
					
						listMerchants = Methods.orderMerchant(listMerchants,orderByCol,orderByType);
						results = new ArrayList<MerchantVO>(ListUtil.subList(listMerchants, searchContainer.getStart(), searchContainer.getEnd()));
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
					<liferay-ui:search-container-column-text name="label.countryBusinessInformation" value="${merchantVO.countryVOBusiness.name}" orderable="false" orderableProperty="countryVOBusiness.name"/>
					<%if(!merchantVO.getStatus().equalsIgnoreCase("1")) {%>
							<liferay-ui:search-container-column-text name="label.status" value="<%=active%>" orderable="false" orderableProperty="status"/>
					<%}else{%> 
							<liferay-ui:search-container-column-text name="label.status" value="<%=inactive%>" orderable="false" orderableProperty="status"/>
					<%}%>
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<portlet:actionURL var="editURL" name="listCountriesEditMerchant">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="mvcPath" value="/jsp/editMerchant.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" />
							
							<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"MerchantAdministrator\", true) %>">
								<portlet:actionURL var="inactivateURLMerchant" name="updateStatusMerchant">
									<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								</portlet:actionURL>
								<%if(!merchantVO.getStatus().equalsIgnoreCase("1")) {%>
										<liferay-ui:icon onClick="return confirm('Are you sure do you want to change this Merchant status?')" image="edit" message="label.inactivate"  url="<%=inactivateURLMerchant.toString()%>" />
								<%}else{%> 
										<liferay-ui:icon onClick="return confirm('Are you sure do you want to change this Merchant status?')" image="edit" message="label.activate" url="<%=inactivateURLMerchant.toString()%>" />
								<%}%>
							</c:if>
							
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
			<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"MerchantAdministrator\", true) %>">
				<span class="newMerchant" >
					<a href="<%= newMerchant %>"><fmt:message key="label.newMerchant"/></a>
				</span>
			</c:if>
		</div>
</aui:form>