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
<liferay-ui:error key="ProcessorMDTR.updateMerchantConfiguration.MerchantConfigurationDAOException" message="error.ProcessorMDTR.updateMerchantConfiguration.MerchantConfigurationDAOException" />
<% 
	MerchantConfigurationVO merchantConfigurationVO = (MerchantConfigurationVO)session.getAttribute("merchantConfigurationVO");
	request.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
	ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
%>

<portlet:actionURL name="editMerchantConfiguration" var="submitForm">
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
						<label class="aui-field-label sub-title"><fmt:message key="label.informationMerchantConfiguration"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="merchant" helpMessage="help.merchant" disabled="true" label="label.merchant" id="merchant">
						<c:forEach var="merchantVO" items="${listMerchants}">
							<aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==merchantConfigurationVO.merchantId}"/>
						</c:forEach>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.urlApproved" helpMessage="help.urlApproved" showRequiredLabel="false" type="text" required="true" name="urlApproved" value="${merchantConfigurationVO.urlApproved}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.urlDeny" helpMessage="help.urlDeny" showRequiredLabel="false" type="text" required="true" name="urlDeny" value="${merchantConfigurationVO.urlDeny}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.passwordKeyStore" helpMessage="help.passwordKeyStore" showRequiredLabel="false" type="text" required="true" name="passwordKeyStore" value="${merchantConfigurationVO.passwordKeyStore}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.privacyKeyStore" helpMessage="help.privacyKeyStore" showRequiredLabel="false" type="text" required="true" name="privacyKeyStore" value="${merchantConfigurationVO.privacyKeyStore}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.passwordkey" helpMessage="help.passwordkey" showRequiredLabel="false" type="text" required="true" name="passwordkey" value="${merchantConfigurationVO.passwordkey}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.keyName" helpMessage="help.keyName" showRequiredLabel="false" type="text" required="true" name="keyName" value="${merchantConfigurationVO.keyName}">
						<%-- <aui:validator name="alphanum"/> --%>
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