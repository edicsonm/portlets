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

<portlet:defineObjects />
<liferay-ui:success key="paymentSuccessful" message="label.satisfactoryRegistration" />

<%
	TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
%>
<portlet:actionURL var="acceptPayment" name="acceptPayment"/>
<aui:form action="<%= acceptPayment %>" method="post">
	<div class="tabla">
			<div class="fila">
				<div class="columnaIzquierda">
				There has been a payment on our systems under the transaction number
				</div>
				<div class="columnaIzquierdaMargen">
				<%= transactionVO != null && transactionVO.getId() != null ? transactionVO.getId() : "Information not available"%>
				</div>
			</div>
			<div class="fila">
			<div class="columna">
				<aui:button type="submit" name="Name" value="label.accept" />
			</div>
		</div>
		<div id="msgid"></div>
	</div>
</aui:form>
<%
	if(transactionVO != null)	{
%>
	<script type="text/javascript">
		 
		$.ajax({
	    	url: "http://192.168.0.2:8080/Merchant/answerProcessor.jsp",
	    	type: "GET",
	        dataType: "html",
	        async: false,
	        data: { approbationNumber: <%=transactionVO.getId()%>, orderNumber:<%=transactionVO.getOrderNumber()%>},
	        success: function (response) {
	            $("#msgid").html("The merchant have received the payment. You can close this window." + response);
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
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



