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
<liferay-ui:error key="ProcessorMDTR.saveMerchantConfiguration.MerchantConfigurationDAOException.Merc_ID_UNIQUE" message="error.ProcessorMDTR.saveMerchantConfiguration.MerchantConfigurationDAOException.Merc_ID_UNIQUE" />
<% 
	MerchantConfigurationVO merchantConfigurationVO = (MerchantConfigurationVO)session.getAttribute("merchantConfigurationVO");
	ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
%>

<portlet:actionURL name="saveMerchantConfiguration" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackMerchantConfiguration">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitForm %>" method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationMerchantConfiguration"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="details">
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-1">
							<aui:select name="merchant" helpMessage="help.merchant"  label="label.merchant" id="merchant">
								<c:forEach var="merchantVO" items="${listMerchants}">
									<aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==merchantConfigurationVO.merchantId}"/>
								</c:forEach>
							</aui:select>
						</div>
					</div>
					
					<div id="contenidos">
							<div id="columna1-1">
							<aui:input style="width:70%" label="label.urlApproved" helpMessage="help.urlApproved" showRequiredLabel="false" type="text" required="true" name="urlApproved" value="${merchantConfigurationVO.urlApproved}">
							</aui:input>
						</div>
					</div>
					
					<div id="contenidos">
							<div id="columna1-1">
							<aui:input style="width:70%" label="label.urlDeny" helpMessage="help.urlDeny" showRequiredLabel="false" type="text" required="true" name="urlDeny" value="${merchantConfigurationVO.urlDeny}" >
							</aui:input>
						</div>
					</div>
				</div>
			</div>
			<a href="<%= goBackMerchantConfiguration %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="save" value="label.save" />
		</div>
	</fieldset>

	<%-- <div class="table">
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
					<aui:input label="label.name" helpMessage="help.name" showRequiredLabel="false" type="text" required="true" name="name" value="${merchantConfigurationVO.id}">
						<aui:validator name="alphanum"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="merchant" helpMessage="help.merchant"  label="label.merchant" id="merchant">
						<c:forEach var="merchantVO" items="${listMerchants}">
							<aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==merchantConfigurationVO.merchantId}"/>
						</c:forEach>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.urlApproved" helpMessage="help.urlApproved" showRequiredLabel="false" type="text" required="true" name="urlApproved" value="${merchantConfigurationVO.urlApproved}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.urlDeny" helpMessage="help.urlDeny" showRequiredLabel="false" type="text" required="true" name="urlDeny" value="${merchantConfigurationVO.urlDeny}">
						<aui:validator name="required"/>
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
	</div> --%>
</aui:form>