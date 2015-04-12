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

<liferay-ui:success key="refundSuccessful" message="label.success" />

<aui:script use="aui">

	YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />fromDateCharges',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
	
	YUI().use(
	  'aui-datepicker',
	  function(Y) {
	    new Y.DatePicker(
	      {
	        trigger: '#<portlet:namespace />toDateCharges',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
	
	showDetails = function(val){
		alert(val);
	}
</aui:script>
<%
	String orderByCol = ParamUtil.getString(request, "orderByCol", "creationTime");
	String orderByType = ParamUtil.getString(request, "orderByType","desc");
	pageContext.setAttribute("orderByCol", orderByCol);
	pageContext.setAttribute("orderByType", orderByType);
	
	/* com.liferay.portal.kernel.dao.search.SearchContainer<ChargeVO> searchContainer = null; */
	ArrayList<ChargeVO> listCharge = (ArrayList)session.getAttribute("listCharge");
	if(listCharge == null) listCharge = new ArrayList<ChargeVO>();
	
	ChargeVO chargeVOCharges = (ChargeVO)session.getAttribute("chargeVOCharges");
	if(chargeVOCharges == null) chargeVOCharges = new ChargeVO();
	
	session.setAttribute("orderByCol", orderByCol);
	session.setAttribute("orderByType", orderByType);
	session.setAttribute("page", "view.jsp");
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLCharges">
	<portlet:param name="accion" value="renderURLRefunds"/>
	<portlet:param name="cardNumber" value="<%=cardNumber%>"/>
	<portlet:param name="brand" value="<%=brand%>"/>
	<portlet:param name="merchant" value="<%=merchant%>"/>
	<portlet:param name="countryCard" value="<%=countryCard%>"/>
	<portlet:param name="currency" value="<%=currency%>"/>
</liferay-portlet:renderURL>

<portlet:actionURL name="listRefunds" var="listRefunds">
</portlet:actionURL>

<aui:form action="<%=listRefunds %>" method="post">
	<div class="tabla">
			<div class="fila">
				<liferay-ui:search-container orderByType="<%=orderByType %>" orderByCol="<%=orderByCol %>"  displayTerms="<%= new DisplayTerms(renderRequest) %>" emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLCharges%>">
					<div id="contenedor">
						<div id="contenidos">
							<div id=columna1-3>
								<div class="control-group">
									<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />fromDateTransactionsPicker">
									<aui:input onkeypress="return false;" value="<%= chargeVOCharges.getInitialDateReport()%>" label="label.from" helpMessage="help.from" showRequiredLabel="false" size="10" type="text" required="false" name="fromDateCharges">
										 <aui:validator name="date" />
									</aui:input>
								</div>
							</div>
						</div>
						
						<div id="columna2-3">
							<div class="control-group">
								<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace  />toDateTransactionsPicker">
									<aui:input onkeypress="return false;" value="<%= chargeVOCharges.getFinalDateReport()%>" label="label.to" helpMessage="help.to" showRequiredLabel="false" size="10" type="text" required="false" name="toDateCharges">
										 <aui:validator name="date" />
									</aui:input>
								</div>
							</div>
						</div>
						<div id="columna3-3">
							<div class="control-group">
								<liferay-ui:search-form  page="/jsp/charge_search.jsp" servletContext="<%= application %>"/>
								</div>
							</div>
						</div>
					</div>
				   <liferay-ui:search-container-results>
				      <%
						/* listCharge = Methods.orderCharges(listCharge,orderByCol,orderByType); */
						results = new ArrayList(ListUtil.subList(listCharge, searchContainer.getStart(), searchContainer.getEnd()));
						total = listCharge.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				       %>
					</liferay-ui:search-container-results>
					
					<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.ChargeVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="chargeVO">
						<portlet:actionURL var="rowURL" name="listRefund">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/refund.jsp" />
							<portlet:param name="orderNumber" value="<%=String.valueOf(chargeVO.getId())%>"/>
						</portlet:actionURL>
						
					<liferay-ui:search-container-column-text name="label.transactionAmount" value="${Utils:stripeToCurrency(chargeVO.amount,chargeVO.currency)}" orderable="true" orderableProperty="amount" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.date" value="${Utils:formatDate(3,chargeVO.creationTime,7)}" orderable="true" orderableProperty="creationTime" />
					<liferay-ui:search-container-column-text name="label.cardNumber" value="${Utils:printCardNumber(chargeVO.cardVO.number)}" orderable="false"/>
					
					<%-- <liferay-ui:search-container-column-text name="Charge" property="id" value="transactionId" orderable="true" orderableProperty="id" href="<%= rowURL %>"/> --%>
					<liferay-ui:search-container-column-text name="label.cardType" value="${Utils:printString(chargeVO.cardVO.brand)}" orderable="true" orderableProperty="cardVO.brand" />
					<liferay-ui:search-container-column-text name="label.currency" value="<%=chargeVO.getCurrency().toUpperCase()%>" orderable="true" orderableProperty="currency" />
					<liferay-ui:search-container-column-text name="label.refunded" value="${Utils:stripeToCurrency(chargeVO.amountRefunded, chargeVO.currency)}" orderable="false"/>
					
					<%-- <liferay-ui:search-container-column-text name="Last 4 Digits Card Number" property="cardVO.last4" orderable="true" orderableProperty="cardVO.last4" />
					<liferay-ui:search-container-column-text name="Brand" property="cardVO.brand" orderable="true" orderableProperty="cardVO.brand" />
					<liferay-ui:search-container-column-text name="Funding" property="cardVO.funding" orderable="true" orderableProperty="cardVO.funding" /> --%>
				   
				   </liferay-ui:search-container-row>
				   <liferay-ui:search-iterator />
				</liferay-ui:search-container>
		</div>
	</div>
</aui:form>