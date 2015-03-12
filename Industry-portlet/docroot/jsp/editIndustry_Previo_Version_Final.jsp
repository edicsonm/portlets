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
<liferay-ui:error key="ProcessorMDTR.updateIndustry.IndustryDAOException" message="error.ProcessorMDTR.updateIndustry.IndustryDAOException" />
<aui:script>
AUI().use('aui-form-validator', function (A) {
    formValidator = new A.FormValidator({
        boundingBox: '#myForm',
        messageContainer: '<div class="alert alert-error" role="alert"></div>',
    });

    formValidator.printStackErrorBefore = formValidator.printStackError;
    formValidator.printStackError = function(field, container, errors) {
        field.placeBefore(container)
		formValidator.printStackErrorBefore(field, container, errors);
	};
});
</aui:script>

<form id="myForm">
  <p>
    <label class="aui-field-label" for="name">Name:</label>
    <input class="aui-field-required" type="text" name="name" />
  </p>
  <p>
    <label class="aui-field-label" for="email">Email:</label>
    <input class="aui-field-required aui-field-email" type="text" name="email" />
  </p>
  <p>
    <label class="aui-field-label" for="age">Age:</label>
    <input class="aui-field-required aui-field-digits" type="text" name="age" />
  </p>
  <p>
    <input class="aui-button-input" type="submit" value="Submit" />
    <input class="aui-button-input" type="reset" value="Reset" />
  </p>
</form>