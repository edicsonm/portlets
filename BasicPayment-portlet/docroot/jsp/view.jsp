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
<%-- <liferay-ui:message key="label.title"/> --%>
<aui:script use="aui-io-request,aui-node">
</aui:script>
<%
	Calendar calendar = new GregorianCalendar();
	Calendar cal = CalendarFactoryUtil.getCalendar();
	int initialYear = cal.get(Calendar.YEAR) + 1;
	TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
	
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
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.purchaseInformation"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="details">
				<div class="paymentDetails">
					<p id="sub-legend" class="description"><fmt:message key="label.paymentDetails"/></p>
					<div id="contenedor">
						<div id="contenidos">
							<div id="columna1-2">
								<dl class="property-list">
									<dt><fmt:message key="label.merchantID"/></dt>
									<dd><c:out value="${merchantID}"/></dd>
								</dl>
							</div>
							<div id="columna2-2">
								<dl class="property-list">
									<dt><fmt:message key="label.orderNumber"/></dt>
									<dd><c:out value="${orderNumber}"/></dd>
								</dl>
							</div>
						</div>
						<div id="contenidos">
							<div id="columna1-2">
								<dl class="property-list">
									<dt><fmt:message key="label.currency"/></dt>
									<dd><c:out value="${currency}"/></dd>
								</dl>
							</div>
							<div id="columna2-2">
								<dl class="property-list">
									<dt><fmt:message key="label.transactionAmount"/></dt>
									<dd><c:out value="${transactionAmount}"/></dd>
								</dl>
							</div>
						</div>
					</div>
				</div>
				
				<p id="sub-legend" class="description"><fmt:message key="label.cardInformation"/></p>
				<div class="control-group">
					<aui:input label="label.name" showRequiredLabel="false" required="true" name="name" value="${transactionVO.cardVO.name}"/>
				</div>
				<div class="control-group">
					<aui:input label="label.email" showRequiredLabel="false" required="true" name="email" value="${transactionVO.cardVO.customerVO.email}">
						<aui:validator name="email"/>
					</aui:input>
				</div>
				<div class="control-group">
					<aui:input label="label.phoneNumber" showRequiredLabel="false" required="true" name="phoneNumber" value="${transactionVO.cardVO.customerVO.phoneNumber}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
					
					<div class="control-group">
						<aui:input label="label.cardNumber" showRequiredLabel="false" required="true" name="cardNumber" value="${transactionVO.cardVO.number}">
						  	<aui:validator name="digits"/>
						  	<aui:validator name="rangeLength" errorMessage="You must imput a number between 16 and 20 digits">[16,20]</aui:validator>
						 </aui:input>
					</div>
					<div class="control-group">
						<aui:input label="label.securityCode" showRequiredLabel="false" size="3"  type="text" required="true" name="securityCode" value="${transactionVO.cardVO.cvv}">
							<aui:validator name="digits"/>
							<aui:validator name="minLength" errorMessage="You must imput a number with 3 digits">3</aui:validator>
							<aui:validator name="maxLength" errorMessage="You must imput a number with 3 digits">3</aui:validator>
						</aui:input>
					</div>
					<div class="control-group">
						<aui:select name="expirationMonth" label="label.expirationMonth">
							<c:forEach var="i" begin="1" end="12">
								<aui:option label="${i}" value="${i}"/> 
							</c:forEach>
						</aui:select>
					</div>
					<div class="control-group">
						<aui:select name="expirationYear" label="label.expirationYear">
							<c:forEach var="i" begin="<%= initialYear%>" end="<%= initialYear + 15%>">
								<aui:option label="${i}" value="${i}"/> 
							</c:forEach>
						</aui:select>
					</div>
					<div class="control-group">
						
					</div>
					
				</div>
				
				<p id="sub-legend" class="description"><fmt:message key="label.billingAddressInformation"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<aui:input label="label.country" showRequiredLabel="false" required="true" name="country" value="${transactionVO.billingAddressCountry}">
									<aui:validator name="alpha"/>
									<aui:validator name="minLength" errorMessage="You must imput a code with 2 characters">2</aui:validator>
									<aui:validator name="maxLength" errorMessage="You must imput a code with 2 characters">2</aui:validator>
								</aui:input>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<aui:input label="label.region" showRequiredLabel="false" required="true" name="region" value="${transactionVO.billingAddressRegion}">
									<aui:validator name="alpha" />
								</aui:input>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<aui:input label="label.city" showRequiredLabel="false" required="true" name="city" value="${transactionVO.billingAddressCity}">
									<aui:validator name="alpha" />
								</aui:input>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<aui:input label="label.postalCode" showRequiredLabel="false" required="true" name="postalCode" value="${transactionVO.billingAddressPostal}">
									<aui:validator name="digits"/>
								</aui:input>
							</dl>
						</div>
					</div>
				</div>
			</div>
			<aui:button type="submit" name="Name" value="label.save" />
	</fieldset>
</aui:form>

<script type="text/javascript">
	var opener = window.opener;
</script>
