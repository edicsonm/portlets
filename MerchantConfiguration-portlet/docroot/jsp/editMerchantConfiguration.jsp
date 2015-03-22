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

<portlet:actionURL name="editMerchantConfiguration" var="submitFormMerchantConfiguration">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackMerchantConfiguration">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitFormMerchantConfiguration %>" method="post">
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
							<aui:select name="merchant" helpMessage="help.merchant" disabled="true" label="label.merchant" id="merchant">
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
</aui:form>