<%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%>
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
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util"%>

<%@taglib uri="http://www.billingbuddy.com/.com/bbtlds" prefix="Utils" %>

<aui:script use="aui">
	enableField = function(){
		A.one("#<portlet:namespace/>refundAmount").set('disabled', false);
	}
</aui:script>

<portlet:resourceURL var="ajaxResourceUrl"/>

<portlet:renderURL var="showjspURL">
	<portlet:param name="jspPage" value="/jsp/refunds.jsp" />
</portlet:renderURL>

<fmt:setBundle basename="Language"/>
<liferay-ui:success key="refundSuccessful" message="label.success" />
<liferay-ui:error key="ProcessorMDTR.processRefound.RefundDAOException" message="error.ProcessorMDTR.processRefound.RefundDAOException" />
<portlet:defineObjects />

<%
	ChargeVO chargeVO = (ChargeVO)session.getAttribute("chargeVO");
	
	String orderByColAnteriorRefunds = (String)session.getAttribute("orderByColRefunds");
	String orderByTypeAnteriorRefunds = (String)session.getAttribute("orderByTypeRefunds");
	
	String orderByColRefunds = "id";
	String orderByTypeRefunds = "asc";
	
	if(renderRequest != null){
		orderByColRefunds = (String)renderRequest.getParameter("orderByColRefunds");
		orderByTypeRefunds = (String)renderRequest.getAttribute("orderByTypeRefunds");
	
		if(orderByTypeRefunds == null){
			orderByTypeRefunds = "asc";
		}
		
		if(orderByColRefunds == null){
			orderByColRefunds = "id";
		}else if(orderByColRefunds.equalsIgnoreCase(orderByColAnteriorRefunds)){
			if (orderByTypeAnteriorRefunds.equalsIgnoreCase("asc")){
				orderByTypeRefunds = "desc";
			}else{
				orderByTypeRefunds = "asc";
			}
		}else{
			orderByTypeRefunds = "asc";
		}
	}
	ArrayList<RefundVO> listRefunds = (ArrayList<RefundVO>)session.getAttribute("listRefunds");
	if(listRefunds == null) listRefunds = new ArrayList<RefundVO>();
	session.setAttribute("orderByColRefunds", orderByColRefunds);
	session.setAttribute("orderByTypeRefunds", orderByTypeRefunds);
	int refunded = Integer.parseInt(chargeVO.getAmount()) - Integer.parseInt(chargeVO.getAmountRefunded());
	pageContext.setAttribute("refunded", refunded);
%>

<fieldset class="fieldset">
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
			<p id="sub-legend" class="description"><fmt:message key="label.paymentDetails"/></p>
			<div id="contenedor">
				<%-- <c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"BillingBuddyAdministrator\", true) %>">
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.merchant"/></dt>
								<dd><c:out value="${chargeVO.transactionVO.merchantVO.name}"/></dd>
							</dl>
						</div>
					</div>
				</c:if> --%>
				
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.transactionNumber"/></dt>
							<dd><c:out value="${chargeVO.transactionId}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.dateOrderPlaced"/></dt>
							<dd><c:out value="${Utils:formatDate(3,chargeVO.creationTime,7)}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.currency"/></dt>
							<dd><c:out value="${Utils:toUpperCase(chargeVO.currency)}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.transactionAmount"/></dt>
							<dd><c:out value="${Utils:stripeToCurrency(chargeVO.amount, chargeVO.currency)}"/></dd>
						</dl>
					</div>
				</div>
			</div>
			
			<p id="sub-legend" class="description"><fmt:message key="label.cardDetails"/></p>
			<div id="contenedor">
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.cardType"/></dt>
							<dd><c:out value="${chargeVO.cardVO.brand}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.paymentMethod"/></dt>
							<dd><c:out value="${fn:toUpperCase(fn:substring(chargeVO.cardVO.funding, 0, 1))}${fn:toLowerCase(fn:substring(chargeVO.cardVO.funding, 1,fn:length(chargeVO.cardVO.funding)))}"/></dd>
						</dl>
					</div>
				</div>
			</div>
			
			<p id="sub-legend" class="description"><fmt:message key="label.refoundHistory"/></p>
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="<%= listRefunds.size() %>">
			   <liferay-ui:search-container-results  total="<%=listRefunds.size() %>" results="<%=ListUtil.subList(listRefunds, searchContainer.getStart(), searchContainer.getEnd()) %>">
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.RefundVO" rowVar="posi" indexVar="indiceTable" keyProperty="id" modelVar="refundVO">
				<liferay-ui:search-container-column-text name="label.currency" value="${Utils:toUpperCase(refundVO.currency)}" orderable="false" orderableProperty="currency" />
				<liferay-ui:search-container-column-text name="label.refundAmount" value="${Utils:stripeToCurrency(refundVO.amount, refundVO.currency)}" orderable="false" orderableProperty="amount" />
				<liferay-ui:search-container-column-text name="label.dateRefund" value="${Utils:formatDate(3,refundVO.creationTime,7)}"  orderable="false" orderableProperty="creationTime" />
				<liferay-ui:search-container-column-text name="Reason" property="reason" orderable="false" orderableProperty="reason" />
			   </liferay-ui:search-container-row>
			   <liferay-ui:search-iterator paginate="false" />
			</liferay-ui:search-container>
		</div>
	</div>
</fieldset>
