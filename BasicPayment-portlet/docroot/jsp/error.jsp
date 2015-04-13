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
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.service.UserServiceUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.PortletURL"%>

<portlet:defineObjects />
<liferay-theme:defineObjects />

<fmt:setBundle basename="Language"/>
<liferay-ui:error key="success" message="label.satisfactoryRegistration" />
<liferay-ui:error key="error" message="label.unsatisfactoryRegistration" />

<liferay-ui:error key="ProcessorMDTR.validateMerchant.MerchantRestrictionDAOException.RestrictionByTransactions" message="error.ProcessorMDTR.validateMerchant.MerchantRestrictionDAOException.RestrictionByTransactions" />
<liferay-ui:error key="ProcessorMDTR.validateMerchant.MerchantRestrictionDAOException.RestrictionByAmount" message="error.ProcessorMDTR.validateMerchant.MerchantRestrictionDAOException.RestrictionByAmount" />
<liferay-ui:error key="ProcessorMDTR.validateMerchant.MerchantRestrictionDAOException.MisconfigureMerchant" message="error.ProcessorMDTR.validateMerchant.MerchantRestrictionDAOException.MisconfigureMerchant" />
<liferay-ui:error key="SecurityMDTR.validateSignature.NullPointerException" message="error.SecurityMDTR.validateSignature.NullPointerException" />
<liferay-ui:error key="SecurityMDTR.validateSignature.FileNotFoundException" message="error.SecurityMDTR.validateSignature.FileNotFoundException" />
<liferay-ui:error key="SecurityMDTR.validateSignature.DecoderException" message="error.SecurityMDTR.validateSignature.DecoderException" />
<liferay-ui:error key="ProcessorMDTR.creditCardFraudDetection.TransactionDAOException" message="error.ProcessorMDTR.creditCardFraudDetection.TransactionDAOException" />

<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.incorrect_number" message="error.ProcessorMDTR.chargePayment.CardException.incorrect_number" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.card_declined" message="error.ProcessorMDTR.chargePayment.CardException.card_declined" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.incorrect_cvc" message="error.ProcessorMDTR.chargePayment.CardException.incorrect_cvc" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.expired_card" message="error.ProcessorMDTR.chargePayment.CardException.expired_card" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.invalid_expiry_month" message="error.ProcessorMDTR.chargePayment.CardException.invalid_expiry_month" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.invalid_expiry_year" message="error.ProcessorMDTR.chargePayment.CardException.invalid_expiry_year" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.incorrect_zip" message="error.ProcessorMDTR.chargePayment.CardException.incorrect_zip" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.missing" message="error.ProcessorMDTR.chargePayment.CardException.missing" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardException.processing_error" message="error.ProcessorMDTR.chargePayment.CardException.processing_error" />
<liferay-ui:error key="ProcessorMDTR.chargePayment.CardDAOException" message="error.ProcessorMDTR.chargePayment.CardDAOException" />

<liferay-ui:error key="TransactionFacade.2" message="error.TransactionFacade.2" />

<%
	TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
	MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
%>
<aui:form action="" method="post">
	<div class="tabla"> 
		<div id="msgid"></div>
	</div>
</aui:form>

<script type="text/javascript">
$("#msgid").attr("class", "information red");	
$("#msgid").html("Sending payment information to the merchant. Please wait.");
var URL = "<%=merchantVO.getMerchantConfigurationVO().getUrlDeny()%>";
URL += "?jsoncallback=?";
$.ajax({
	type: "GET",
	url: URL,
	dataType: "jsonp",
	contentType: "application/json",
    data: { status: "<%=transactionVO.getStatus()%>", message:"<%=transactionVO.getMessage()%>", data: "<%=transactionVO.getData()%>", orderNumber:<%=transactionVO.getOrderNumber()%>},
    success: function (response) {
    	$("#msgid").attr("class", "information orange");
    	$("#msgid").html("The merchant has received the response. You can close this window.");
    },
    error: function(jqXHR, textStatus, errorThrown) {
    	$("#msgid").attr("class", "information red");	
    	$("#msgid").html("An error occurred with number " + jqXHR.status);
    },
    fail: function(jqXHR, textStatus ) {
		alert( "Request failed " + textStatus +":"+jqXHR.status);
	}
});	 
	
</script>
