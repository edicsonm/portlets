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
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<fmt:setBundle basename="Language"/>
<portlet:defineObjects />
<liferay-ui:success key="paymentSuccessful" message="label.satisfactoryRegistration" />
<%
	TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
	String cardNumber = CreditCard.hide(transactionVO.getCardVO().getNumber(), "X");
%>
<portlet:actionURL var="acceptPayment" name="acceptPayment"/>
<aui:form action="<%= acceptPayment %>" method="post">
	<div class="tabla">
		<div class="tabla">
			<div class="section">
				<div class="row">
					<div class="column1-1">
						<label class="order-number ">
							<fmt:message key="label.orderNumberSumary">
						 		 <fmt:param value="${transactionVO.id}"/>
			 				</fmt:message>
			 			</label>
					</div>
				</div>
				<div class="row">
					<div class="column1-1">
						<label class="order-information">
							<fmt:message key="label.orderText">
						 		 <fmt:param value="${transactionVO.cardVO.customerVO.email}"/>
			 				</fmt:message>
			 			</label>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="row">
					<div class="column1-1">
						<label class="sub-title"><fmt:message key="label.billingAddress"/></label>
					</div>
				</div>
			
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.country"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${transactionVO.billingAddressCountry}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.region"/></label>
					</div>
					<div class="column4-4">
						<c:out value="${transactionVO.billingAddressRegion}"/>
					</div>
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.city"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${transactionVO.billingAddressCity}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.postalCode"/></label>
					</div>
					<div class="column4-4">
						<c:out value="${transactionVO.billingAddressPostal}"/>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.paymentDetails"/></label>
					</div>
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.name"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${transactionVO.cardVO.name}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.cardNumber"/></label>
					</div>
					<div class="column4-4">
						<c:out value="<%=cardNumber%>"/>
					</div>
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.cardType"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${transactionVO.cardVO.brand}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.paymentMethod"/></label>
					</div>
					<div class="column4-4">
						<c:out value="${transactionVO.cardVO.funding}"/>
					</div>
				</div>
			
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.currency"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${transactionVO.chargeVO.currency}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.totalOrderAmount"/></label>
					</div>
					<div class="column4-4">
						<c:out value="${transactionVO.chargeVO.amount}"/>
					</div>
				</div>
			</div>
		</div>
		<div id="msgid"></div>
	</div>
</aui:form>
<%
	if(transactionVO != null)	{
%>
	<script type="text/javascript">
		$("#msgid").attr("class", "information red");	
		$("#msgid").html("Sending payment information to the merchant. Please wait.");
		$.ajax({
	    	url: "http://merchant.billingbuddy.com/Merchant/answerProcessor.jsp",
	    	type: "GET",
	        dataType: "html",
	       /*  async: false, */
	        data: { approbationNumber: <%=transactionVO.getId()%>, orderNumber:<%=transactionVO.getOrderNumber()%>},
	        success: function (response) {
	        	$("#msgid").attr("class", "information orange");
	        	$("#msgid").html("The merchant has received the payment. You can close this window." + response);
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
	
		 <%-- $.ajax({
		    type : 'POST',
		    dataType: "html",
		    url  : 'http://192.168.0.2:8080/Merchant/answerProcessor.jsp',
		    async: false,
		    data: { approbationNumber: <%=transactionVO.getId()%>, orderNumber:<%=transactionVO.getOrderNumber()%>},
		    success: function(data) {
		    	$("#msgid").html("Successful Execution" + data);
		    },
		    error: function(jqXHR,textStatus, errorThrown ) {
		    	$("#msgid").html("An error occurred: " + jqXHR.responseText+ ":"+ jqXHR.responseXML+ ":"+textStatus+":"+errorThrown+":"+jqXHR.status+":"+jqXHR.statusCode);
		    }
		}); --%>
		
		<%-- var request = $.ajax({
			url: "http://192.168.0.2:8080/Merchant/answerProcessor.jsp",
			type: "POST",
			data: { approbationNumber: <%=transactionVO.getId()%>, orderNumber:<%=transactionVO.getOrderNumber()%> },
			dataType: "html"});
		
		request.done(function( msg ) {
				$( "#msgid" ).html( "Request OK " );
				alert( "Request OK: " + textStatus );
			});
		
		request.fail(function( jqXHR, textStatus ) {
				alert( "Request failed: " + textStatus +"-->"+jqXHR.status);
			}); --%>
			
		<%-- var jqxhr = $.ajax({
			url: "http://192.168.0.2:8080/Merchant/answerProcessor.jsp",
			type: "POST",
			data: { approbationNumber: <%=transactionVO.getId()%>, orderNumber:<%=transactionVO.getOrderNumber()%> },
			dataType: "html"})
		.done(function() {
			alert( "success" );
		})
		.fail(function( jqXHR, textStatus ) {
			alert( "error: " + textStatus +", " + jqXHR.responseText);
		})
		.always(function() {
			alert( "complete" );
		}); --%>
		
		
		<%-- $.ajax({
		    type : 'POST',
		    dataType: "html",
		    url  : 'http://192.168.0.2:8080/Merchant/answerProcessor.jsp',
		    async: false,
		    data: { approbationNumber: <%=transactionVO.getId()%>, orderNumber:<%=transactionVO.getOrderNumber()%>},
		    success: function(data) {
		    	$("#msgid").html("Successful Execution" + data);
		    },
		    error: function(jqXHR,textStatus, errorThrown ) {
		    	alert( "error: " + textStatus +", " + jqXHR.responseText);
		    }
		    	/* $("#msgid").html("An error occurred: " + jqXHR.responseText+ ":"+ jqXHR.responseXML+ ":"+textStatus+":"+errorThrown+":"+jqXHR.getResponseHeader()+":"+jqXHR.statusCode()); */
		    	/* $("#msgid").html("An error occurred: " + jqXHR.responseText+ ":"+ jqXHR.responseXML+ ":"+textStatus+":"+errorThrown+":"+jqXHR.status+":"+jqXHR.statusCode); */
		    }); --%>
		
		    <%-- var jqxhr = $.ajax({
		    		url  : "http://192.168.0.2:8080/Merchant/answerProcessor.jsp",
		    		type: "POST",
		    		data: { approbationNumber: <%=transactionVO.getId()%>, orderNumber:<%=transactionVO.getOrderNumber()%>}
		    		})
		    .done(function() {
		    alert( "success" );
		    })
		    .fail(function() {
		    alert( "error" );
		    })
		    .always(function() {
		    alert( "complete" );
		    }); --%>
		    
	</script>
<%
	}
%>



