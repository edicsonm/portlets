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
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.service.UserServiceUtil" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.PortletURL"%>

<%@ taglib uri="http://www.billingbuddy.com/.com/bbtlds" prefix="Utils" %>
<fmt:setBundle basename="Language"/>
<portlet:defineObjects />

<%
	String orderByCol = ParamUtil.getString(request, "orderByCol", "creationTime");
	String orderByType = ParamUtil.getString(request, "orderByType","desc");
	pageContext.setAttribute("orderByCol", orderByCol);
	pageContext.setAttribute("orderByType", orderByType);
	
	ArrayList<MerchantCustomerVO> listCustomersMerchant = (ArrayList)session.getAttribute("listCustomersMerchant");
	if(listCustomersMerchant == null) listCustomersMerchant = new ArrayList<MerchantCustomerVO>();
	
	session.setAttribute("orderByCol", orderByCol);
	session.setAttribute("orderByType", orderByType);
	session.setAttribute("page", "view.jsp");
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLCharges">
	<portlet:param name="accion" value="renderURLCustomers"/>
	<portlet:param name="email" value="<%=email%>"/>
</liferay-portlet:renderURL>

<portlet:actionURL name="listRefunds" var="listRefunds">
</portlet:actionURL>

<aui:form action="<%=listRefunds %>" method="post">
	
	<div class="tabla">
			<div class="fila">
				<liferay-ui:search-container orderByType="<%=orderByType %>" orderByCol="<%=orderByCol %>"  displayTerms="<%= new DisplayTerms(renderRequest) %>" emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLCharges%>">
					<liferay-ui:search-form  page="/jsp/customer_search.jsp" servletContext="<%= application %>"/>
				   <liferay-ui:search-container-results>
				      <%
						results = new ArrayList(ListUtil.subList(listCustomersMerchant, searchContainer.getStart(), searchContainer.getEnd()));
						total = listCustomersMerchant.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				       %>
					</liferay-ui:search-container-results>
					
					<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.MerchantCustomerVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="merchantCustomerVO">
						<portlet:actionURL var="rowURLCustomer" name="listCustomerInformation">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/customer.jsp" />
							<portlet:param name="customerID" value="<%=String.valueOf(merchantCustomerVO.getId())%>"/>
						</portlet:actionURL>
					
					<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"BillingBuddyAdministrator\", true) %>">
						<liferay-ui:search-container-column-text name="label.merchant" property="merchantVO.name" orderable="true" orderableProperty="merchantVO.name"/>
					</c:if>
					
					<liferay-ui:search-container-column-text name="label.customer" property="customerVO.email" orderable="true" orderableProperty="customerVO.email" href="<%= rowURLCustomer %>"/>
				   </liferay-ui:search-container-row>
				   <liferay-ui:search-iterator />
				</liferay-ui:search-container>
		</div>
	</div>
</aui:form>

