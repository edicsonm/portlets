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

<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="com.liferay.util.ContentUtil"%>
<%@ page import="com.liferay.portal.kernel.util.StringUtil"%>

<%@ page import="com.liferay.portal.kernel.mail.MailMessage"%>
<%@ page import="com.liferay.mail.service.MailServiceUtil"%>
<%@ page import="javax.mail.internet.AddressException"%>

 
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<fmt:setBundle basename="Language"/>
<portlet:defineObjects />
<liferay-ui:success key="paymentSuccessful" message="label.satisfactoryRegistration" />
<%
	TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
	MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");	
	String cardNumber = CreditCard.hide(transactionVO.getCardVO().getNumber(), "X");
%>
<portlet:actionURL var="acceptPayment" name="acceptPayment"/>

<aui:form action="<%= acceptPayment %>" method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.purchaseInformation"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="details">
				<p id="sub-legend" class="description"><fmt:message key="label.log"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-1">
							<div id="msgid"></div>
						</div>
					</div>
				</div>
				
				<p id="sub-legend" class="description"><fmt:message key="label.paymentDetails"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-1">
							<dl class="property-list">
								<fmt:message key="label.orderNumberSumary">
							 		 <fmt:param value="${transactionVO.id}"/>
				 				</fmt:message>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-1">
							<dl class="property-list">
								<fmt:message key="label.orderText">
							 		 <fmt:param value="${transactionVO.cardVO.customerVO.email}"/>
				 				</fmt:message>
							</dl>
						</div>
					</div>					
				</div>
				
				<p id="sub-legend" class="description"><fmt:message key="label.billingAddress"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.country"/></dt>
								<dd><c:out value="${transactionVO.billingAddressCountry}"/></dd>
							</dl>
						</div>
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.region"/></dt>
								<dd><c:out value="${transactionVO.billingAddressRegion}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.city"/></dt>
								<dd><c:out value="${transactionVO.billingAddressCity}"/></dd>
							</dl>
						</div>
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.postalCode"/></dt>
								<dd><c:out value="${transactionVO.billingAddressPostal}"/></dd>
							</dl>
						</div>
					</div>
				</div>
				<p id="sub-legend" class="description"><fmt:message key="label.paymentDetails"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.name"/></dt>
								<dd><c:out value="${transactionVO.cardVO.name}"/></dd>
							</dl>
						</div>
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.cardNumber"/></dt>
								<dd><c:out value="<%=cardNumber%>"/></dd>
							</dl>
						</div>
					</div>
					
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.cardType"/></dt>
								<dd><c:out value="${transactionVO.cardVO.brand}"/></dd>
							</dl>
						</div>
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.paymentMethod"/></dt>
								<dd><c:out value="${transactionVO.cardVO.funding}"/></dd>
							</dl>
						</div>
					</div>
					
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.currency"/></dt>
								<dd><c:out value="${transactionVO.orderCurrency}"/></dd>
							</dl>
						</div>
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.totalOrderAmount"/></dt>
								<dd><c:out value="${transactionVO.orderAmount}"/></dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
		</div>
	</fieldset>
</aui:form>
<%
	if(transactionVO != null)	{
%>
	<script type="text/javascript">
		$("#msgid").attr("class", "information red");	
		$("#msgid").html("Sending payment information to the merchant. Please wait.");
		var URL = "<%=merchantVO.getMerchantConfigurationVO().getUrlApproved()%>";
		URL += "?jsoncallback=?";
		$.ajax({
			type: "GET",
			url: URL,
			dataType: "jsonp",
			contentType: "application/json",
			data: { approbationNumber: <%=transactionVO.getId()%>, orderNumber:<%=transactionVO.getOrderNumber()%>},
			success: function (response) {
				$("#msgid").attr("class", "alert alert-success");
	        	$("#msgid").html("The merchant has received the payment at "+  new Date(response.date) +".</br>The merchant has registered your payment with the number "+response.confirmationNumber+", save this number for future claims.</br>You can close this window.");
		    }, 
		    error: function(jqXHR, textStatus, errorThrown) {
	        	$("#msgid").attr("class", "alert alert-error");	
	        	$("#msgid").html("An error occurred with number " + jqXHR.status);
	        	alert("Error " + jqXHR.status + ":"+textStatus);
	            alert("Error " + jqXHR.responseText );
	        },
	        fail: function(jqXHR, textStatus ) {
				alert( "Request failed " + textStatus +":"+jqXHR.status);
			}
		});
	</script>
<%
	}
%>



