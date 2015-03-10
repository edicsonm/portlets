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
AUI().use(
  'aui-form-validator', function(A) {
    var rules = {
   		description: {required: true,email: true},
   		name: {required: true} 
	};
    var fieldStrings = {
    	description: {required: 'Type your email in this field.'},
     	name: {required: 'Please provide your name.'}
    };
    new A.FormValidator(
      {
        boundingBox: '#myForm',
        /* fieldStrings: fieldStrings, */
        rules: rules,
        messageContainer: '<div class="alert alert-error" role="alert"></div>',
        showAllMessages: true
      });
    formValidator.printStackErrorBefore = formValidator.printStackError;
    formValidator.printStackError = function(field, container, errors) {
        alert('Esta esjecutando esto');
    	field.placeBefore(container)
		formValidator.printStackErrorBefore(field, container, errors);
	};
  }
);
</aui:script>
<%
	ArrayList<IndustryVO> resultsListCharge = (ArrayList<IndustryVO>)session.getAttribute("results");
	IndustryVO industryVO = (IndustryVO)resultsListCharge.get(Integer.parseInt(ParamUtil.getString(request, "indiceIndustry")));
	session.setAttribute("indiceIndustry", ParamUtil.getString(request, "indiceIndustry"));
	request.setAttribute("industryVO", industryVO);
	session.setAttribute("industryVO", industryVO);
%>
<portlet:actionURL name="editIndustry" var="editURLIndustry">
	<portlet:param name="jspPage" value="/jsp/viewIndustry.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackIndustry">
	<portlet:param name="jspPage" value="/jsp/viewIndustry.jsp" />
</portlet:renderURL>

<%-- <aui:form id="myForm" name="myForm" action="<%= editURLIndustry %>" method="post"> --%>
<form id="myForm">
	<fieldset>
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationIndustry"/> </span>
		</legend>
		<div class="">

		<div class="control-group">
			<label class="control-label" for="description"><fmt:message key="label.informationIndustry"/></label>
			<input name="description" id="description" class="form-control" type="text">
		</div>
		
		<div class="control-group">
			<label class="control-label" for="name">Name:</label>
			<div class="controls">
				<input name="name" id="name" class="form-control" type="text">
			</div>
		</div>

		<!-- <p class="aui-field">
				<label class="aui-field-label" for="name2">Name:</label> 
				<input id="description" class="form-control" type="text" name="description" />
			</p>
			<div class="form-group">
				<label class="control-label" for="age">Age:</label>
				<div class="controls">
					<input name="age" id="age" class="form-control field-required field-digits alert alert-error" type="text">
				</div>
			</div> -->
			<a class="btn" href="<%= goBackIndustry %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="save" value="label.save" />			
		</div>
	</fieldset>
<%-- </aui:form> --%>
</form>
