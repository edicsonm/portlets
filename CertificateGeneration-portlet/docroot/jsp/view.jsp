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
<liferay-ui:success key="certificateGenerationSuccessfully" message="label.certificateGenerationSuccessfully" />
<liferay-ui:success key="certificateChangeSuccessfully" message="label.certificateChangeSuccessfully" />

<liferay-ui:error key="SecurityMDTR.updateStatusCertificate.CertificateDAOException.Certificate_BEFORE_UPDATE" message="error.SecurityMDTR.updateStatusCertificate.CertificateDAOException.Certificate_BEFORE_UPDATE" />

<% 
	/* session.removeAttribute("certificateVO");	 */
	String orderByColAnterior = (String)session.getAttribute("orderByCol");
	String orderByTypeAnterior = (String)session.getAttribute("orderByType");
	
	String orderByCol = (String)renderRequest.getParameter("orderByCol");
	String orderByType = (String)renderRequest.getAttribute("orderByType");
	
	if(orderByType == null){
		orderByType = "asc";
	}
	
	if(orderByCol == null){
		orderByCol = "id";
	}else if(orderByCol.equalsIgnoreCase(orderByColAnterior)) {
		if (orderByTypeAnterior.equalsIgnoreCase("asc")) {
			orderByType = "desc";
		}else{
			orderByType = "asc";
		}
	}else{
		orderByType = "asc";
	}	

	ArrayList<CertificateVO> listCertificates = (ArrayList<CertificateVO>)session.getAttribute("listCertificates");
	if(listCertificates == null) listCertificates = new ArrayList<CertificateVO>();
	String active = "Active";
	String inactive = "Inactive";
%>

<portlet:actionURL var="listMerchantsAndCountries" name="listMerchantsAndCountries"/>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form method="post">
	<div class="table">
		<div class="row">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listCertificates = Methods.orderCertificates(listCertificates,orderByCol,orderByType);
						results = ListUtil.subList(listCertificates, searchContainer.getStart(), searchContainer.getEnd());
						total = listCertificates.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.CertificateVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="certificateVO">
					
					<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewCertificateGeneration.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.merchant" property="merchantId" value="merchantId" orderable="true" orderableProperty="merchantId" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.commonName" property="commonName" value="commonName" orderable="false" orderableProperty="commonName"/>
					<liferay-ui:search-container-column-text name="label.creationTime" value="<%=Utilities.formatDate(certificateVO.getCreationTime()) %>" orderable="false" orderableProperty="creationTime"/>
					<%if(!certificateVO.getStatus().equalsIgnoreCase("1")) {%>
							<liferay-ui:search-container-column-text name="label.status" value="<%=active%>" orderable="false" orderableProperty="status"/>
					<%}else{%> 
							<liferay-ui:search-container-column-text name="label.status" value="<%=inactive%>" orderable="false" orderableProperty="status"/>
					<%}%>
					
					<liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							
							<portlet:actionURL var="editURL" name="changeStatus">
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="mvcPath" value="/jsp/view.jsp" />
							</portlet:actionURL>
							<%if(!certificateVO.getStatus().equalsIgnoreCase("1")) {%>
									<liferay-ui:icon onClick="return confirm('Are you sure do you want to change this certificate status?')" image="edit" message="label.inactivate"  url="<%=editURL.toString()%>" />
							<%}else{%> 
									<liferay-ui:icon onClick="return confirm('Are you sure do you want to change this certificate status?')" image="edit" message="label.activate" url="<%=editURL.toString()%>" />
							<%}%>
							<%-- <liferay-ui:icon image="edit" message="label.edit" url="<%=editURL.toString()%>" /> --%>
							 
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</div>
		
		<div class="row">
			<div class="column1-2">
				<span class="newMerchant" >
					<a href="<%= listMerchantsAndCountries %>"><fmt:message key="label.newCertificateGeneration"/></a>
				</span>
			</div>
			<div class="column2-2">
			</div>
		</div>
		
	</div>
</aui:form>