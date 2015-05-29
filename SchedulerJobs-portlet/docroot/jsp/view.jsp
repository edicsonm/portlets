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

<%@ page import="java.util.ArrayList" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>

<liferay-ui:success key="jobPausedSuccessfully" message="label.jobPausedSuccessfully" />
<liferay-ui:success key="jobResumedSuccessfully" message="label.jobResumedSuccessfully" />
<liferay-ui:success key="jobUnscheduleSuccessfully" message="label.jobUnscheduledSuccessfully" />
<liferay-ui:success key="jobDeletedSuccessfully" message="label.jobDeletedSuccessfully" />
<liferay-ui:success key="jobShutDownedSuccessfully" message="label.jobShutDownedSuccessfully" />

<liferay-ui:error key="ProcessorMDTR.deleteMerchantRestriction.MerchantRestrictionDAOException" message="error.ProcessorMDTR.deleteMerchantRestriction.MerchantRestrictionDAOException" />

<%--<liferay-ui:success key="merchantRestrictionDeletedSuccessfully" message="label.merchantRestrictionDeletedSuccessfully" />
<liferay-ui:success key="updateStatusMerchantRestriction.Activate" message="label.updateStatusMerchantRestriction.Activate" />
<liferay-ui:success key="updateStatusMerchantRestriction.Inactivate" message="label.updateStatusMerchantRestriction.Inactivate" /> --%>


<% 
	List<SchedulerResponse> schedulerJobsList = (List<SchedulerResponse>)session.getAttribute("schedulerJobsList");
	if(schedulerJobsList == null ) schedulerJobsList = new ArrayList<SchedulerResponse>();
	/* System.out.println("schedulerJobsList " + schedulerJobsList);
	System.out.println("schedulerJobsList.size() " + schedulerJobsList.size()); */
%>

<portlet:resourceURL var="listScheduledJobs">
	<portlet:param name="action" value="listScheduledJobs" />
    <portlet:param name="jspPage" value="/jsp/scheduledJobs.jsp" />
</portlet:resourceURL>

<portlet:renderURL var="addScheduledJob" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="mvcPath" value="/jsp/addScheduledJob.jsp" />
	<portlet:param name="accion" value="addScheduledJob"/>
</portlet:renderURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLSchedulerJobs" />

<portlet:actionURL name="jobAction" var="submitForm">
	<portlet:param name="accion" value="addSubscription" />
</portlet:actionURL>

<aui:script>
AUI().use(
		'aui-base',
		'aui-io-plugin-deprecated',
		'liferay-util-window',
		'aui-dialog-iframe-deprecated',
		function(A) {
			A.one('#<portlet:namespace />addScheduledJob').on('click',
					function(event) {
						var popUpWindow = Liferay.Util.Window.getWindow(
										{
											dialog : {
												centered : true,
												constrain2view : true,
												//cssClass: 'yourCSSclassName',
												modal : true,
												resizable : false,
												width : 700,
												height: 470
											}
										}).plug(
										A.Plugin.DialogIframe,
										{
											autoLoad : true,
											iframeCssClass : 'dialog-iframe',
											uri : '<%=addScheduledJob.toString()%>'
										}).render();
						popUpWindow.show();
						popUpWindow.titleNode.html('<fmt:message key="label.addScheduledJob"/>');
						/* popUpWindow.io.start(); */
					});
				});
</aui:script>

<%-- <aui:form name ="jobsActionsForm" action="${jobActionURL}" method="post"> --%>
<aui:form name ="jobsActionsForm" action="<%=submitForm %>" method="post">

<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationSchedulerJobs"/> </span>
	</legend>
	<aui:input type="hidden" name="jobAction" id ="jobAction" value="pruebita"></aui:input>
	
	<fieldset>
	
		<div class="portlet-msg-alert"><liferay-ui:message key="label.alertManipulateSchedulerJobs"/></div>
	
		<div id="schedulerJobsContainer" class="btn-toolbar well clearfix">
			<div class="btn-group scheduler-job-actions pull-left">
				<button class="btn btn-large btn-primary icon-play" id="resume" onclick="" name="resume" type="button" value="Resume">&nbsp;Resume</button>
				<button class="btn btn-large btn-info icon-pause" id="pause" name="pause" type="button" value="pause">&nbsp;Pause</button>
				<button class="btn btn-large btn-warning icon-stop" id="unschedule" name="unschedule" type="button" value="unschedule">&nbsp;Unschedule</button>
			</div>
			<div class="btn-group refresh pull-right">
				<!-- <button class="btn btn-large btn-danger icon-off" id="shutdown" type="button" value="shutdown">&nbsp;Shutdown</button> -->
				<button class="btn btn-large btn-danger icon-off" id="delete" name="delete" type="button" value="delete">&nbsp;Delete</button>
				<button class="btn btn-large btn-success icon-refresh" id="refresh" name="refresh" type="button" value="refresh">&nbsp;Refresh</button>
			</div>
			<div class="btn-group refresh pull-right clearfix"></div>
		</div>
	</fieldset>
	<div class="">
		<div id="contenedor">
			<div id="divScheduledJobs">
				<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLSchedulerJobs%>">
					<liferay-ui:search-container-results resultsVar="resultsCards" totalVar="totalCards" results="<%= new ArrayList(ListUtil.subList(schedulerJobsList, searchContainer.getStart(), searchContainer.getEnd()))%>" total="<%=schedulerJobsList.size() %>"/>
					<liferay-ui:search-container-row className="com.liferay.portal.kernel.scheduler.messaging.SchedulerResponse" rowVar="posi" indexVar="indice" keyProperty="jobName" modelVar="schedulerResponse">
						
						<liferay-ui:search-container-column-text name="">
								<aui:input label="" name="<%= String.valueOf(schedulerResponse.hashCode())%>" type="checkbox"/>
						</liferay-ui:search-container-column-text>
						
						<liferay-ui:search-container-column-text name="label.jobName" value="<%=schedulerResponse.getJobName().substring(schedulerResponse.getJobName().lastIndexOf(\".\") + 1, schedulerResponse.getJobName().length()) %>" orderable="false"/>
						<liferay-ui:search-container-column-text name="label.groupName" value="<%=schedulerResponse.getGroupName().substring(schedulerResponse.getGroupName().lastIndexOf(\".\") + 1, schedulerResponse.getGroupName().length()) %>" orderable="false"/>
	 					<liferay-ui:search-container-column-text name="label.state" value="<%=SchedulerEngineHelperUtil.getJobState(schedulerResponse).toString() %>" orderable="false"/>
	 					<liferay-ui:search-container-column-text name="label.startTime" value="<%=SchedulerEngineHelperUtil.getStartTime(schedulerResponse) != null ? SchedulerEngineHelperUtil.getStartTime(schedulerResponse).toString():\"\" %>" orderable="false"/>
	 					<liferay-ui:search-container-column-text name="label.endTime" value="<%=SchedulerEngineHelperUtil.getEndTime(schedulerResponse) != null ? SchedulerEngineHelperUtil.getEndTime(schedulerResponse).toString() : \"\" %>" orderable="false"/>
	 					<liferay-ui:search-container-column-text name="label.previousFireTime" value="<%=SchedulerEngineHelperUtil.getPreviousFireTime(schedulerResponse) != null ? SchedulerEngineHelperUtil.getPreviousFireTime(schedulerResponse).toString() : \"\" %>" orderable="false"/>
	 					<liferay-ui:search-container-column-text name="label.nextFireTime" value="<%=SchedulerEngineHelperUtil.getNextFireTime(schedulerResponse) != null ? SchedulerEngineHelperUtil.getNextFireTime(schedulerResponse).toString() : \"\" %>" orderable="false"/>
	 					<liferay-ui:search-container-column-text name="label.storageType" value="<%=schedulerResponse.getStorageType().toString() %>" orderable="false"/>
					</liferay-ui:search-container-row>
					<liferay-ui:search-iterator />
				</liferay-ui:search-container>
			</div>
		</div>
		<button type="button" name="<portlet:namespace />addScheduledJob" id="<portlet:namespace />addScheduledJob" class="btn btn-primary"><liferay-ui:message key="label.addScheduledJob"/></button>
	</div>
</fieldset>	
</aui:form>

<aui:script use ="scheduledjobutil">
	A.scheduledjobutil.setPortletNamespace('<portlet:namespace/>');
	A.all('#schedulerJobsContainer :button').on('click',A.scheduledjobutil.actionButtonHandler);
</aui:script>

<aui:script use="aui-base"> 
	window.rechargeScheduledJobs = function() {
		$("#divScheduledJobs").load("<%= listScheduledJobs%>");
	};
</aui:script>