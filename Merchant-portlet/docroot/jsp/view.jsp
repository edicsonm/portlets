<%@page import="au.com.billigbuddy.utils.BBUtils"%>
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

<portlet:actionURL var="listFilter" name="listFilter">
	<%-- <portlet:param name="action" value="listAllMerchantsFilter" />
	<portlet:param name="nameMerchant" value="<%= nameMerchant %>" />
	<portlet:param name="status" value="<%= status %>" /> --%>
</portlet:actionURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLMerchant">
	<portlet:param name="action" value="listAllMerchantsFilter" />
	<portlet:param name="nameMerchant" value="<%= nameMerchant %>" />
	<portlet:param name="status" value="<%= status %>" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL varImpl="merchantSearchURL">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</liferay-portlet:renderURL>

<aui:form action="<%=merchantSearchURL %>" method="post">

		<div class="table">
			<liferay-ui:search-container displayTerms="<%= new DisplayTerms(renderRequest) %>" emptyResultsMessage="label.empty" delta="5" iteratorURL="<%=renderURLMerchant%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				
				<liferay-ui:search-form  page="/jsp/merchant_search.jsp" servletContext="<%= application %>"/>
				
				<liferay-ui:search-container-results>
					<%
						DisplayTerms displayTerms =searchContainer.getDisplayTerms();
						MerchantVO merchantVOAUX = new MerchantVO();	
						System.out.println("displayTerms.isAdvancedSearch()? ... " + displayTerms.isAdvancedSearch());
						/* Methods.searchBusiness(listBusinessTypes, orderByCol, orderByType); */
						if (displayTerms.isAdvancedSearch()) {//Entra aca si selecciona la busqueda avanzada
							System.out.println("Entra por el if ... ");
							if(displayTerms.isAndOperator()){//Selecciono ALL
								System.out.println("Selecciono *ALL");
								
								merchantVOAUX.setName(nameMerchant);
								merchantVOAUX.setCountryNumericMerchant(BBUtils.nullStringToNULL(countryBusinessInformation));
								merchantVOAUX.setBusinessTypeId(BBUtils.nullStringToNULL(businessType));
								merchantVOAUX.setIndustryId(BBUtils.nullStringToNULL(industry));
								merchantVOAUX.setStatus(BBUtils.nullStringToNULL(status));
								merchantVOAUX.setMatch("0");
								merchantVOAUX.setUserId(String.valueOf(PortalUtil.getUserId(request)));
								/* System.out.println("merchantVOAUX.getName() " + merchantVOAUX.getName());
								System.out.println("merchantVOAUX.getCountryNumericMerchant() " + merchantVOAUX.getCountryNumericMerchant());
								System.out.println("merchantVOAUX.getBusinessTypeId() " + merchantVOAUX.getBusinessTypeId());
								System.out.println("merchantVOAUX.getIndustryId() " + merchantVOAUX.getIndustryId());
								System.out.println("merchantVOAUX.getStatus() " + merchantVOAUX.getStatus());
								System.out.println("merchantVOAUX.getMatch() " + merchantVOAUX.getMatch());
								System.out.println("merchantVOAUX.getUserId() " + merchantVOAUX.getUserId()); */
								
							}else{
								
								System.out.println("Selecciono *ANY");
								merchantVOAUX.setName(nameMerchant);
								merchantVOAUX.setCountryNumericMerchant(BBUtils.nullStringToNULL(countryBusinessInformation));
								merchantVOAUX.setBusinessTypeId(BBUtils.nullStringToNULL(businessType));
								merchantVOAUX.setIndustryId(BBUtils.nullStringToNULL(industry));
								merchantVOAUX.setStatus(BBUtils.nullStringToNULL(status));
								merchantVOAUX.setMatch("1");
								merchantVOAUX.setUserId(String.valueOf(PortalUtil.getUserId(request)));
								
								/* System.out.println("merchantVOAUX.getName() " + merchantVOAUX.getName());
								System.out.println("merchantVOAUX.getCountryNumericMerchant() " + merchantVOAUX.getCountryNumericMerchant());
								System.out.println("merchantVOAUX.getBusinessTypeId() " + merchantVOAUX.getBusinessTypeId());
								System.out.println("merchantVOAUX.getIndustryId() " + merchantVOAUX.getIndustryId());
								System.out.println("merchantVOAUX.getStatus() " + merchantVOAUX.getStatus());
								System.out.println("merchantVOAUX.getMatch() " + merchantVOAUX.getMatch());
								System.out.println("merchantVOAUX.getUserId() " + merchantVOAUX.getUserId()); */
								
							}
							/* System.out.println("nameMerchant ... " + nameMerchant);
							System.out.println("status ... " + status); */
						}else{
							System.out.println("Entra por el else ... " + displayTerms.getKeywords());
							/* pstmt.setString(1,merchantVO.getName());
							pstmt.setString(2,merchantVO.getCountryNumericMerchant());
							pstmt.setString(3,merchantVO.getBusinessTypeId());
							pstmt.setString(4,merchantVO.getIndustryId());
							pstmt.setString(5,merchantVO.getStatus());
							pstmt.setString(6,merchantVO.getMatch());
							pstmt.setString(7,merchantVO.getUserId()); */
							
							merchantVOAUX.setName(displayTerms.getKeywords());
							merchantVOAUX.setMatch("1");
							merchantVOAUX.setUserId(String.valueOf(PortalUtil.getUserId(request)));
							
							/* listMerchants = Methods.listAllMerchantsFilter(merchantVOAUX);
							results = new ArrayList<MerchantVO>(ListUtil.subList(listMerchants, searchContainer.getStart(), searchContainer.getEnd()));
							searchContainer.setTotal(listMerchants.size());
							searchContainer.setResults(results); */
							
							/* System.out.println("listMerchants.size(): " + listMerchants.size()); */
							
							/* String searchkeywords = displayTerms.getKeywords(); */
							/* System.out.println("searchkeywords: " + searchkeywords);
							String numbesearchkeywords = Validator.isNumber(searchkeywords) ? searchkeywords : String.valueOf(0);
							System.out.println("numbesearchkeywords: " + numbesearchkeywords);
							System.out.println("nameMerchant ... " + nameMerchant);
							System.out.println("status ... " + status); */
						}
						System.out.println("displayTerms.isAndOperator()? ... " + displayTerms.isAndOperator());
						System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ... ");	
					
						listMerchants = Methods.listAllMerchantsFilter(merchantVOAUX);
						results = new ArrayList<MerchantVO>(ListUtil.subList(listMerchants, searchContainer.getStart(), searchContainer.getEnd()));
						searchContainer.setTotal(listMerchants.size());
						searchContainer.setResults(results);
						session.setAttribute("results", results);
						/* listMerchants = Methods.orderMerchant(listMerchants,orderByCol,orderByType);
						results = new ArrayList<MerchantVO>(ListUtil.subList(listMerchants, searchContainer.getStart(), searchContainer.getEnd()));
						total = listMerchants.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results); */
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