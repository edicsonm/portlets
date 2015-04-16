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
window.showDetails = 
    function(url) {
        var portletURL="<%=themeDisplay.getURLManageSiteMemberships().toString()%>";
        var dialog = new A.Modal(
            {
            	bodyContent: 'Modal body',
                centered: true,
                modal: true,
                resizable: false,
                render: '#modal',
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
    
</aui:script>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<portlet:actionURL name="processRefund" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="popupURL" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
	<portlet:param name="jspPage" value="/jsp/cardDetails.jsp"/>
</portlet:renderURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLRefunds" />
<%
	
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
	
	/* ArrayList<RefundVO> listRefunds = (ArrayList<RefundVO>)session.getAttribute("listRefunds");
	if(listRefunds == null) listRefunds = new ArrayList<RefundVO>();
	session.setAttribute("orderByColRefunds", orderByColRefunds);
	session.setAttribute("orderByTypeRefunds", orderByTypeRefunds);
	int refunded = Integer.parseInt(chargeVO.getAmount()) - Integer.parseInt(chargeVO.getAmountRefunded());
	pageContext.setAttribute("refunded", refunded); */
	
%>

<aui:form action="<%= submitForm %>" method="post">
	<%-- <a onclick="use()" href="#">${Utils:printCardNumber(cardVO.number)}</a> --%>
	<!-- <button id="showModal" class="btn btn-primary" onclick="use();" >Show Modal</button> -->
	<div class="yui3-skin-sam">
	    <div id="modal"></div>
	</div>

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
				
				<%-- <div id="contenidos">
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
			</div> --%>
			
			<p id="sub-legend" class="description"><fmt:message key="label.cards"/></p>
			<!-- <div class="yui3-skin-sam">
			  <div id="modal"></div>
			</div> -->
			<liferay-ui:search-container  emptyResultsMessage="label.empty">
			   <liferay-ui:search-container-results >
			      <%
					total = listCardsByCustomer.size();
					pageContext.setAttribute("results", listCardsByCustomer);
					pageContext.setAttribute("total", total);
					session.setAttribute("results", results);
			       %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.CardVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="cardVO">
				
				<portlet:renderURL var="popupURLCardDetails" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
					<portlet:param name="jspPage" value="/jsp/cardDetails.jsp"/>
					<portlet:param name="idCard" value="<%=cardVO.getId()%>"/>
					<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
				</portlet:renderURL>
				
				<liferay-ui:search-container-column-text name="label.cardNumber">
					<a onclick="showDetails('<%= popupURLCardDetails.toString() %>')" href="#">${Utils:printCardNumber(cardVO.number)}</a>
				</liferay-ui:search-container-column-text>
				<%-- <liferay-ui:search-container-column-text name="label.cardNumber" value="${Utils:printCardNumber(cardVO.number)}" orderable="false" target="#"  href="aler('<%= popupURLCardDetails.toString() %>')"/> --%>
				<liferay-ui:search-container-column-text name="label.brand" value="${Utils:printString(cardVO.brand)}" orderable="false"/>
				<liferay-ui:search-container-column-text name="label.expire" value="${cardVO.expMonth} - ${cardVO.expYear}"  orderable="false"/>
			   </liferay-ui:search-container-row>
			   <liferay-ui:search-iterator searchContainer="<%= searchContainer %>"  paginate="false" />
			</liferay-ui:search-container>
			
			<%-- <div id="contenedor">
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
			</div> --%>
			
			<p id="sub-legend" class="description"><fmt:message key="label.refoundDetails"/></p>
			<%-- <div id="contenedor">
				<div id="contenidos">
					<div id="columna1-3">
						<div class="control-group">
							<aui:input label="label.reason" type="textarea" showRequiredLabel="false" required="true" name="reason" value="${chargeVO.refundVO.reason}"/>
						</div>
					</div>
					<div id="columna2-3">
						<dl class="property-list">
							<dt><fmt:message key="label.currency"/></dt>
							<dd><c:out value="${Utils:toUpperCase(chargeVO.currency)}"/></dd>
						</dl>
					</div>
					<div id="columna3-3">
						<div class="control-group">
							<aui:input label="label.refundAmount" showRequiredLabel="false" required="true" id="refundAmount" name="refundAmount" disabled="false" value="${Utils:stripeToCurrency(refunded, chargeVO.currency)}">
								<aui:validator name="custom" errorMessage="error.decimalNumber">
									function (val, fieldNode, ruleValue) {
										var result = ( /^(\d+|\d+.\d{1,2})$/.test(val));
										return result;
									}
								</aui:validator>
							</aui:input>
						</div>
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
							<dt><fmt:message key="label.refunded"/></dt>
							<dd><c:out value="${Utils:stripeToCurrency(chargeVO.amountRefunded, chargeVO.currency)}"/></dd>
						</dl>
					</div>
				</div> --%>
			</div>
			
			<p id="sub-legend" class="description"><fmt:message key="label.refoundHistory"/></p>
			<%-- <liferay-ui:search-container emptyResultsMessage="label.empty" delta="<%= listRefunds.size() %>">
			
			<liferay-ui:search-container delta="<%= listRefunds.size() %>" emptyResultsMessage="label.empty">
			   <liferay-ui:search-container-results>
			      <%
			      results= ListUtil.subList(listRefunds, searchContainer.getStart(), searchContainer.getEnd());
			      total= listRefunds.size();
			      pageContext.setAttribute("results", results);
			      pageContext.setAttribute("total", total);	
			      
			      /* listRefunds = Methods.orderRefunds(listRefunds,orderByColRefunds,orderByTypeRefunds);
					results = ListUtil.subList(listRefunds, searchContainer.getStart(), searchContainer.getEnd());
					total = listRefunds.size();
					pageContext.setAttribute("results", results);
					pageContext.setAttribute("total", total); */
			       %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.RefundVO" rowVar="posi" indexVar="indiceTable" keyProperty="id" modelVar="refundVO">
				<liferay-ui:search-container-column-text name="label.currency" value="${Utils:toUpperCase(refundVO.currency)}" orderable="false" orderableProperty="currency" />
				<liferay-ui:search-container-column-text name="label.refundAmount" value="${Utils:stripeToCurrency(refundVO.amount, refundVO.currency)}" orderable="false" orderableProperty="amount" />
				<liferay-ui:search-container-column-text name="label.dateRefund" value="${Utils:formatDate(3,refundVO.creationTime,7)}"  orderable="false" orderableProperty="creationTime" />
				<liferay-ui:search-container-column-text name="Reason" property="reason" orderable="false" orderableProperty="reason" />
			   </liferay-ui:search-container-row>
			   <liferay-ui:search-iterator paginate="false" />
			</liferay-ui:search-container> --%>
			
			<input type="button" id="addSystemSection" onclick="showDetails('<%= popupURL.toString() %>')" value="new-section"/>
			
			<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="processRefund" value="label.processRefund" />
	</div>
</fieldset>
</aui:form>