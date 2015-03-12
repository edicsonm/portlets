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

<!-- <script src="http://cdn.alloyui.com/3.0.0/aui/aui-min.js"></script>
<link href="http://cdn.alloyui.com/3.0.0/aui-css/css/bootstrap.min.css" rel="stylesheet"></link> -->

<liferay-ui:error key="ProcessorMDTR.updateIndustry.IndustryDAOException" message="error.ProcessorMDTR.updateIndustry.IndustryDAOException" />
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

<aui:script>
/* YUI().use(
  'aui-form-validator',
  function(Y) {
    new Y.FormValidator(
      {
    	  boundingBox: '#myForm',
          fieldStrings: fieldStrings,
          rules: rules,
          showAllMessages: true
      }
    );
  }
); */


/* YUI().use(
  'aui-form-validator',
  function(Y) {
    var rules = {
      email: {
        email: true,
        required: true
      },
      emailConfirmation: {
        email: true,
        equalTo: '#email',
        required: true
      },
      gender: {
        required: true
      },
      field1: {
        rangeLength: [2, 50],
        required: true
      },
      picture: {
        acceptFiles: 'jpg, gif, png',
        required: true
      },
      url: {
        url: true
      }
    };

    var fieldStrings = {
      email: {
        required: 'Type your email in this field.'
      },
      field1: {
        required: 'Please provide your name.'
      }
    };

    new Y.FormValidator(
      {
        boundingBox: '#myForm',
        fieldStrings: fieldStrings,
        rules: rules,
        showAllMessages: true
      }
    );
  }
); */

YUI().use(
		  'aui-form-validator',
		  function(Y) {
		    var rules = {
		    	_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field1: {
		        email: true,
		        required: true
		      }
		    };

		    var fieldStrings = {
		    _1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field1: {
		        required: 'Type your email in this field.'
		      }
		    };

		    new Y.FormValidator(
		      {
		        boundingBox: '#myForm',
		        fieldStrings: fieldStrings,
		        rules: rules,
		        showAllMessages: true
		      }
		    );
		  }
		);

/* YUI().use(
  'aui-form-validator',
  function(Y) {
    new Y.FormValidator(
      {
        boundingBox: '#myForm'
      }
    );
  }
); */
</aui:script>

<%-- <aui:form id="myForm" action="<%= editURLIndustry %>" method="post">
	
<legend class="fieldset-legend">
	<span class="legend"><fmt:message key="label.informationIndustry"/></span>
</legend>
<div class="">
	<p class="description"><fmt:message key="label.informationIndustry"/></p>
	<div class="hide" id="yui_patched_v3_11_0_1_1425690551403_567">
		<span class="alert alert-error">Aca viene el errr</span>
	</div>	
	<div class="table">
		<div class="column1-1">
			<aui:input label="label.description" helpMessage="help.description" showRequiredLabel="false" type="text" required="true" name="description" value="${industryVO.description}">
			</aui:input>
		</div>
	</div>


	<div class="form-group">
		<label class="control-label" for="name">Name:</label>
		<div class="controls">
			<input name="name" id="name" class="form-control" type="text">
		</div>
	</div>

	<div class="form-group">
		<label class="control-label" for="age">Age:</label>
		<div class="controls">
			<input name="age" id="age"  class="form-control field-required field-digits" type="text">
		</div>
	</div>


	<a class="btn" href="<%= goBackIndustry %>"><fmt:message key="label.goBack"/></a>
	<aui:button type="submit" name="save" value="label.save" />			
</div>		
</aui:form> --%>

<!-- <form id="myForm">
<fieldset class="fieldset "> 
	<legend class="fieldset-legend"> 
		<span class="legend"> Suggestions </span> 
	</legend> 
	<div class=""> 
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		<div id="fieldOptionalErrorfield1" class="hide"> 
			<span class="alert alert-error">Este campo es obligatorio.</span> 
		</div> 
		<div class="control-group">
			<label for="field1" class="control-label"> Name </label> 
			<input type="text" value="" name="field1" id="field1" class="field">
		</div>
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	</div>
</fieldset>

	  <div class="control-group">
	    <label class="control-label" for="name">Name:</label>
	    <div class="controls">
	      <input name="name" id="name" class="form-control" type="text">
	    </div>
	  </div>
	
	  <div class="control-group">
	    <label class="control-label" for="picture">Picture:</label>
	    <div class="controls">
	      <input name="picture" id="picture" class="form-control" type="file">
	    </div>
	  </div>
	
	  <div class="form-group">
	    <label class="control-label" for="email">E-mail:</label>
	    <div class="controls">
	      <input name="email" id="email" class="form-control" type="text">
	    </div>
	  </div>
	
	  <div class="form-group">
	    <label class="control-label" for="emailConfirmation">Confirm e-mail:</label>
	    <div class="controls">
	      <input name="emailConfirmation" id="emailConfirmation" class="form-control" type="text">
	    </div>
	  </div>
	
	  <div class="form-group">
	    <label class="control-label" for="url">Site URL:</label>
	    <div class="controls">
	      <input name="url" id="url" class="form-control" type="text">
	    </div>
	  </div>
	
	  <input class="btn btn-info" type="submit" value="Submit">
	  <input class="btn btn-primary" type="reset" value="Reset">
</form> -->

<!-- <form id="myForm">

  <div class="form-group">
    <label class="control-label" for="name">Name:</label>
    <div class="controls">
      <input name="name" id="name" class="form-control field-required" type="text">
    </div>
  </div>

  <div class="form-group">
    <label class="control-label" for="age">Age:</label>
    <div class="controls">
      <input name="age" id="age" class="form-control field-required field-digits" type="text">
    </div>
  </div>

  <div class="form-group">
    <label class="control-label" for="email">E-mail:</label>
    <div class="controls">
      <input name="email" id="email" class="form-control field-required field-email" type="text">
    </div>
  </div>

  <input class="btn btn-info" type="submit" value="Submit">
  <input class="btn btn-primary" type="reset" value="Reset">

</form>
 -->


<fieldset class="fieldset ">
	<legend class="fieldset-legend">
		<span class="legend"> Suggestions </span>
	</legend>
	<div class="">
		<p class="description">Your input is valuable to us. Please send
			us your suggestions.</p>

		<div
			id="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_fieldOptionalErrorfield1"
			class="hide">
			<span class="alert alert-error">Este campo es obligatorio.</span>
		</div>
		<div class="control-group">
			<label for="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field1"
				class="control-label"> Name </label> <input type="text" value=""
				name="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field1"
				id="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field1"
				class="field">
		</div>

		<div
			id="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_fieldOptionalErrorfield2"
			class="hide">
			<span class="alert alert-error">Este campo es obligatorio.</span>
		</div>
		<div class="control-group">
			<label for="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field2"
				class="control-label"> Rating </label> <select
				name="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field2"
				id="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field2"
				class="aui-field-select">
				<option value="Excellent" class="">Excellent</option>
				<option value="Good" class="">Good</option>
				<option value="Satisfactory" class="">Satisfactory</option>
				<option value="Poor" class="">Poor</option>
			</select>
		</div>
		<div
			id="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_fieldOptionalErrorfield3"
			class="hide">
			<span class="alert alert-error">Este campo es obligatorio.</span>
		</div>
		<div class="control-group">
			<label for="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field3"
				class="control-label"> Comments </label>
			<textarea wrap="soft"
				name="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field3"
				id="_1_WAR_webformportlet_INSTANCE_MJXk0c9wO9ul_field3"
				class="field lfr-textarea-container"></textarea>
		</div>
		<button type="submit" class="btn btn-primary">Enviar</button>
	</div>
</fieldset>