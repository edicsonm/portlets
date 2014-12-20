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

<liferay-ui:message key="label.title"/>
<aui:script use="aui-io-request,aui-node">
</aui:script>
<%
	Calendar calendar = new GregorianCalendar();
	Calendar cal = CalendarFactoryUtil.getCalendar();
	int initialYear = cal.get(Calendar.YEAR);
	TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
%>
<portlet:actionURL var="savePayment" name="savePayment"/>
<aui:form action="<%= savePayment %>" method="post">
	<div class="tabla"> 
		
		<div class="fila">
			<div class="columnaIzquierda">
				<label class="aui-field-label"><fmt:message key="label.merchantID"/></label>
			</div>
			<div class="columnaDerecha">
				<c:out value="${merchantID}"/>
			</div>
		</div>
		
		<div class="fila">
			<div class="columnaIzquierda">
				<label class="aui-field-label"><fmt:message key="label.orderNumber"/></label>
			</div>
			<div class="columnaDerecha">
				<c:out value="${orderNumber}"/>
			</div>
		</div>
		
		<div class="fila">
			<div class="columnaIzquierda">
				<label class="aui-field-label"><fmt:message key="label.currency"/></label>
			</div>
			<div class="columnaDerecha">
				<c:out value="${currency}"/>
			</div>
		</div>
		
		<div class="fila">
			<div class="columnaIzquierda">
				<label class="aui-field-label"><fmt:message key="label.transactionAmount"/></label>
			</div>
			<div class="columnaDerecha">
				<c:out value="${transactionAmount}"/>
			</div>
		</div>
		
		<%-- <div class="fila">
			<div class="columna">
				<aui:input label="label.name" showRequiredLabel="false" required="true" name="name" value="${transactionVO.cardVO.name}"/>
			</div>
		</div>
		<div class="fila">
			<div class="columna">
				<aui:input label="label.email" showRequiredLabel="false" required="true" name="email" value="${transactionVO.customerVO.email}">
					<aui:validator name="email"/>
				</aui:input>
			</div>
		</div>
		<div class="fila">
			<div class="columna">
				<aui:input label="label.companyName" showRequiredLabel="false" required="true" name="companyName" value="${transactionVO.companyName}"/>
			</div>
		</div>
		<div class="fila">
			<div class="columna">
				<aui:input label="label.cardNumber" showRequiredLabel="false" required="true" name="cardNumber" value="${transactionVO.cardVO.cardNumber}">
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
				<aui:input label="label.expirationMonth" showRequiredLabel="false" required="true" name="expirationMonth" value="${basicPaymentRequestModel.email}"/>
			</div>
		</div>
		<div class="fila">
			<div class="columna">
				<aui:select name="expirationYear" label="label.expirationYear">
					<c:forEach var="i" begin="<%= initialYear%>" end="<%= initialYear + 15%>">
					<c:forEach var="razaVO" items="${listaRazas}">
						<aui:option label="${i}" value="${i}"/> 
						<aui:option label="${i}" selected="${ejemplarVO.idRaza.equalsIgnoreCase(razaVO.idRaza) ? true : false }" value="${razaVO.idRaza}"></aui:option>
					</c:forEach>
				</aui:select>
				<aui:input label="label.expirationYear" showRequiredLabel="false" required="true" name="expirationYear" value="${basicPaymentRequestModel.email}"/>
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
		</div> --%>
		
		<%-- <div class="fila">
			<div class="columna">
				<label for=fechaNacimiento class="aui-field-label"><fmt:message key="label.expirationDate"/></label>
				<liferay-ui:input-date formName="fechaNacimiento" dayParam="diaNacimiento" dayValue="<%= cal.get(Calendar.DATE) %>" disabled="<%= false %>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
			      monthParam="mesNacimiento" monthValue="<%= cal.get(Calendar.MONTH) %>" yearParam="anioNacimiento" yearValue="<%= cal.get(Calendar.YEAR) %>"
			      yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
			</div>
		</div> --%>
		
		<div class="fila">
			<div class="columna">
				<aui:button type="submit" name="Name" value="label.save" />
				<aui:button type="button" name="Name" onClick="updateOpener('This a message from BillingBuddy')" value="label.sendMessage" />
			</div>
		</div>
		<%-- 
		<div class="fila">
			<div class="columna">
				<input type="button" value="select" onClick="
var organizationWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="jspPage" value="/jsp/view.jsp"/><portlet:param name="redirect" value="#"/></portlet:renderURL>',
         'title',
        'directories=no, height=340, location=no, menubar=no, resizable=yes,scrollbars=yes, status=no, toolbar=no, width=680');
        organizationWindow.focus();" />
			</div>
		</div> --%>
		
	</div>
</aui:form>

<script type="text/javascript">
	var opener = window.opener;
	/* function updateOpener(value){
		opener.$("#msgid2").html(value);
	} */
/* jQuery('#<portlet:namespace/>diaNacimiento').hide();
jQuery('.aui-datepicker-button-wrapper').hide(); */
</script>
