<%-- <%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%> --%>
<%@page import="au.com.billingbuddy.vo.objects.SubscriptionVO"%>
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

<portlet:defineObjects />

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

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLCards">
	<portlet:param name="accion" value="renderURLCards"/>
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLRefunds">
	<portlet:param name="accion" value="renderURLRefunds"/>
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLSubscriptions">
	<portlet:param name="accion" value="renderURLSubscriptions"/>
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</liferay-portlet:renderURL>

<portlet:renderURL var="addSubscription" windowState="<%= LiferayWindowState.POP_UP.toString() %>">
	<portlet:param name="jspPage" value="/jsp/newSubscription.jsp" />
	<portlet:param name="accion" value="addSubscription"/>
	<%-- <portlet:param name="redirect" value="<%= currentURL %>" /> --%>
</portlet:renderURL>

<%-- <aui:script>
	YUI().use(
		  'aui-toggler',
		  function(Y) {
		    new Y.TogglerDelegate(
		      {
		        animated: true,
		        closeAllOnExpand: true,
		        container: '#myToggler',
		        content: '.content',
		        expanded: false,
		        header: '.header',
		        transition: {
		          duration: 0.2,
		          easing: 'cubic-bezier(0, 0.1, 0, 1)'
		        }
		      }
		    );
		  }
		);
</aui:script> --%>

<aui:script>
	Liferay.provide(
		window,
		'showDetailsCard',
		function(atr) {
			var instance = this;
			var url=atr;
				Liferay.Util.openWindow(
					{
						cache: false,
						dialog: {
							align: Liferay.Util.Window.ALIGN_CENTER,
							after: {
								render: function(event) {
									this.set('y', this.get('y') + 50);
								}
							},
							resizable: false,
							width: 450,
							height: 340
						},
						dialogIframe: {
							id: 'addCardIframe',
							uri: url
						},
						title: '<fmt:message key="label.cardDetails"/>',
						uri: url
					}
				);
		},
		['liferay-util-window']
	);
</aui:script>

<aui:script>
Liferay.provide(
	window,
	'showDetailsTransaction',
	function(atr) {
		var instance = this;
		var url=atr;
			Liferay.Util.openWindow(
				{
					cache: false,
					dialog: {
						align: Liferay.Util.Window.ALIGN_CENTER,
						after: {
							render: function(event) {
								this.set('y', this.get('y') + 50);
							}
						},
						resizable: false,
						width: 550,
						height: 500
					},
					dialogIframe: {
						id: 'addTransactionIframe',
						uri: url
					},
					title: '<fmt:message key="label.paymentDetails"/>',
					uri: url
				}
			);
	},
	['liferay-util-window']
);
</aui:script>

<aui:script>
Liferay.provide(
	window,
	'showDetailsRefund',
	function(atr) {
		var instance = this;
		var url=atr;
			Liferay.Util.openWindow(
				{
					cache: false,
					dialog: {
						align: Liferay.Util.Window.ALIGN_CENTER,
						after: {
							render: function(event) {
								this.set('y', this.get('y') + 50);
							}
						},
						resizable: false,
						width: 550,
						height: 500
					},
					dialogIframe: {
						id: 'addRefundIframe',
						uri: url
					},
					title: '<fmt:message key="label.refoundDetails"/>',
					uri: url
				}
			);
	},
	['liferay-util-window']
);
</aui:script>

<aui:script>
Liferay.provide(
	window,
	'addSubscription',
	function() {
		alert('ejecuta addSubscription 2');
		var instance = this;
		var url='<%=  addSubscription.toString() %>';
			Liferay.Util.openWindow(
				{
					cache: false,
					dialog: {
						align: Liferay.Util.Window.ALIGN_CENTER,
						after: {
							render: function(event) {
								this.set('y', this.get('y') + 50);
							}
						},
						width: 820
					},
					dialogIframe: {
						id: 'addDocumentIframe',
						uri: url
					},
					title: '<liferay-ui:message key="label.attachDocument"/>',
					uri: url
				}
			);
	},
	['liferay-util-window']
);
</aui:script>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<portlet:actionURL name="processRefund" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<%
	
	String orderByColTransactions = ParamUtil.getString(request, "orderByColTransactions", "creationTime");
	String orderByTypeTransactions = ParamUtil.getString(request, "orderByTypeTransactions","desc");
	pageContext.setAttribute("orderByColTransactions", orderByColTransactions);
	pageContext.setAttribute("orderByTypeTransactions", orderByTypeTransactions); 
	
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
	
	ArrayList<ChargeVO> listChargesRefundedByCustomer = (ArrayList<ChargeVO>)session.getAttribute("listChargesRefundedByCustomer");
	if(listChargesRefundedByCustomer == null) listChargesRefundedByCustomer = new ArrayList<ChargeVO>();
	
	ArrayList<SubscriptionVO> listSubscriptionsByCustomer = (ArrayList<SubscriptionVO>)session.getAttribute("listSubscriptionsByCustomer");
	if(listSubscriptionsByCustomer == null) listSubscriptionsByCustomer = new ArrayList<SubscriptionVO>();
	
%>

<aui:form method="post">

<%-- <div id="myToggler">
  <h4 class="header toggler-header-collapsed"><p id="sub-legend" class="description"><fmt:message key="label.cards"/></p></h4>
  	<div class="content toggler-content-collapsed">
  			<liferay-ui:search-container curParam="Cards" deltaConfigurable="true" totalVar="totalVarCards" deltaParam="deltaCards" delta="2" iteratorURL="<%=renderURLCards%>" emptyResultsMessage="label.empty">
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
  	</div>
  	
  <h4 class="header toggler-header-collapsed"><span>Animated</span> Option</h4>
  <p class="content toggler-content-collapsed">This option has been set to <span>true</span> so that toggle transitions will animate.</p>
  <h4 class="header toggler-header-collapsed"><span>Transition</span> Option</h4>
  <p class="content toggler-content-collapsed">This option controls duration of transition, easing type, as well as callback functions.</p>
  <h4 class="header toggler-header-collapsed"><span>closeAllOnExpand</span> Option</h4>
  <p class="content toggler-content-collapsed">This option has been set to <span>true</span> so that all other toggle switches will be set to off when one switch is toggled on.</p>
</div> --%>


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
			<liferay-ui:search-container curParam="Cards" deltaConfigurable="true" totalVar="totalVarCards" deltaParam="deltaCards" delta="2" iteratorURL="<%=renderURLCards%>" emptyResultsMessage="label.empty">
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
			<liferay-ui:search-container curParam="Transactions" deltaConfigurable="true" totalVar="totalVarTransactions" deltaParam="deltaTransactions" delta="5" iteratorURL="<%=renderURLTransactions%>" emptyResultsMessage="label.empty">
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
			
			<p id="sub-legend" class="description"><fmt:message key="label.subscriptions"/></p>
			<liferay-ui:search-container curParam="Subscriptions" deltaConfigurable="true" totalVar="totalVarSubscriptions" deltaParam="deltaSubscriptions" delta="2" iteratorURL="<%=renderURLSubscriptions%>" emptyResultsMessage="label.empty">
			   <liferay-ui:search-container-results resultsVar="resultsSubscriptions" totalVar="totalSubscriptions" results="<%= new ArrayList(ListUtil.subList(listSubscriptionsByCustomer, searchContainer.getStart(), searchContainer.getEnd()))%>" total="<%=listSubscriptionsByCustomer.size() %>"/>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.CardVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="cardVO">
				
				<portlet:renderURL var="popupURLSubscriptionsDetails" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
					<portlet:param name="jspPage" value="/jsp/subscriptionsDetails.jsp"/>
					<portlet:param name="idCard" value="<%=cardVO.getId()%>"/>
					<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
				</portlet:renderURL>
				
				<liferay-ui:search-container-column-text name="label.iterator" value="${cardVO.id}" orderable="false"/>
				<liferay-ui:search-container-column-text name="label.cardNumber">
					<a onclick="showDetailsSubscriptions('<%= popupURLSubscriptionsDetails.toString() %>')" href="#">${Utils:printCardNumber(cardVO.number)}</a>
				</liferay-ui:search-container-column-text>
				<liferay-ui:search-container-column-text name="label.brand" value="${Utils:printString(cardVO.brand)}" orderable="false"/>
				<liferay-ui:search-container-column-text name="label.expire" value="${cardVO.expMonth} - ${cardVO.expYear}"  orderable="false"/>
			   </liferay-ui:search-container-row>
			   <liferay-ui:search-iterator />
			</liferay-ui:search-container>
			
			<%-- <aui:button type="button" onClick="addSubscription();" name="createSubscription" value="label.createSubscription" /> --%>
			<button type="button" onclick="addSubscription();" class="btn btn-primary"><liferay-ui:message key="label.createSubscription"/></button>
			
			<p id="sub-legend" class="description"><fmt:message key="label.refunds"/></p>
			<liferay-ui:search-container curParam="Refunds" deltaConfigurable="true" totalVar="totalVarRefunds" deltaParam="deltaRefunds" delta="5" iteratorURL="<%=renderURLRefunds%>" emptyResultsMessage="label.empty">
				<liferay-ui:search-container-results resultsVar="resultsRefunds" totalVar="totalRefunds" results="<%= new ArrayList(ListUtil.subList(listChargesRefundedByCustomer, searchContainer.getStart(), searchContainer.getEnd()))%>" total="<%=listChargesRefundedByCustomer.size() %>"/>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.ChargeVO" rowVar="posiRefund" indexVar="indiceRefund" keyProperty="id" modelVar="chargeVO">
				
				<portlet:renderURL var="popupURLRefundDetails" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
					<portlet:param name="jspPage" value="/jsp/refundDetails.jsp"/>
					<portlet:param name="idCharge" value="<%=chargeVO.getId()%>"/>
					<portlet:param name="indiceRefund" value="<%=String.valueOf(indiceRefund)%>"/>
					<portlet:param name="accion" value="refundDetails"/>
					
				</portlet:renderURL>
				
				<liferay-ui:search-container-column-text name="label.iterator" value="${chargeVO.id}" orderable="false"/>
				<liferay-ui:search-container-column-text name="label.iterator" value="${chargeVO.transactionId}" orderable="false"/>
				<liferay-ui:search-container-column-text name="label.transactionAmount">
					<a onclick="showDetailsRefund('<%= popupURLRefundDetails.toString() %>')" href="#">${Utils:stripeToCurrency(chargeVO.amount, chargeVO.currency)}</a>
				</liferay-ui:search-container-column-text>
				
				<liferay-ui:search-container-column-text name="label.amountRefund" value="${Utils:stripeToCurrency(chargeVO.amountRefunded, chargeVO.currency)}" orderable="true" orderableProperty="amountRefunded"/>
				
				<liferay-ui:search-container-column-text name="label.date" value="${Utils:formatDate(3,chargeVO.creationTime,7)}" orderable="true" orderableProperty="creationTime"/>
				<liferay-ui:search-container-column-text name="label.cardNumber" value="${Utils:printCardNumber(chargeVO.cardVO.number)}" orderable="false"/>
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