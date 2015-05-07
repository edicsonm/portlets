<%--
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
--%>
<%@ include file="init.jsp" %>

<fmt:setBundle basename="Language"/>
<portlet:defineObjects />
<liferay-theme:defineObjects />

<liferay-ui:success key="CardCreatedSuccessfully" message="label.success" />
<liferay-ui:error key="ErrorCreatingCard" message="error.error" />

<portlet:actionURL name="saveCard" var="submitFormCreateCard"/>

<portlet:resourceURL var="testURL">
    <portlet:param name="jspPage" value="/jsp/time.jsp" />
</portlet:resourceURL>

<aui:form  action="<%= submitFormCreateCard %>" method="post">
	<fieldset class="fieldset">
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		
			<div class="control-group">
				<aui:input label="label.name" helpMessage="help.name" showRequiredLabel="false" type="text" required="true" name="name" value="${cardVO.name}">
				<aui:validator name="alpha"/>
			</aui:input>
			</div>
			<aui:button type="submit" name="createCard" value="label.createCard" />
		</div>
	</fieldset>
</aui:form>
<script>
</script>
<aui:script>
	Liferay.Util.getOpener().saludar();
	
	/* Liferay.Util.getOpener().document.getElementById('time').load("<%= testURL %>"); */
	/* var declineComment  = Liferay.Util.getOpener().document.getElementById('time'); */
	/* declineComment.load("<%= testURL %>"); */
</aui:script>