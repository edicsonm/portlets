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

<% 
	ArrayList<SchedulerResponse> schedulerJobsList = (ArrayList<SchedulerResponse>)SchedulerEngineHelperUtil.getScheduledJobs(SchedulerUtils.BBProcessGroupName,StorageType.MEMORY);
	schedulerJobsList.addAll(SchedulerEngineHelperUtil.getScheduledJobs(SchedulerUtils.BBProcessGroupName,StorageType.MEMORY_CLUSTERED));
	schedulerJobsList.addAll(SchedulerEngineHelperUtil.getScheduledJobs(SchedulerUtils.BBProcessGroupName,StorageType.PERSISTED));	

	/* List<SchedulerResponse> schedulerJobsList = (List<SchedulerResponse>)session.getAttribute("schedulerJobsList"); */
	if(schedulerJobsList == null ) schedulerJobsList = new ArrayList<SchedulerResponse>();
%>
<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLSchedulerJobs" />
<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLSchedulerJobs%>">
	<liferay-ui:search-container-results resultsVar="resultsCards" totalVar="totalCards" results="<%= new ArrayList(ListUtil.subList(schedulerJobsList, searchContainer.getStart(), searchContainer.getEnd()))%>" total="<%=schedulerJobsList.size() %>"/>
	<liferay-ui:search-container-row className="com.liferay.portal.kernel.scheduler.messaging.SchedulerResponse" rowVar="posi" indexVar="indice" keyProperty="jobName" modelVar="schedulerResponse">
		
		<liferay-ui:search-container-column-text name="">
				<%-- <aui:input label="" name="${schedulerResponse.jobName}" type="checkbox"/> --%>
				<aui:input label="" name="<%= String.valueOf(schedulerResponse.hashCode())%>" type="checkbox"/>
		</liferay-ui:search-container-column-text>
		
		<liferay-ui:search-container-column-text name="label.jobName" value="<%=schedulerResponse.getJobName().substring(schedulerResponse.getJobName().lastIndexOf(\".\") + 1, schedulerResponse.getJobName().length()) %>" orderable="false"/>
		<liferay-ui:search-container-column-text name="label.groupName" value="<%=schedulerResponse.getGroupName().substring(schedulerResponse.getGroupName().lastIndexOf(\".\") + 1, schedulerResponse.getGroupName().length()) %>" orderable="false"/>
			<liferay-ui:search-container-column-text name="label.state" value="<%=SchedulerEngineHelperUtil.getJobState(schedulerResponse).toString() %>" orderable="false"/>
			<liferay-ui:search-container-column-text name="label.startTime" value="<%=SchedulerEngineHelperUtil.getStartTime(schedulerResponse).toString() %>" orderable="false"/>
			<liferay-ui:search-container-column-text name="label.endTime" value="<%=SchedulerEngineHelperUtil.getEndTime(schedulerResponse) != null ? SchedulerEngineHelperUtil.getEndTime(schedulerResponse).toString() : \"\" %>" orderable="false"/>
			<liferay-ui:search-container-column-text name="label.previousFireTime" value="<%=SchedulerEngineHelperUtil.getPreviousFireTime(schedulerResponse) != null ? SchedulerEngineHelperUtil.getPreviousFireTime(schedulerResponse).toString() : \"\" %>" orderable="false"/>
			<liferay-ui:search-container-column-text name="label.nextFireTime" value="<%=SchedulerEngineHelperUtil.getNextFireTime(schedulerResponse) != null ? SchedulerEngineHelperUtil.getNextFireTime(schedulerResponse).toString() : \"\" %>" orderable="false"/>
			<liferay-ui:search-container-column-text name="label.storageType" value="<%=schedulerResponse.getStorageType().toString() %>" orderable="false"/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>

