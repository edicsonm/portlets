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

<%-- <%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%> --%>

<portlet:defineObjects />
<liferay-theme:defineObjects />

<fmt:setBundle basename="Language"/>
<liferay-ui:error key="success" message="label.satisfactoryRegistration" />
<liferay-ui:error key="error" message="label.unsatisfactoryRegistration" />
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

<%-- <liferay-ui:message key="label.title"/> --%>
<aui:script use="aui-io-request,aui-node">
</aui:script>
<%
	Calendar calendar = new GregorianCalendar();
	Calendar cal = CalendarFactoryUtil.getCalendar();
	int initialYear = cal.get(Calendar.YEAR) + 1;
	TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
	MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
	
	
	transactionVO.setCardVO(new CardVO());
	transactionVO.getCardVO().setName("Edicson Morales");
	transactionVO.getCardVO().setNumber("4012888888881881");
	transactionVO.getCardVO().setCvv("123");
	transactionVO.getCardVO().setCustomerVO(new CustomerVO());
	transactionVO.getCardVO().getCustomerVO().setEmail("edicsonm@gmail.com");
	transactionVO.getCardVO().getCustomerVO().setPhoneNumber("6100000000");
	
	transactionVO.setBillingAddressCity("Sydney");
	transactionVO.setBillingAddressRegion("NSW");
	transactionVO.setBillingAddressPostal("2016");
	transactionVO.setBillingAddressCountry("AU");
	
%>

<portlet:actionURL var="savePayment" name="savePayment"/>
<aui:form action="<%= savePayment %>" method="post">
	<div id="content" class="tabla"> 
		<div class="section">
			<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.purchaseInformation"/></label>
					</div>
			</div>
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.merchantID"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${merchantID}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.orderNumber"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${orderNumber}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.currency"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${currency}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.transactionAmount"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${transactionAmount}"/>
				</div>
			</div>
			
		</div>
		<div id="transactionContent" class="tabla"> 
			<div class="section">
				<div class="fila">
					<label class="aui-field-label sub-title"><fmt:message key="label.cardInformation"/></label>
				</div>
				
				<div class="fila">
					<div class="columna">
						<aui:input label="label.name" showRequiredLabel="false" required="true" name="name" value="${transactionVO.cardVO.name}"/>
					</div>
				</div>
				<div class="fila">
					<div class="columna">
						<aui:input label="label.email" showRequiredLabel="false" required="true" name="email" value="${transactionVO.cardVO.customerVO.email}">
							<aui:validator name="email"/>
						</aui:input>
					</div>
				</div>
				<div class="fila">
					<div class="columna">
						<aui:input label="label.phoneNumber" showRequiredLabel="false" required="true" name="phoneNumber" value="${transactionVO.cardVO.customerVO.phoneNumber}">
							<aui:validator name="digits"/>
						</aui:input>
					</div>
				</div>
				<div class="fila">
					<div class="columna">
						<aui:input label="label.cardNumber" showRequiredLabel="false" required="true" name="cardNumber" value="${transactionVO.cardVO.number}">
						  	<aui:validator name="digits"/>
						  	<aui:validator name="rangeLength" errorMessage="You must imput a number between 16 and 20 digits">[16,20]</aui:validator>
						 </aui:input>
						  
					</div>
				</div>
				<div class="fila">
					<div class="columna">
						<aui:select name="expirationMonth" label="label.expirationMonth">
							<c:forEach var="i" begin="1" end="12">
								<aui:option label="${i}" value="${i}"/> 
							</c:forEach>
						</aui:select>
						<%-- <aui:input label="label.expirationMonth" showRequiredLabel="false" required="true" name="expirationMonth" value="${basicPaymentRequestModel.email}"/> --%>
					</div>
				</div>
				<div class="fila">
					<div class="columna">
						<aui:select name="expirationYear" label="label.expirationYear">
							<c:forEach var="i" begin="<%= initialYear%>" end="<%= initialYear + 15%>">
								<aui:option label="${i}" value="${i}"/> 
							</c:forEach>
						</aui:select>
						<%-- <aui:input label="label.expirationYear" showRequiredLabel="false" required="true" name="expirationYear" value="${basicPaymentRequestModel.email}"/> --%>
					</div>
				</div>
				<div class="fila">
					<div class="columna">
						<aui:input label="label.securityCode" showRequiredLabel="false" size="3"  type="text" required="true" name="securityCode" value="${transactionVO.cardVO.cvv}">
							<aui:validator name="digits"/>
							<aui:validator name="minLength" errorMessage="You must imput a number with 3 digits">3</aui:validator>
							<aui:validator name="maxLength" errorMessage="You must imput a number with 3 digits">3</aui:validator>
						</aui:input>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="fila">
					<label class="aui-field-label sub-title"><fmt:message key="label.billingAddressInformation"/></label>
				</div>
				
				<div class="fila">
					<div class="columna">
						<aui:input label="label.country" showRequiredLabel="false" required="true" name="country" value="${transactionVO.billingAddressCountry}">
							<aui:validator name="alpha"/>
							<aui:validator name="minLength" errorMessage="You must imput a code with 2 characters">2</aui:validator>
							<aui:validator name="maxLength" errorMessage="You must imput a code with 2 characters">2</aui:validator>
						</aui:input>
					</div>
				</div>
				
				<div class="fila">
					<div class="columna">
						<aui:input label="label.region" showRequiredLabel="false" required="true" name="region" value="${transactionVO.billingAddressRegion}">
							<aui:validator name="alpha" />
						</aui:input>
					</div>
				</div>
				
				<div class="fila">
					<div class="columna">
						<aui:input label="label.city" showRequiredLabel="false" required="true" name="city" value="${transactionVO.billingAddressCity}">
							<aui:validator name="alpha" />
						</aui:input>
					</div>
				</div>
				
				<div class="fila">
					<div class="columna">
						<aui:input label="label.postalCode" showRequiredLabel="false" required="true" name="postalCode" value="${transactionVO.billingAddressPostal}">
							<aui:validator name="digits"/>
						</aui:input>
					</div>
				</div>
				
				<div class="fila">
					<div class="columna">
						<aui:button type="submit" name="Name" value="label.save" />
						<%-- <aui:button type="button" name="Name" onClick="updateOpener('This a message from BillingBuddy')" value="label.sendMessage" /> --%>
					</div>
				</div>
			</div>
		</div>
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
	/*jsonpCallback: "metodo2",*/
	success: function (response) {				
		$("#msgid").attr("class", "information orange");
    	$("#msgid").html("The merchant has received the payment at "+response.date+". You can close this window." + response);
    }, 
    error: function(jqXHR, textStatus, errorThrown) {
    	$("#msgid").attr("class", "information red");	
    	$("#msgid").html("An error occurred with number " + jqXHR.status);
    	alert("Error " + jqXHR.status + ":"+textStatus);
        alert("Error " + jqXHR.responseText );
    },
    fail: function(jqXHR, textStatus ) {
		alert( "Request failed " + textStatus +"-->"+jqXHR.status);
	}
});

<%-- Esta es la version que estab funcionando-- $.ajax({
	/* url: "http://192.168.0.10:8080/MerchantApp/answerError.jsp", */
	/* url: "http://merchant.billingbuddy.com/Merchant/answerProcessor.jsp", */
	url: "<%=merchantVO.getMerchantConfigurationVO().getUrlDeny()%>",
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
});	  --%>
	
</script>
