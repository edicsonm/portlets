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
	
	/* ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
	ArrayList<CountryVO> listCountries = (ArrayList<CountryVO>)session.getAttribute("listCountries");
	ArrayList<CurrencyVO> listCurrencies = (ArrayList<CurrencyVO>)session.getAttribute("listCurrencies"); */
%>
<liferay-ui:search-toggle buttonLabel="Buscar..." displayTerms="<%= displayTerms %>" id="toggle_id_submittedProcessLogs_search">
	
	<aui:input label="label.processName" id="processName" name="processName" value="<%=processName %>"/>
	
	<div class="control-group">
		<aui:select name="merchant" helpMessage="help.merchant" label="label.merchant" id="merchant">
			<%-- <aui:option value="NULL" label="label.All" selected="${countryVO.numeric==statusProcess}"/> --%>
			<%-- <aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==merchant}"/> --%>
			<aui:option value="Waiting" label="Waiting"/>
			<aui:option value="Error" label="Error"/>
			<aui:option value="Success" label="Success"/>
			<aui:option value="OnExecution" label="OnExecution"/>
		</aui:select>
	</div>
</liferay-ui:search-toggle>