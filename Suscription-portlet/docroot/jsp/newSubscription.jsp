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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.liferay.portal.theme.ThemeDisplay" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="ProcessorMDTR.saveSubscription.SubscriptionDAOException" message="error.ProcessorMDTR.saveSubscription.SubscriptionDAOException" />
<% 
	Calendar calendar = GregorianCalendar.getInstance();
	Calendar cal = CalendarFactoryUtil.getCalendar(calendar.getTimeZone());
	
	SubscriptionVO subscriptionVO = (SubscriptionVO)session.getAttribute("subscriptionVO");
	ArrayList<PlanVO> listPlans = (ArrayList<PlanVO>)session.getAttribute("listPlans");
	
	if(subscriptionVO == null) {
		System.out.println("subscriptionVO: " + subscriptionVO);
		subscriptionVO = new SubscriptionVO();
		subscriptionVO.setStart(Utilities.getCurrentDate());
		subscriptionVO.setEndedAt(Utilities.getCurrentDate());
		subscriptionVO.setCanceledAt(Utilities.getCurrentDate());
		subscriptionVO.setCurrentPeriodStart(Utilities.getCurrentDate());
		subscriptionVO.setCurrentPeriodEnd(Utilities.getCurrentDate());
		subscriptionVO.setTrialStart(Utilities.getCurrentDate());
		subscriptionVO.setTrialEnd(Utilities.getCurrentDate());
	}
	
	Calendar startCalendar = Utilities.getCalendarDateSimple(subscriptionVO.getStart());
	Calendar endedAtCalendar = Utilities.getCalendarDateSimple(subscriptionVO.getEndedAt());
	Calendar canceledAtCalendar = Utilities.getCalendarDateSimple(subscriptionVO.getCanceledAt());
	Calendar currentPeriodStartCalendar = Utilities.getCalendarDateSimple(subscriptionVO.getCurrentPeriodStart());
	Calendar currentPeriodEndCalendar = Utilities.getCalendarDateSimple(subscriptionVO.getCurrentPeriodEnd());
	Calendar trialStartCalendar = Utilities.getCalendarDateSimple(subscriptionVO.getTrialStart());
	Calendar trialEndCalendar = Utilities.getCalendarDateSimple(subscriptionVO.getTrialEnd());
	
%>
<portlet:actionURL name="saveSubscription" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitForm %>" method="post">
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.informationSubscription"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="plan" helpMessage="help.plan"  label="label.plan" id="plan">
						<c:forEach var="planVO" items="${listPlans}">
							<aui:option value="${planVO.id}" label="${planVO.name}" selected="${planVO.id==subscriptionVO.planId}"/>
						</c:forEach>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select label="label.cancelAtPeriodEnd" name="cancelAtPeriodEnd" helpMessage="label.cancelAtPeriodEnd" id="cancelAtPeriodEnd">
						<aui:option value="0" label="True" selected="${subscriptionVO.cancelAtPeriodEnd=='0'}"/>
						<aui:option value="1" label="False" selected="${subscriptionVO.cancelAtPeriodEnd=='1'}"/>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.quantity" helpMessage="help.quantity" showRequiredLabel="false" size="3" type="text" required="true" name="quantity" value="${subscriptionVO.quantity}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select label="label.status" name="status" helpMessage="help.status" id="status">
							<aui:option value="Trialing" label="Trialing" selected="${subscriptionVO.status=='Trialing'}"/>
							<aui:option value="Active" label="Active" selected="${subscriptionVO.status=='Active'}"/>
							<aui:option value="Past_due" label="Past_due" selected="${subscriptionVO.status=='Past_due'}"/>
							<aui:option value="Canceled" label="Canceled" selected="${subscriptionVO.status=='Canceled'}"/>
							<aui:option value="Unpaid" label="Unpaid" selected="${subscriptionVO.status=='Unpaid'}"/>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.applicationFeePercent" helpMessage="help.applicationFeePercent" showRequiredLabel="false" type="text" required="true" name="applicationFeePercent" value="${subscriptionVO.applicationFeePercent}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<span class="aui-field aui-field-select aui-field-menu"> 
						<span class="aui-field-content"> 
							<label for="start" class="aui-field-label"><fmt:message key="label.start"/>
								<span class="taglib-icon-help">
										<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
									<span id="helpStart" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.start"/></span>
								</span>
							</label>							
							<span class="aui-field-element "> 
								<liferay-ui:input-date  formName="start" dayParam="startDay" dayValue="<%= startCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
							    	monthParam="startMonth" monthValue="<%= startCalendar.get(Calendar.MONTH) %>" yearParam="startYear" yearValue="<%= startCalendar.get(Calendar.YEAR) %>"
							    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
							</span>
						</span>
					</span>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<span class="aui-field aui-field-select aui-field-menu"> 
						<span class="aui-field-content"> 
							<label for="endedAt" class="aui-field-label"><fmt:message key="label.endedAt"/>
								<span class="taglib-icon-help">
									<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
									<span id="helpEndedAt" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.endedAt"/></span>
								</span>
							</label>
							<span class="aui-field-element "> 
								<liferay-ui:input-date formName="endedAt" dayParam="endedAtDay" dayValue="<%= endedAtCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
							    	monthParam="endedAtMonth" monthValue="<%= endedAtCalendar.get(Calendar.MONTH) %>" yearParam="endedAtYear" yearValue="<%= endedAtCalendar.get(Calendar.YEAR) %>"
							    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
							</span>
						</span>
					</span>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<span class="aui-field aui-field-select aui-field-menu"> 
						<span class="aui-field-content"> 
							<label for="canceledAt" class="aui-field-label"><fmt:message key="label.canceledAt"/>
								<span class="taglib-icon-help">
									<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
									<span id="helpCanceledAt" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.canceledAt"/></span>
								</span>
							</label>
							<span class="aui-field-element "> 
								<liferay-ui:input-date  formName="canceledAt" dayParam="canceledAtDay" dayValue="<%= canceledAtCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
							    	monthParam="canceledAtMonth" monthValue="<%= canceledAtCalendar.get(Calendar.MONTH) %>" yearParam="canceledAtYear" yearValue="<%= canceledAtCalendar.get(Calendar.YEAR) %>"
							    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
							</span>
						</span>
					</span>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<span class="aui-field aui-field-select aui-field-menu"> 
						<span class="aui-field-content"> 
							<label for="currentPeriodStart" class="aui-field-label"><fmt:message key="label.currentPeriodStart"/>
								<span class="taglib-icon-help">
									<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
									<span id="helpCurrentPeriodStart" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.currentPeriodStart"/></span>
								</span>
							</label>
							<span class="aui-field-element "> 
								<liferay-ui:input-date  formName="currentPeriodStart" dayParam="currentPeriodStartDay" dayValue="<%= currentPeriodStartCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
							    	monthParam="currentPeriodStartMonth" monthValue="<%= currentPeriodStartCalendar.get(Calendar.MONTH) %>" yearParam="currentPeriodStartYear" yearValue="<%= currentPeriodStartCalendar.get(Calendar.YEAR) %>"
							    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
							</span>
						</span>
					</span>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<span class="aui-field aui-field-select aui-field-menu"> 
						<span class="aui-field-content"> 
							<label for="currentPeriodEnd" class="aui-field-label"><fmt:message key="label.currentPeriodEnd"/>
								<span class="taglib-icon-help">
									<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
									<span id="helpCurrentPeriodEnd" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.currentPeriodEnd"/></span>
								</span>
							</label>
							<span class="aui-field-element "> 
								<liferay-ui:input-date formName="currentPeriodEnd" dayParam="currentPeriodEndDay" dayValue="<%= currentPeriodEndCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
							    	monthParam="currentPeriodEndMonth" monthValue="<%= currentPeriodEndCalendar.get(Calendar.MONTH) %>" yearParam="currentPeriodEndYear" yearValue="<%= currentPeriodEndCalendar.get(Calendar.YEAR) %>"
							    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
							</span>
						</span>
					</span>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<span class="aui-field aui-field-select aui-field-menu"> 
						<span class="aui-field-content"> 
							<label for="trialStart" class="aui-field-label"><fmt:message key="label.trialStart"/>
								<span class="taglib-icon-help">
									<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
									<span id="helpTrialStart" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.trialStart"/></span>
								</span>
							</label>
							<span class="aui-field-element "> 
								<liferay-ui:input-date formName="trialStart" dayParam="trialStartDay" dayValue="<%= trialStartCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
							    	monthParam="trialStartMonth" monthValue="<%= trialStartCalendar.get(Calendar.MONTH) %>" yearParam="trialStartYear" yearValue="<%= trialStartCalendar.get(Calendar.YEAR) %>"
							    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
							</span>
						</span>
					</span>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<span class="aui-field aui-field-select aui-field-menu"> 
						<span class="aui-field-content"> 
							<label for="trialEnd" class="aui-field-label"><fmt:message key="label.trialEnd"/>
								<span class="taglib-icon-help">
									<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
									<span id="helpTrialEnd" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.trialEnd"/></span>
								</span>
							</label>
							<span class="aui-field-element "> 
								<liferay-ui:input-date formName="trialEnd" dayParam="trialEndDay" dayValue="<%= trialEndCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
							    	monthParam="trialEndMonth" monthValue="<%= trialEndCalendar.get(Calendar.MONTH) %>" yearParam="trialEndYear" yearValue="<%= trialEndCalendar.get(Calendar.YEAR) %>"
							    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
							</span>
						</span>
					</span>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.taxPercent" helpMessage="help.taxPercent" showRequiredLabel="false" type="text" required="false" name="taxPercent" value="${subscriptionVO.taxPercent}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
			</div>
			<div class="row">
				<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
				<div class="column2-2">
					<aui:button type="submit" name="save" value="label.save" />
				</div>
			</div>
		</div>
	</div>
</aui:form>