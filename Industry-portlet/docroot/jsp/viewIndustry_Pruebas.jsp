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

<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<portlet:defineObjects />

<style type="text/css">
fieldset {
	border: 1px solid #CCCCCC;
	margin: 10px;
	padding: 10px;
	font-size: 13px;
}

legend {
	font-size: 20px;
	font-weight: bold;
}

input[type=text], textarea, select {
	border: 1px solid #777;
	padding: 3px;
}

.aui-form-validator-stack-error {
	color: red;
	display: block;
	font-weight: normal;
	font-style: italic;
	margin: 3px 0;
}

.aui-form-validator-error-container {
	
}

.aui-form-validator-valid-container {
	
}

.aui-form-validator-error {
	background: lightPink;
}

.aui-form-validator-valid {
	background: lightGreen;
}
</style>

<h1>Liferay AUI - FormValidator</h1>

<form id="fm1" action="" name="fm1">
	<fieldset>
		<legend>Example 1 - Rules extracted from CSS classes</legend>
		
		<div id="errores" class="form-validator-stack help-inline"></div>
		
		<p class="aui-field">
			<label class="aui-field-label" for="name2">Name:</label> 
			<input id="name2" class="field aui-field-required" type="text" name="name2" />
		</p>
		
		<label class="aui-field-label" for="email2">Email:</label> 
			<input id="email2" class="aui-field-required aui-field-email" type="text" name="email" /> 
		<label class="aui-field-label" for="age2">Age:</label>
		
		<input id="age2" class="aui-field-digits field" type="text" name="age" />
		
	</fieldset>

	<p>
		<input type="submit" value="Submit" /> <input type="reset" value="Reset" />
	</p>
</form>
<aui:script>

YUI().use(
  'aui-form-validator', 'aui-overlay-context-panel', function(Y) {
    new Y.FormValidator(
      {
    	  boundingBox: '#fm1'/* ,
    	  messageContainer: '<div class="alert alert-error" role="alert"></div>',
          showAllMessages: true */
      });
    
    formValidator.printStackErrorBefore = formValidator.printStackError;

    formValidator.printStackError = function(field, container, errors) {
        field.placeAfter(container)
		formValidator.printStackErrorBefore(field, container, errors);
	};
    
  });
/* 
Y.one('#name').printStackError('errores','name2',)  */
</aui:script>