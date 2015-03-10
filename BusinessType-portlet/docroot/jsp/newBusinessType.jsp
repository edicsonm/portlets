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
<liferay-ui:error key="ProcessorMDTR.saveBusinessType.BusinessTypeDAOException" message="error.ProcessorMDTR.saveBusinessType.BusinessTypeDAOException" />
<% 
	BusinessTypeVO businessTypeVO = (BusinessTypeVO)session.getAttribute("businessTypeVO");
%>
<portlet:actionURL name="saveBusinessType" var="submitFormBusinessType">
	<portlet:param name="mvc" value="/jsp/viewBusinessType.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackBusinessType">
	<portlet:param name="mvc" value="/jsp/viewBusinessType.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitFormBusinessType %>" method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationBusinessType"/> </span>
		</legend>
		<div class="">
			<div class="control-group">
				<aui:input label="label.description" helpMessage="help.description" showRequiredLabel="false" type="text" required="true" name="description" value="${businessTypeVO.description}">
				</aui:input>
			</div>
			<a href="<%= goBackBusinessType %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="save" value="label.save" />
		</div>
	</fieldset>
</aui:form>