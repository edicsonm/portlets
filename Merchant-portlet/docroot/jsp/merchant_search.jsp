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
	ArrayList<BusinessTypeVO> listBusinessTypes = (ArrayList<BusinessTypeVO>)session.getAttribute("listBusinessTypes");
	ArrayList<IndustryVO> listIndustries = (ArrayList<IndustryVO>)session.getAttribute("listIndustries");
%>
<liferay-ui:search-toggle buttonLabel="Buscar..." displayTerms="<%= displayTerms %>" id="toggle_id_businessType_search">
	<aui:input label="name" id="name" name="name" value="<%=nameMerchant %>"/>
	
	<div class="control-group">
		<aui:select name="countryBusinessInformation" helpMessage="help.countryBusinessInformation"  label="label.countryBusinessInformation" id="countryBusinessInformation">
			<aui:option value="NULL" label="label.All" selected="${countryVO.numeric==countryBusinessInformation}"/>
			<c:forEach var="countryVO" items="${listCountries}">
				<aui:option value="${countryVO.numeric}" label="${countryVO.name}" selected="${countryVO.numeric==merchantVO.countryNumericMerchant}"/>
			</c:forEach>
		</aui:select>
	</div>
	
	<div class="control-group">
		<aui:select name="businessType" helpMessage="help.businessType"  label="label.businessType" id="businessType">
			<aui:option value="NULL" label="label.All" selected="${businessTypeVO.id==businessType}"/>
			<c:forEach var="businessTypeVO" items="${listBusinessTypes}">
				<aui:option value="${businessTypeVO.id}" label="${businessTypeVO.description}" selected="${businessTypeVO.id==merchantVO.businessTypeId}"/>
			</c:forEach>
		</aui:select>
	</div>
	
	<div class="control-group">
		<aui:select name="industry" helpMessage="help.industry"  label="label.industry" id="industry">
			<aui:option value="NULL" label="label.All" selected="${industryVO.id==industry}"/>
			<c:forEach var="industryVO" items="${listIndustries}">
				<aui:option value="${industryVO.id}" label="${industryVO.description}" selected="${industryVO.id==merchantVO.industryId}"/>
			</c:forEach>
		</aui:select>
	</div>
	
	
	<div class="control-group">
		<aui:select name="status">
			<aui:option value="NULL" label="label.All"></aui:option>
			<aui:option value="0" label="label.active"></aui:option>
			<aui:option value="1" label="label.inactive"></aui:option>
			<%-- <aui:option value="NULL" label="label.All" selected="${industryVO.id=="NULL"}"></aui:option>
			<aui:option value="0" label="label.active"  selected="${industryVO.id=="0"}"></aui:option>
			<aui:option value="1" label="label.inactive" selected="${industryVO.id=="1"}"></aui:option> --%>
		</aui:select>
	</div>
	<%-- <aui:select name="studentGender">
		<aui:option label="Male" value="1"></aui:option>
		<aui:option label="Female" value="0"></aui:option>
	</aui:select> --%>
	
	<%-- <aui:input label="status" id="status" name="status" value="<%=status %>"/> --%>
	
</liferay-ui:search-toggle>