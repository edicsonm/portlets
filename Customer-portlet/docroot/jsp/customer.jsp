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

<fmt:setBundle basename="Language"/>
<liferay-ui:success key="refundSuccessful" message="label.success" />

<%-- <liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException" message="error.ProcessorMDTR.processRefound.InvalidRequestException" />
<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException.1" message="error.ProcessorMDTR.processRefound.InvalidRequestException.1" />
<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException.2" message="error.ProcessorMDTR.processRefound.InvalidRequestException.2" />
<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException.3" message="error.ProcessorMDTR.processRefound.InvalidRequestException.3" />
<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException.4" message="error.ProcessorMDTR.processRefound.InvalidRequestException.4" />
<liferay-ui:error key="ProcessorMDTR.processRefound.RefundDAOException" message="error.ProcessorMDTR.processRefound.RefundDAOException" /> --%>

<portlet:defineObjects />

<aui:script use="aui-node,aui-base,aui-modal">
window.showDetailsCard = 
    function(url) {
        var portletURL="<%=themeDisplay.getURLManageSiteMemberships().toString()%>";
        var dialog = new A.Modal(
            {
            	bodyContent: 'Modal body',
                centered: true,
                modal: true,
                resizable: false,
                render: '#modalCards',
                width: 450,
                height: 300
            }
        ).plug(
            A.Plugin.DialogIframe,
                {
                    uri: url
                }
        ).render();
    }
    
window.showDetailsTransaction = 
    function(url) {
        var portletURL="<%=themeDisplay.getURLManageSiteMemberships().toString()%>";
        var dialog = new A.Modal(
            {
            	bodyContent: 'Modal body',
                centered: true,
                modal: true,
                resizable: false,
                render: '#modalCards',
                width: 550,
                height: 500
            }
        ).plug(
            A.Plugin.DialogIframe,
                {
                    uri: url
                }
        ).render();
    }
    
</aui:script>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<portlet:actionURL name="processRefund" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<%-- <portlet:renderURL var="popupURLCard" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
	<portlet:param name="jspPage" value="/jsp/cardDetails.jsp"/>
</portlet:renderURL>


<portlet:renderURL var="popupURLTransaction" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
	<portlet:param name="jspPage" value="/jsp/transactionDetails.jsp"/>
</portlet:renderURL> --%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLTransactions">
	<portlet:param name="accion" value="renderURLTransactionsByDay"/>
	<portlet:param name="cardNumber" value="<%=cardNumber%>"/>
	<portlet:param name="brand" value="<%=brand%>"/>
	<portlet:param name="merchant" value="<%=merchant%>"/>
	<portlet:param name="countryCard" value="<%=countryCard%>"/>
	<portlet:param name="currency" value="<%=currency%>"/>
	<portlet:param name="lastCur" value="<%=ParamUtil.getString(request, \"cur\")%>"/>
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</liferay-portlet:renderURL>

<%
	String orderByColTransactions = ParamUtil.getString(request, "orderByColTransactions", "creationTime");
	String orderByTypeTransactions = ParamUtil.getString(request, "orderByTypeTransactions","desc");
	pageContext.setAttribute("orderByColTransactions", orderByColTransactions);
	pageContext.setAttribute("orderByTypeTransactions", orderByTypeTransactions); 

	/* PortletPreferences prefs = renderRequest.getPreferences();
	String indice = (String)prefs.getValue("indice", "Hello! Welcome to our portal."); */
	
	/* String indice = ParamUtil.getString(request, "indice");
	System.out.println("indice: " + indice);
	
	String orderNumber = ParamUtil.getString(request, "orderNumber");
	session.setAttribute("orderNumber", orderNumber);
	System.out.println("orderNumber en jsp: " + orderNumber);
	
	
	ArrayList<ChargeVO> resultsListCharge = (ArrayList<ChargeVO>)session.getAttribute("results");
	ChargeVO chargeVO = (ChargeVO)resultsListCharge.get(Integer.parseInt(indice));
	pageContext.setAttribute("chargeVO", chargeVO);
	session.setAttribute("chargeVO", chargeVO);
	session.setAttribute("indice", indice); */
	
	MerchantCustomerVO merchantCustomerVO = (MerchantCustomerVO)session.getAttribute("merchantCustomerVO");
	
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
	
	ArrayList<CardVO> listCardsByCustomer = (ArrayList<CardVO>)session.getAttribute("listCardsByCustomer");
	if(listCardsByCustomer == null) listCardsByCustomer = new ArrayList<CardVO>();
	
	ArrayList<TransactionVO> listTransactionsByCustomer = (ArrayList<TransactionVO>)session.getAttribute("listTransactionsByCustomer");
	if(listTransactionsByCustomer == null) listTransactionsByCustomer = new ArrayList<TransactionVO>();
	
	/* ArrayList<RefundVO> listRefunds = (ArrayList<RefundVO>)session.getAttribute("listRefunds");
	if(listRefunds == null) listRefunds = new ArrayList<RefundVO>();
	session.setAttribute("orderByColRefunds", orderByColRefunds);
	session.setAttribute("orderByTypeRefunds", orderByTypeRefunds);
	int refunded = Integer.parseInt(chargeVO.getAmount()) - Integer.parseInt(chargeVO.getAmountRefunded());
	pageContext.setAttribute("refunded", refunded); */
	
%>
<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLCards">
	<portlet:param name="accion" value="renderURLCards"/>
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</liferay-portlet:renderURL>

<%-- <liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLTransactions">
	<portlet:param name="accion" value="renderURLTransactions"/>
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</liferay-portlet:renderURL> --%>

<aui:form method="post">
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.customer"/> </span>
	</legend>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
			<p id="sub-legend" class="description"><fmt:message key="label.customerDetails"/></p>
			<div id="contenedor">
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.email"/></dt>
							<dd><c:out value="${merchantCustomerVO.merchantVO.name}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.createTime"/></dt>
							<dd><c:out value="${Utils:formatDate(3,merchantCustomerVO.customerVO.createTime,7)}"/></dd>
						</dl>
					</div>
				</div>
			</div>
			
			<p id="sub-legend" class="description"><fmt:message key="label.cards"/></p>
			<div class="yui3-skin-sam">
			  <div id="modalCards"></div>
			</div>
			<liferay-ui:search-container curParam="Cards" deltaParam="deltaCards" delta="2" iteratorURL="<%=renderURLCards%>" emptyResultsMessage="label.empty">
			   <liferay-ui:search-container-results resultsVar="resultsCards" totalVar="totalCards" results="<%= new ArrayList(ListUtil.subList(listCardsByCustomer, searchContainer.getStart(), searchContainer.getEnd()))%>" total="<%=listCardsByCustomer.size() %>"/>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.CardVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="cardVO">
				
				<portlet:renderURL var="popupURLCardDetails" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
					<portlet:param name="jspPage" value="/jsp/cardDetails.jsp"/>
					<portlet:param name="idCard" value="<%=cardVO.getId()%>"/>
					<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
				</portlet:renderURL>
				
				<liferay-ui:search-container-column-text name="label.iterator" value="${cardVO.id}" orderable="false"/>
				<liferay-ui:search-container-column-text name="label.cardNumber">
					<a onclick="showDetailsCard('<%= popupURLCardDetails.toString() %>')" href="#">${Utils:printCardNumber(cardVO.number)}</a>
				</liferay-ui:search-container-column-text>
				<liferay-ui:search-container-column-text name="label.brand" value="${Utils:printString(cardVO.brand)}" orderable="false"/>
				<liferay-ui:search-container-column-text name="label.expire" value="${cardVO.expMonth} - ${cardVO.expYear}"  orderable="false"/>
			   </liferay-ui:search-container-row>
			   <liferay-ui:search-iterator />
			</liferay-ui:search-container>
			
			
			
			<p id="sub-legend" class="description"><fmt:message key="label.transactions"/></p>
			<div class="yui3-skin-sam">
			  <div id="modalTransactions"></div>
			</div>
			<liferay-ui:search-container curParam="Transactions" deltaParam="deltaTransactions" delta="5" iteratorURL="<%=renderURLTransactions%>" emptyResultsMessage="label.empty">
				<liferay-ui:search-container-results resultsVar="resultsTransactions" totalVar="totalTransactions" results="<%= new ArrayList(ListUtil.subList(listTransactionsByCustomer, searchContainer.getStart(), searchContainer.getEnd()))%>" total="<%=listTransactionsByCustomer.size() %>"/>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.TransactionVO" rowVar="posiTransaction" indexVar="indiceTransaction" keyProperty="id" modelVar="transactionVO">
				
				<portlet:renderURL var="popupURLTransactionDetails" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
					<portlet:param name="jspPage" value="/jsp/transactionDetails.jsp"/>
					<portlet:param name="idTransaction" value="<%=transactionVO.getId()%>"/>
					<portlet:param name="indiceTransaction" value="<%=String.valueOf(indiceTransaction)%>"/>
				</portlet:renderURL>
				
				<liferay-ui:search-container-column-text name="label.iterator" value="${transactionVO.id}" orderable="false"/>
				<liferay-ui:search-container-column-text name="label.transactionAmount">
					<a onclick="showDetailsTransaction('<%= popupURLTransactionDetails.toString() %>')" href="#">${Utils:stripeToCurrency(transactionVO.chargeVO.amount, transactionVO.chargeVO.currency)}</a>
				</liferay-ui:search-container-column-text>
				<liferay-ui:search-container-column-text name="label.date" value="${Utils:formatDate(3,transactionVO.creationTime,7)}" orderable="true" orderableProperty="creationTime"/>
				<liferay-ui:search-container-column-text name="label.cardNumber" value="${Utils:printCardNumber(transactionVO.cardVO.number)}" orderable="false"/>
			   </liferay-ui:search-container-row>
			   <liferay-ui:search-iterator/>
			</liferay-ui:search-container>
			
			<p id="sub-legend" class="description"><fmt:message key="label.refoundDetails"/></p>
			</div>
			
			<p id="sub-legend" class="description"><fmt:message key="label.refoundHistory"/></p>
			<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="processRefund" value="label.processRefund" />
	</div>
</fieldset>
</aui:form>