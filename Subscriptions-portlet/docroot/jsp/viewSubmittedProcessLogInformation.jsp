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
<%-- <%@ include file="init.jsp" %> --%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="co"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util"%>
<%@taglib uri="http://www.billingbuddy.com/.com/bbtlds" prefix="Utils" %>

<%@ page import="com.liferay.portal.kernel.json.JSONFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.json.JSONObject" %>
<%@ page import="au.com.billingbuddy.vo.objects.SubmittedProcessLogVO" %>


<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@taglib uri="http://www.billingbuddy.com/.com/bbtlds" prefix="Utils" %>
<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<%
	SubmittedProcessLogVO submittedProcessLogVO = (SubmittedProcessLogVO)session.getAttribute("submittedProcessLogVO");

	pageContext.setAttribute("submittedProcessLogVO", submittedProcessLogVO);
	JSONObject informationJSON = JSONFactoryUtil.createJSONObject(submittedProcessLogVO.getInformation());
	
	/* boolean ReprocessUnpaids = Boolean.parseBoolean(informationJSON.getString("ReprocessUnpaids")); */
	boolean ReprocessErrorFile = Boolean.parseBoolean(informationJSON.getString("ReprocessErrorFile"));
	
	/* System.out.println("ReprocessUnpaids: " + ReprocessUnpaids); */
	System.out.println("ReprocessErrorFile: " + ReprocessErrorFile);
	
	System.out.println("\nInfomracion:\n " + informationJSON.toString());
	
	informationJSON.remove("ReprocessErrorFile"); 
	String errorFileLocation = null;
%>
<portlet:resourceURL var="reprocessErrorFile">
	<portlet:param name="action" value="reprocessErrorFile" />
</portlet:resourceURL>

<fieldset class="fieldset">
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
			<% if(ReprocessErrorFile){%>
				<p id="sub-legend" class="description"><fmt:message key="label.processActions"/></p>
				<hr>
					<fieldset>
						<div id="msgid"></div>
						<div id="alertReprocessFile" class="alert alert-error"><fmt:message key="label.alertReprocessFile"/></div>
						<div id="ProcessActionsContainer" class="btn-toolbar well clearfix">
							<div class="btn-group scheduler-job-actions pull-left">
								<button class="btn btn-large btn-primary icon-play" id="reprocessErrorFile" onclick="" name="reprocessErrorFile" type="button" value="reprocessErrorFile">&nbsp;<fmt:message key="label.reprocessErrorFile"/></button>
							</div>	
						</div>
					</fieldset>
			<%errorFileLocation = informationJSON.getJSONObject("InformationErrorFileExist").getString("FileLocation");}%>
			<p id="sub-legend" class="description"><fmt:message key="label.processInformation"/></p>
			<hr>
			<div id="contenedor">
				 <pre id="processInformation"></pre>
			</div>
			
		</div>
	</div>
</fieldset>

<aui:script>
$('#processInformation').jsonViewer(<%=informationJSON.toString()%>);
/* YUI().use("node", "io", "dump", "json-parse","json-stringify", function (Y) {
	var target = Y.one('#processInformation');
	var processInformation = <%=submittedProcessLogVO.getInformation()%>
    var jsonStr = Y.JSON.stringify(processInformation,null,4);
    alert(jsonStr);
    target.setHTML(jsonStr);
    target.jsonViewer(jsonStr);
}); */
</aui:script>

<script>
	YUI().use('json-parse','io','event', function (Y) {
		Y.one("#reprocessErrorFile").on("click", function (e) {	
			Y.io('<%=reprocessErrorFile%>', {
			    method: 'POST', 
			    data: {<portlet:namespace/>errorFileLocation: "<%=errorFileLocation%>", <portlet:namespace/>idSubmittedProcessLog:"<%=submittedProcessLogVO.getId()%>"},
			    on: { 
			    	start: function(id, response) {
			    		$("#msgid").attr("class", "alert alert-error");	
			    		$("#msgid").html("Starting reprocessing process. Please wait.");
			    	},
			    	success: function(id, response) {
			    		var json = Y.JSON.parse(response.responseText);
			    		/* alert(response.responseText); */
			    		if(json.answer){
			    			$("#msgid").attr("class", "alert alert-success");
			    			$("#msgid").html('<fmt:message key="label.successReprocessErrorFile"/>');
			    		} else { 
			    			$("#msgid").attr("class", "alert alert-error");
			    			if(json.errorType='noRegistriesUpdated') $("#msgid").html('<fmt:message key="label.noRegistriesUpdated"/>');
			    			else $("#msgid").html('<fmt:message key="label.unsuccessReprocessErrorFile"/>');
			    		}
			    		if(json.detail){
			    			$("#msgid").append("<br><fmt:message key="label.errorDetails"/>: "+json.detail);
			    		}
			    		
			    		$("#msgid").append("<br><fmt:message key="label.totalRegistries"/>: "+json.totalRegistries);
			    		$("#msgid").append("<br><fmt:message key="label.processed"/>: "+json.processed);
			    		$("#msgid").append("<br><fmt:message key="label.unProcessed"/>: "+json.unProcessed);
			    		
			    		if(json.answer){
			    			$("#alertReprocessFile").remove();
				    		$("#ProcessActionsContainer").remove();
			    			$("#processInformation").jsonViewer(Y.JSON.parse(json.informacion));
			    		}
			    		/*$("#alertReprocessFile").remove();
			    		$("#ProcessActionsContainer").remove(); */
			    		
			    		/* $("#msgid").attr("class", "alert alert-success");
			    		$("#msgid").html("The reprocessing process has finished. Thanks for waiting."); */
			    		
			    		/* if(json.claro){
			    			alert("claro Existe ...");
			    		}else{
			    			alert("claro No Existe ...");
			    		}
			    		if(json.detail){
			    			alert("detail Existe ...");
			    		}else{
			    			alert("detail No Existe ...");
			    		}
			    		alert(json.answer);
			    		alert(json.detail); */
			    		/* alert(response.statusText)
			        	alert(response.getAllResponseHeaders())
			        	alert(response.responseText)
			        	alert(response.responseXML) */
			    		/* alert(Y.JSON.parse(response.responseText)); */
			    		
			    	},
			    	complete: function (id, response) {
			        },
			        end: function(id, response) {
		            },
			        failure: function(id, response) {
			        	$("#msgid").attr("class", "alert alert-error");
			        	$("#msgid").html("A problem has been detected. Check the system log.");
			        	/* alert(Y.JSON.parse(response)); */
			        	/* alert(response.status)
			        	alert(response.statusText)
			        	alert(response.getAllResponseHeaders())
			        	alert(response.responseText)
			        	alert(response.responseXML) */
			        	
			        	/* alert(Y.JSON.parse(response.responseText));
			        	alert((response)); */
		            }
			    }
			});
		});
	});
</script>
