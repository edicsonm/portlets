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
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="ProcessorMDTR.updatePlan.PlanDAOException" message="error.ProcessorMDTR.updatePlan.PlanDAOException" />
<%
	PlanVO planVO = (PlanVO)session.getAttribute("planVO");
	ArrayList<CurrencyVO> listCurrencies = (ArrayList<CurrencyVO>)session.getAttribute("listCurrencies");
	ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
	request.setAttribute("planVO", planVO);
	session.setAttribute("planVO", planVO);
%>
<portlet:actionURL name="editPlan" var="editURLPlan">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackPlan">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= editURLPlan %>" method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationPlan"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			
			<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"MerchantAdministrator\", true) %>">
				<aui:select name="merchant" helpMessage="help.merchant" required="true"  label="label.merchant" id="merchant">
					<c:forEach var="merchantVO" items="${listMerchants}">
						<aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==planVO.merchantId}"/>
					</c:forEach>
				</aui:select>
			</c:if>
			
			<div class="control-group">
				<aui:input label="label.name" helpMessage="help.name" showRequiredLabel="false" type="text" required="true" name="name" value="${planVO.name}">
				</aui:input>
			</div>
			
			<div class="control-group">
				<aui:input label="label.amount" helpMessage="help.amount" showRequiredLabel="false" type="text" required="true" name="amount" value="${planVO.amount}">
					<aui:validator name="custom" errorMessage="error.decimalNumber">
						function (val, fieldNode, ruleValue) {
							var result = ( /^(\d+|\d+.\d{1,2})$/.test(val));
							return result;
						}
					</aui:validator>
				</aui:input>
			</div>
			
			<div class="control-group">
				<aui:select name="currency" onChange="searchMerchantInformation();" helpMessage="help.currency" label="label.currency" id="currency">
					<c:forEach var="currencyVO" items="${listCurrencies}">
						<aui:option value="${currencyVO.alphabeticCode}" label="${currencyVO.alphabeticCode}" selected="${currencyVO.alphabeticCode==planVO.currency}"/>
					</c:forEach>
				</aui:select>
			</div>
			
			<div class="control-group">
				<aui:select name="interval" helpMessage="help.interval" label="label.interval" id="interval">
					<aui:option value="Day" label="label.day" selected="${planVO.interval=='Day'}"/>
					<aui:option value="Week" label="label.week" selected="${planVO.interval=='Week'}"/>
					<aui:option value="Month" label="label.month" selected="${planVO.interval=='Month'}"/>
					<aui:option value="Year" label="label.year" selected="${planVO.interval=='Year'}"/>
				</aui:select>
			</div>
			
			<div class="control-group">
				<aui:input label="label.intervalCount" helpMessage="help.intervalCount" showRequiredLabel="false" type="text" required="false" name="intervalCount" value="${planVO.intervalCount}">
					<aui:validator name="digits"/>
				</aui:input>
			</div>
			
			<div class="control-group">
				<aui:input label="label.trialPeriodDays"  helpMessage="help.trialPeriodDays" showRequiredLabel="false" type="text" required="false" name="trialPeriodDays" value="${planVO.trialPeriodDays}">
					<aui:validator name="digits"/>
				</aui:input>
			</div>
			
			
			<div class="control-group">
				<aui:input label="label.statementDescriptor" helpMessage="help.statementDescriptor" showRequiredLabel="false" type="textarea" required="false" name="statementDescriptor" value="${planVO.statementDescriptor}">
				</aui:input>
			</div>
			
			<a href="<%= goBackPlan %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="save" value="label.save" />
		</div>
	</fieldset>
</aui:form>