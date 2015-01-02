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
<aui:script use="aui">
	enableField = function(){
		/* document.<portlet:namespace />refundAmount.disabled=false; */
		/* alert("Valor: " + AUI().one("#<portlet:namespace/>refundAmount").val()); */
		A.one("#<portlet:namespace/>refundAmount").set('disabled', false);
	}
</aui:script>
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException" message="error.processorMDTR.processRefound.invalidRequestException" />
<portlet:defineObjects />
<%
	String indice = ParamUtil.getString(request, "indice");
	System.out.println("Indice: " + indice);
	ArrayList<ChargeVO> results = (ArrayList<ChargeVO>)session.getAttribute("results");
	ChargeVO chargeVO = (ChargeVO)results.get(Integer.parseInt(indice));
	pageContext.setAttribute("chargeVO", chargeVO);
	session.setAttribute("chargeVO", chargeVO);
	session.setAttribute("indice", indice);
%>
<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<portlet:actionURL name="processRefund" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<aui:form action="<%= submitForm %>" method="post">
	<div class="tabla">
			<%-- <div class="section">
				<div class="row">
					<div class="column1-1">
						<label class="order-number ">
							<fmt:message key="label.orderNumberSumary">
						 		 <fmt:param><c:out value="<%=chargeVO.getTransactionId()%>"/></fmt:param>
			 				</fmt:message>
			 			</label>
					</div>
				</div>
			</div> --%>
			<div class="section">
				<div class="row">
					<div class="column1-1">
						<label class="sub-title"><fmt:message key="label.title.refound"/></label>
					</div>
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.transactionNumber"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${chargeVO.transactionId}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.dateOrderPlaced"/></label>
					</div>
					<div class="column4-4">
						<c:out value="${chargeVO.creationTime}"/>
					</div>
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.currency"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${fn:toUpperCase(chargeVO.currency)}"/>
					</div>
					
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.transactionAmount"/></label>
					</div>
					<div class="column4-4">
						<c:out value="<%=Utilities.stripeToCurrency(chargeVO.getAmount(),chargeVO.getCurrency().toUpperCase()) %>"/>
					</div>
					
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.cardType"/></label>
					</div>
					<div class="column2-4">
						<c:out default="N/E" value="${chargeVO.cardVO.brand}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.paymentMethod"/></label>
					</div>
					<div class="column4-4">
						<c:out default="N/E" value="${fn:toUpperCase(fn:substring(chargeVO.cardVO.funding, 0, 1))}${fn:toLowerCase(fn:substring(chargeVO.cardVO.funding, 1,fn:length(chargeVO.cardVO.funding)))}"/>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="row">
					<div class="column1-1">
						<label class="sub-title"><fmt:message key="label.title.refound"/></label>
					</div>
				</div>
				<div class="row">
					<%-- <div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.reason"/></label>
					</div> --%>
					<div class="column1-2">
						<aui:input label="label.reason" type="textarea" showRequiredLabel="false" required="true" name="reason" value="${chargeVO.refundVO.reason}"/>
					</div>
					<%-- <div class="column2-2">
						<label class="aui-field-label"><fmt:message key="label.refundAmount"/></label>
					</div> --%>
					<div class="column2-2">
						<aui:input label="label.refundAmount" showRequiredLabel="false" required="true" id="refundAmount" name="refundAmount" disabled="true" value="<%=Utilities.stripeToCurrency(chargeVO.getAmount(),chargeVO.getCurrency().toUpperCase()) %>">
							<aui:validator name="number" />
						</aui:input>
						<span class="enableField"><a href="#" onclick="javascript:enableField()"><fmt:message key="label.enableField"/></a></span>
					</div>
				</div>
				<div class="row">
					<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
					<div class="column2-2">
						<aui:button type="submit" name="processRefund" value="label.processRefund" />
						<%-- <a href="#" onclick="javascript:submitForm()"><fmt:message key="label.processRefund"/></a> --%>
					</div>
					
				</div>
			</div>
		<%-- <div class="fila">
			<div class="columnaIzquierda">
				<label class="aui-field-label"><fmt:message key="label.transactionNumber"/></label>
			</div>
			<div class="columnaDerecha">
				<c:out value="${id}"/>
			</div>
		</div> --%>
	</div>
</aui:form>