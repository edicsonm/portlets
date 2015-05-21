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
<%@taglib uri="http://www.billingbuddy.com/.com/bbtlds" prefix="Utils" %>
<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<%
	
	String idSubmittedProcessLog = (String)request.getParameter("idSubmittedProcessLog");
	
	SubmittedProcessLogVO submittedProcessLogVO = new SubmittedProcessLogVO();
	submittedProcessLogVO.setId(idSubmittedProcessLog);
	
	ArrayList<SubmittedProcessLogVO> listSubmittedProcessLogs = (ArrayList<SubmittedProcessLogVO>)session.getAttribute("listSubmittedProcessLogs");
	int indiceSubmittedProcessLog = listSubmittedProcessLogs.indexOf(submittedProcessLogVO);
	submittedProcessLogVO = (SubmittedProcessLogVO)listSubmittedProcessLogs.get(indiceSubmittedProcessLog);
	pageContext.setAttribute("submittedProcessLogVO", submittedProcessLogVO);
	JSONObject informationJSON = JSONFactoryUtil.createJSONObject(submittedProcessLogVO.getInformation());
	
	/* boolean ReprocessUnpaids = Boolean.parseBoolean(informationJSON.getString("ReprocessUnpaids")); */
	boolean ReprocessErrorFile = Boolean.parseBoolean(informationJSON.getString("ReprocessErrorFile"));
	
	/* System.out.println("ReprocessUnpaids: " + ReprocessUnpaids); */
	System.out.println("ReprocessErrorFile: " + ReprocessErrorFile);
	
	/* if(ReprocessUnpaids)informationJSON.remove("ReprocessUnpaids"); */
	if(ReprocessErrorFile)informationJSON.remove("ReprocessErrorFile");
	String errorFileLocation = null;
%>
<portlet:renderURL var="goBackSubmittedProcessLog">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<portlet:resourceURL var="reprocessErrorFile"/>

<aui:form method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.submittedProcessLogDetails"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="details">
				<%-- <p id="sub-legend" class="description"><fmt:message key="label.paymentDetails"/></p> --%>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.processName"/></dt>
								<dd><c:out value="${submittedProcessLogVO.processName}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.statusProcess"/></dt>
								<dd><c:out value="${submittedProcessLogVO.statusProcess}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.startTime"/></dt>
								<dd><c:out value="${submittedProcessLogVO.startTime}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.endTime"/></dt>
								<dd><c:out value="${submittedProcessLogVO.endTime}"/></dd>
							</dl>
						</div>
					</div>
				</div>
				<p id="sub-legend" class="description"><fmt:message key="label.processActions"/></p>
				<hr>
					<div id="msgid"></div>
					<fieldset>
						<% if(ReprocessErrorFile){%>
						<div class="alert alert-error"><fmt:message key="label.alertReprocessFile"/></div>
						<div id="ProcessActionsContainer" class="btn-toolbar well clearfix">
							<div class="btn-group scheduler-job-actions pull-left">
								<button class="btn btn-large btn-primary icon-play" id="reprocessErrorFile" onclick="" name="reprocessErrorFile" type="button" value="reprocessErrorFile">&nbsp;<fmt:message key="label.reprocessErrorFile"/></button>
							</div>	
						</div>
						<% 
							errorFileLocation = informationJSON.getJSONObject("InformationErrorFileExist").getString("FileLocation");
						}%>
						<%-- <div id="ProcessActionsContainer" class="btn-toolbar well clearfix">
							<% if(ReprocessUnpaids){%>
								<div class="btn-group scheduler-job-actions pull-left">
									<button class="btn btn-large btn-primary icon-play" id="reprocessUnpaids" onclick="" name="reprocessUnpaids" type="button" value="reprocessUnpaids">&nbsp;<fmt:message key="label.reprocessUnpaids"/></button>
								</div>
							<% }%>
							<% if(ReprocessErrorFile){%>
								<div class="btn-group scheduler-job-actions pull-left">
									<button class="btn btn-large btn-primary icon-play" id="reprocessErrorFile" onclick="" name="reprocessErrorFile" type="button" value="reprocessErrorFile">&nbsp;<fmt:message key="label.reprocessErrorFile"/></button>
								</div>	
							<% }%>
						</div> --%>
					</fieldset>
				
				<p id="sub-legend" class="description"><fmt:message key="label.processInformation"/></p>
				<hr>
				<div id="contenedor">
					 <pre id="processInformation"></pre>
					 <!-- <div id="processInformation"></div> -->
				</div>
				
			</div>
			<a href="<%= goBackSubmittedProcessLog %>"><fmt:message key="label.goBack"/></a>
		</div>
	</fieldset>
</aui:form>
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
			/* Y.io.postJSON */
			<%--  Y.io.postJSON('<%=reprocessErrorFile%>', {  --%>
			    method: 'POST', 
			   /*  headers: {'Content-Type': 'application/json'}, */
			    data: {<portlet:namespace/>errorFileLocation: "<%=errorFileLocation%>", <portlet:namespace/>idSubmittedProcessLog:"<%=submittedProcessLogVO.getId()%>"},
			    on: { 
			    	start: function(id, response) {
			    		$("#msgid").attr("class", "alert alert-error");	
			    		$("#msgid").html("Starting reprocessing process. Please wait.");
			    	},
			    	success: function(id, response) {
			    		var json = Y.JSON.parse(response.responseText);
			    		if(json.answer){
			    			$("#msgid").attr("class", "alert alert-success");
			    			$("#msgid").html('<fmt:message key="label.successReprocessErrorFile"/>');
			    		} else { 
			    			$("#msgid").attr("class", "alert alert-error");
			    			$("#msgid").html('<fmt:message key="label.unsuccessReprocessErrorFile"/>');
			    		}
			    		if(json.detail){
			    			$("#msgid").append("<br>"+json.detail);
			    		}
			    		
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

