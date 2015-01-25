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
<liferay-ui:error key="ProcessorMDTR.saveMerchantRestriction.MerchantRestrictionDAOException" message="error.ProcessorMDTR.saveMerchantRestriction.MerchantRestrictionDAOException" />
<liferay-ui:error key="ProcessorMDTR.saveMerchantRestriction.MerchantRestrictionDAOException.UNIQUE_Merc_ID_Mere_Concept" message="error.ProcessorMDTR.saveMerchantRestriction.MerchantRestrictionDAOException.UNIQUE_Merc_ID_Mere_Concept" />

<% 
	MerchantRestrictionVO merchantRestrictionVO = (MerchantRestrictionVO)session.getAttribute("merchantRestrictionVO");
	ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
%>

<portlet:actionURL name="saveMerchantRestriction" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitForm %>" method="post">
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.informationMerchantRestriction"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="merchant" helpMessage="help.merchant"  label="label.merchant" id="merchant">
						<c:forEach var="merchantVO" items="${listMerchants}">
							<aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==merchantRestrictionVO.merchantId}"/>
						</c:forEach>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="concept" helpMessage="help.concept" label="label.concept" id="concept">
						<aui:option value="Amount" label="label.amount" selected="${merchantRestrictionVO.concept=='Amount'}"/>
						<aui:option value="Transactions" label="label.transactions" selected="${merchantRestrictionVO.concept=='Transactions'}"/>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.value" helpMessage="help.value" showRequiredLabel="false" type="text" required="true" name="value" value="${merchantRestrictionVO.value}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.timeUnit" helpMessage="help.timeUnit" showRequiredLabel="false" type="text" required="true" name="timeUnit" value="${merchantRestrictionVO.timeUnit}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
				<div class="column2-2">
					<aui:button type="submit" name="save" value="label.save" />
				</div>
			</div>
		</div>
	</div>
</aui:form>