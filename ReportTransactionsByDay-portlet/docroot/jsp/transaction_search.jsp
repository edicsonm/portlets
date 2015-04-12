<%--
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * The contents of this file are subject to the terms of the applicable 
 * Liferay software end user license agreement ("License Agreement")
 * found on www.liferay.com/legal/eulas. You may also contact Liferay, Inc.
 * for a copy of the License Agreement. You may not use this file except in
 * compliance with the License Agreement. 
 * See the License Agreement for the specific language governing
 * permissions and limitations under the License Agreement, including 
 * but not limited to distribution rights of the Software.
 *
 */
--%>

<%@ include file="init.jsp" %>
<%
	SearchContainer searchContainer = (SearchContainer)request.getAttribute("liferay-ui:search:searchContainer");
	DisplayTerms displayTerms = searchContainer.getDisplayTerms();
	
	ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
	ArrayList<CountryVO> listCountries = (ArrayList<CountryVO>)session.getAttribute("listCountries");
	ArrayList<CurrencyVO> listCurrencies = (ArrayList<CurrencyVO>)session.getAttribute("listCurrencies");
%>
<liferay-ui:search-toggle buttonLabel="Buscar..." displayTerms="<%= displayTerms %>" id="toggle_id_transactions_search">
	
	<aui:input label="label.cardNumber" id="cardNumber" name="cardNumber" value="<%=cardNumber %>"/>
	<aui:input label="label.brand" id="brand" name="brand" value="<%=brand %>"/>
	
	<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"BillingBuddyAdministrator\", true) %>">
		<div class="control-group">
			<aui:select name="merchant" helpMessage="help.merchant" label="label.merchant" id="merchant">
				<aui:option value="NULL" label="label.All" selected="${countryVO.numeric==merchant}"/>
				<c:forEach var="merchantVO" items="${listMerchants}">
					<aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==merchant}"/>
				</c:forEach>
			</aui:select>
		</div>
	</c:if>
	
	<div class="control-group">
		<aui:select name="countryCard" helpMessage="help.countryCard"  label="label.countryCard" id="countryCard">
			<aui:option value="NULL" label="label.All" selected="${countryVO.numeric==countryBusinessInformation}"/>
			<c:forEach var="countryVO" items="${listCountries}">
				<aui:option value="${countryVO.alpha_2}" label="${countryVO.name}" selected="${countryVO.numeric==countryCard}"/>
			</c:forEach>
		</aui:select>
	</div>
	
	<div class="control-group">
		<aui:select name="currency" helpMessage="help.currency"  label="label.currency" id="currency">
			<aui:option value="NULL" label="label.All" selected="${countryVO.numeric==countryBusinessInformation}"/>
			<c:forEach var="currencyVO" items="${listCurrencies}">
				<aui:option value="${currencyVO.alphabeticCode}" label="${currencyVO.alphabeticCode} - ${currencyVO.countryName}" selected="${currencyVO.numericCode==currency}"/>
			</c:forEach>
		</aui:select>
	</div>
	
</liferay-ui:search-toggle>