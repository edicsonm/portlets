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
<%-- <liferay-ui:success key="subscriptionSavedSuccessfully" message="label.subscriptionSavedSuccessfully" />
<liferay-ui:success key="subscriptionUpdatedSuccessfully" message="label.subscriptionUpdatedSuccessfully" />
<liferay-ui:success key="subscriptionDeletedSuccessfully" message="label.subscriptionDeletedSuccessfully" /> --%>
<% 
	
	String orderByCol = ParamUtil.getString(request, "orderByCol", "creationTime");
	String orderByType = ParamUtil.getString(request, "orderByType","desc");
	pageContext.setAttribute("orderByCol", orderByCol);
	pageContext.setAttribute("orderByType", orderByType); 

	ArrayList<SubmittedProcessLogVO> listSubmittedProcessLogs = (ArrayList<SubmittedProcessLogVO>)session.getAttribute("listSubmittedProcessLogs");
	if(listSubmittedProcessLogs == null) listSubmittedProcessLogs = new ArrayList<SubmittedProcessLogVO>();
	
	SubmittedProcessLogVO submittedProcessLogVO = (SubmittedProcessLogVO)session.getAttribute("submittedProcessLogVO");
	if(submittedProcessLogVO == null) submittedProcessLogVO = new SubmittedProcessLogVO();
%>
<aui:script>

     YUI().use('aui-datepicker', function(Y) {
 	    new Y.DatePicker(
 	    	{
 	        trigger: '#<portlet:namespace />fromDateProcess',
 	        popover: {
 	          zIndex: 1
 	        }
 	      });
 	  }
 	);
   
   YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	      {
	        trigger: '#<portlet:namespace />toDateProcess',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
     
</aui:script>
   
<portlet:actionURL var="listPlanSubscriptions" name="listPlanSubscriptions"/>
<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLSubmittedProcessLogs"/>

<aui:form method="post">
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationSubmittedProcessLogs"/> </span>
	</legend>
	<div class="">
			<liferay-ui:search-container orderByType="<%=orderByType %>" orderByCol="<%=orderByCol %>" displayTerms="<%= new DisplayTerms(renderRequest) %>" emptyResultsMessage="label.empty" delta="10" iteratorURL="<%=renderURLSubmittedProcessLogs%>">
				<div id="contenedor">
					<div id="contenidos">
						<div id=columna1-3>
							<div class="control-group">
								<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />fromDateSubmittedProcessLogsPicker">
									<aui:input onkeypress="return false;" value="<%= submittedProcessLogVO.getStartTime()%>" label="label.from" helpMessage="help.from" showRequiredLabel="false" size="10" type="text" required="false" name="fromDateProcess">
										 <aui:validator name="date" />
									</aui:input>
								</div>
							</div>
						</div>
						<div id="columna2-3">
							<div class="control-group">
								<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace  />toDateSubmittedProcessLogsPicker">
									<aui:input onkeypress="return false;" value="<%= submittedProcessLogVO.getEndTime()%>" label="label.to" helpMessage="help.to" showRequiredLabel="false" size="10" type="text" required="false" name="toDateProcess">
										 <aui:validator name="date" />
									</aui:input>
								</div>
							</div>
						</div>
						<div id="columna3-3">
							<div class="control-group">
								<liferay-ui:search-form  page="/jsp/submittedProcessLogs_search.jsp" servletContext="<%= application %>"/>
							</div>
						</div>
					</div>
				</div>
				<liferay-ui:search-container-results 
						results="<%=new ArrayList(ListUtil.subList(listSubmittedProcessLogs, searchContainer.getStart(), searchContainer.getEnd()))%>" 
						total="<%= listSubmittedProcessLogs.size()%>">
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.SubmittedProcessLogVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="submittedProcessLogVOAUX">
					
					<liferay-portlet:renderURL varImpl="rowURLSubmittedProcessLog">
							<portlet:param name="idSubmittedProcessLog" value="<%=submittedProcessLogVOAUX.getId()%>"/>
							<portlet:param name="jspPage" value="/jsp/viewSubmittedProcessLog.jsp" />
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.processName" property="processName" orderable="false" orderableProperty="processName" href="<%= rowURLSubmittedProcessLog %>"/>
					<liferay-ui:search-container-column-text name="label.startTime" property="startTime" orderable="false" orderableProperty="startTime"/>
					<liferay-ui:search-container-column-text name="label.endTime" value="${Utils:printString(submittedProcessLogVOAUX.endTime)}" orderable="false" orderableProperty="endTime"/>
					<liferay-ui:search-container-column-text name="label.statusProcess" property="statusProcess" orderable="false" orderableProperty="statusProcess"/>
					
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</div>
</fieldset>
</aui:form>