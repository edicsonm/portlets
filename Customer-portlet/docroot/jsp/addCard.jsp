<%--
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
--%>
<%@ include file="init.jsp" %>

<% 
	boolean answer = false;
	if(session.getAttribute("answer") != null && String.valueOf(session.getAttribute("answer")).equalsIgnoreCase("true")){
		answer = true;
	}
	
	Calendar calendar = new GregorianCalendar();
	Calendar cal = CalendarFactoryUtil.getCalendar();
	int initialYear = cal.get(Calendar.YEAR) + 1;
	System.out.println("Cargando la pagina addCard.js .... " + answer);
%>

<aui:script>
AUI().use(
  'aui-toggler',
  function(A) {
    new A.Toggler(
      {
        container: '#myToggler',
        content: '.content',
        expanded: false,
        header: '.header'
      }
    );
  }
);
</aui:script>

<fmt:setBundle basename="Language"/>
<portlet:defineObjects />
<liferay-theme:defineObjects />

<liferay-ui:success key="CardCreatedSuccessfully" message="label.CardCreatedSuccessfully" />
<liferay-ui:error key="ProcessorMDTR.saveCard.CardDAOException" message="error.ProcessorMDTR.saveCard.CardDAOException" />

<portlet:actionURL name="saveCard" var="submitFormCreateCard"/>

<aui:form  action="<%= submitFormCreateCard %>" method="post">
	<fieldset class="fieldset">
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			
			<div class="control-group">
					<aui:input label="label.name" showRequiredLabel="false" required="true" name="name" value="${cardVO.name}"/>
			</div>
			
			<div class="control-group">
				<aui:input label="label.number" helpMessage="help.number" showRequiredLabel="false" type="text" required="true" name="number" value="${cardVO.number}">
					<aui:validator name="digits"/>
						  	<aui:validator name="rangeLength" errorMessage="You must imput a number between 16 and 20 digits">[16,20]</aui:validator>
				</aui:input>
			</div>
			
			<div class="control-group">
				<aui:input label="label.securityCode" showRequiredLabel="false" size="3"  type="text" required="true" name="securityCode" value="${cardVO.cvv}">
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
			
			<button class="btn-link header aui-toggler-header-collapsed"><fmt:message key="label.moreOptions"/></button>
			<div id="myToggler" class="content aui-toggler-content-collapsed">
				<%-- <p id="sub-legend" class="description"><fmt:message key="label.billingAddressInformation"/></p> --%>
				<div class="control-group">
					<aui:input label="label.street" helpMessage="help.street" showRequiredLabel="false" required="false" name="street" value="${cardVO.addressLine1}"/>
				</div>
				
				<div class="control-group">
					<aui:input label="label.city" showRequiredLabel="false" required="false" name="city" value="${cardVO.addressCity}">
						<aui:validator name="alpha" />
					</aui:input>
				</div>
				
				<div class="control-group">
					<aui:input label="label.addressZip" helpMessage="help.addressZip" showRequiredLabel="false" required="false" name="addressZip" value="${cardVO.addressZip}">
						<aui:validator name="alpha" />
					</aui:input>
				</div>
				<div class="control-group">
					<aui:input label="label.addresState" helpMessage="help.addresState" showRequiredLabel="false" required="false" name="addresState" value="${cardVO.addresState}">
						<aui:validator name="alpha" />
					</aui:input>
				</div>
				<div class="control-group">
					<aui:input label="label.country" helpMessage="help.country" showRequiredLabel="false" required="false" name="country" value="${cardVO.addressCountry}">
						<aui:validator name="alpha" />
						<aui:validator name="minLength" errorMessage="You must imput a code with 2 characters">2</aui:validator>
						<aui:validator name="maxLength" errorMessage="You must imput a code with 2 characters">2</aui:validator>
					</aui:input>
				</div>
			</div>
			<%-- <a href="<%= goBack %>"><fmt:message key="label.goBack"/></a> --%>
			<aui:button type="submit" name="addCard" value="label.addCard" />
		</div>
	</fieldset>
</aui:form>

<aui:script>
var answer = "<%=answer%>";
AUI().use('aui-base','aui-io-request', function(A){
	if(answer != 'false'){
		Liferay.Util.getOpener().recharge();
	}
});
</aui:script>