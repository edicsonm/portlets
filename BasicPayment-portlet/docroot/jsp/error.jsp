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
<%

	TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
%>
<aui:form action="" method="post">
	<div class="tabla"> 
		<div id="msgid"></div>
	</div>
</aui:form>

<script type="text/javascript">
	
$("#msgid").attr("class", "information red");	
$("#msgid").html("Sending payment information to the merchant. Please wait.");
$.ajax({
	url: "http://192.168.0.10:8080/MerchantApp/answerError.jsp",
	/* url: "http://merchant.billingbuddy.com/Merchant/answerProcessor.jsp", */
	type: "GET",
    dataType: "html",
   /*  async: false, */
     data: { status: "<%=transactionVO.getStatus()%>", message:"<%=transactionVO.getMessage()%>", data: "<%=transactionVO.getData()%>", orderNumber:<%=transactionVO.getOrderNumber()%>},
    success: function (response) {
    	$("#msgid").attr("class", "information orange");
    	$("#msgid").html("The merchant has received the response. You can close this window." + response);
    },
    error: function(jqXHR, textStatus, errorThrown) {
    	$("#msgid").attr("class", "information red");	
    	$("#msgid").html("An error occurred with number " + jqXHR.status);
    	/* alert("Error " + jqXHR.status + ":"+textStatus);
        alert("Error " + jqXHR.responseText ); */
    },
    fail: function(jqXHR, textStatus ) {
		alert( "Request failed " + textStatus +"-->"+jqXHR.status);
	}
});	 
	
</script>
