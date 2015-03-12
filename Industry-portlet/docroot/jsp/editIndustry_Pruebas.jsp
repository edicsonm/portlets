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
YUI().use(
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
		      name: {
		        /* rangeLength: [2, 50], */
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
		      name: {
		        required: 'Please provide your name.'
		      }
		    };

		    new Y.FormValidator(
		      {
		        boundingBox: '#myForm',
		        fieldStrings: fieldStrings,
		        rules: rules,
		        /* errorClass:'alert alert-error', */
		        /* stackErrorContainer:'errores', */
		        /* messageContainer: '<div class="alert alert-error" role="alert"></div>', */
		        showAllMessages: true
		        
		      }
		    );
		  },
		 alert('sadsa')/* ,
		 Y.one('#name').addFieldError ('errores','name')  */
		);
</aui:script>

<form id="myForm">
<fieldset class="fieldset">
  <div class="">
	  
	  
	<div hidden="true" id="errores" class="form-validator-stack help-inline">
		<span class="alert alert-error">Este campo es obligatorio sadasd .</span>
	</div>
	
	  <div class="control-group">
	  
	  	<div id="" class="form-validator-stack help-inline">
			<div class="required" role="alert">Please provide your name.</div>
		</div>
	  
	    <label class="control-label" for="name">Name:</label>
	    <div class="controls">
	      <input name="name" id="name" class="form-control field-required" type="text">
	    </div>
	  </div>
	
	  <div class="control-group">
	    <label class="control-label" for="picture">Picture:</label>
	    <div class="controls">
	      <input name="picture" id="picture" class="form-control" type="file">
	    </div>
	  </div>
	
	  <div class="control-group">
	    <label class="control-label" for="email">E-mail:</label>
	    <div class="controls">
	      <input name="email" id="email" class="form-control field-required field-email" type="text">
	    </div>
	  </div>
	
	  <div class="control-group">
	    <label class="control-label" for="emailConfirmation">Confirm e-mail:</label>
	    <div class="controls">
	      <input name="emailConfirmation" id="emailConfirmation" class="form-control" type="text">
	    </div>
	  </div>
	
	  <div class="control-group">
	    <label class="control-label" for="url">Site URL:</label>
	    <div class="controls">
	      <input name="url" id="url" class="form-control" type="text">
	    </div>
	  </div>
	
	  <input class="btn btn-info" type="submit" value="Submit">
	  <input class="btn btn-primary" type="reset" value="Reset">
  </div>
</fieldset>
</form>