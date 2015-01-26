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
<liferay-ui:error key="ProcessorMDTR.saveMerchantConfiguration.MerchantConfigurationDAOException" message="error.ProcessorMDTR.saveMerchantConfiguration.MerchantConfigurationDAOException" />
<liferay-ui:error key="SecurityMDTR.certificateGeneration.Exception" message="error.SecurityMDTR.certificateGeneration.Exception" />
<liferay-ui:error key="ProcessorMDTR.saveMerchantConfiguration.MerchantConfigurationDAOException.Merc_ID_UNIQUE" message="error.ProcessorMDTR.saveMerchantConfiguration.MerchantConfigurationDAOException.Merc_ID_UNIQUE" />

<% 
	CertificateVO certificateVO = (CertificateVO)session.getAttribute("certificateVO");
	ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
%>

<portlet:actionURL name="saveCertificateGeneration" var="submitForm">
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
						<label class="aui-field-label sub-title"><fmt:message key="label.informationCertificateGeneration"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="merchant" helpMessage="help.merchant"  label="label.merchant" id="merchant">
						<c:forEach var="merchantVO" items="${listMerchants}">
							<aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==certificateVO.merchantId}"/>
						</c:forEach>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.commonName" helpMessage="help.commonName" showRequiredLabel="false" type="text" required="true" name="commonName" value="${certificateVO.commonName}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.organization" helpMessage="help.organization" showRequiredLabel="false" type="text" required="true" name="organization" value="${certificateVO.organization}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.organizationUnit" helpMessage="help.organizationUnit" showRequiredLabel="false" type="text" required="true" name="organizationUnit" value="${certificateVO.organizationUnit}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.country" helpMessage="help.country" showRequiredLabel="false" type="text" required="true" name="country" value="${certificateVO.country}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			
			<div class="row">
				<div class="column1-2">
					<aui:input label="label.passwordKeyStore" helpMessage="help.passwordKeyStore" showRequiredLabel="false" type="password" required="true" name="passwordKeyStore" value="${certificateVO.passwordKeyStore}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
				<div class="column2-2">
					<aui:input label="label.passwordKeyStoreConfirmation" helpMessage="help.passwordKeyStoreConfirmation" showRequiredLabel="false" type="password" required="true" name="passwordKeyStoreConfirmation" value="${certificateVO.passwordKeyStoreConfirmation}">
						<aui:validator name="equalTo">'#<portlet:namespace />passwordKeyStore'</aui:validator>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
					<aui:input label="label.privacyKeyStore" helpMessage="help.privacyKeyStore" showRequiredLabel="false" type="password" required="true" name="privacyKeyStore" value="${certificateVO.privacyKeyStore}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
				<div class="column2-2">
					<aui:input label="label.privacyKeyStoreConfirmation" helpMessage="help.privacyKeyStoreConfirmation" showRequiredLabel="false" type="password" required="true" name="privacyKeyStoreConfirmation" value="${certificateVO.privacyKeyStoreConfirmation}">
						<aui:validator name="equalTo">'#<portlet:namespace />privacyKeyStore'</aui:validator>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
					<aui:input label="label.passwordkey" helpMessage="help.passwordkey" showRequiredLabel="false" type="password" required="true" name="passwordkey" value="${certificateVO.passwordkey}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
				<div class="column2-2">
					<aui:input label="label.passwordkeyConfirmation" helpMessage="help.passwordkeyConfirmation" showRequiredLabel="false" type="password" required="true" name="passwordkeyConfirmation" value="${certificateVO.passwordkeyConfirmation}">
						<aui:validator name="equalTo">'#<portlet:namespace />passwordkey'</aui:validator>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.keyName" helpMessage="help.keyName" showRequiredLabel="false" type="text" required="true" name="keyName" value="${certificateVO.keyName}">
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