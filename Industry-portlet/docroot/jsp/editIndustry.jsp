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
/* AUI().use('aui-form-validator', function (A) {
    formValidator = new A.FormValidator({
        boundingBox: '#myForm',
        messageContainer: '<div class="alert alert-error" role="alert"></div>',
    });
    formValidator.printStackErrorBefore = formValidator.printStackError;
    formValidator.printStackError = function(field, container, errors) {
        field.placeBefore(container)
		formValidator.printStackErrorBefore(field, container, errors);
	};
}); */
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


<%-- <aui:form  id="myForm" action="<%= editURLIndustry %>" method="post">
	
	<aui:input label="label.description" required="true" helpMessage="help.description" showRequiredLabel="false" type="text" name="description" value="${businessTypeVO.description}"></aui:input>
	
	<input name="<portlet:namespace/>uno" class="aui-field-required" id="<portlet:namespace/>uno"  type="text">
	
	<aui:button type="submit" name="save" value="label.save" />
</aui:form> --%>

 
<%-- <form id="myForm" name="myForm" action="<%= editURLIndustry %>" method="post">
  <fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationIndustry"/> </span>
		</legend>
		<div class="">
			<div class="control-group">
				<aui:input label="label.description" required="true" helpMessage="help.description" showRequiredLabel="false" type="text" name="description" value="${businessTypeVO.description}"></aui:input>
				<label class="control-label" for="description"><fmt:message key="label.informationIndustry"/></label>
				<input name="description" id="description" class="aui-field-required" type="text">
			</div>
			<a class="btn" href="<%= goBackIndustry %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="save" value="label.save" />
		</div>
</fieldset>
</form> --%>

<aui:form id="myForm" name="myForm" action="<%= editURLIndustry %>" method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationIndustry"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="control-group">
				<aui:input label="label.description" required="true" helpMessage="help.description" showRequiredLabel="false" type="text" name="description" value="${industryVO.description}"></aui:input>
			</div>
			<a class="btn" href="<%= goBackIndustry %>"><fmt:message key="label.goBack"/></a>
			<aui:button type="submit" name="save" value="label.save" />
		</div>
	</fieldset>
</aui:form>

<!--   <p>
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
  </p> -->