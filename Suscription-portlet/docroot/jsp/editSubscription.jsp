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

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="ProcessorMDTR.updateSubscription.SubscriptionDAOException" message="error.ProcessorMDTR.updateSubscription.SubscriptionDAOException" />
<%
	Calendar calendar = GregorianCalendar.getInstance();
	Calendar cal = CalendarFactoryUtil.getCalendar(calendar.getTimeZone());
	SubscriptionVO subscriptionVO = (SubscriptionVO)session.getAttribute("subscriptionVO");
	request.setAttribute("subscriptionVO", subscriptionVO);
	ArrayList<PlanVO> listPlans = (ArrayList<PlanVO>)session.getAttribute("listPlans");
%>
<aui:script>
    
  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />startAt',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);

  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />endedAt',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	); 

  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />canceledAt',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	); 

  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />currentPeriodStart',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	); 
  
  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />currentPeriodEnd',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
  
  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />trialStartDay',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
  
  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />trialEndDay',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
</aui:script>

<portlet:actionURL name="editSubscription" var="editURLSubscription">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackSubscription">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form  action="<%= editURLSubscription %>" method="post">
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationSubscription"/> </span>
	</legend>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		
		<div class="control-group">
			<aui:select name="plan" helpMessage="help.plan"  label="label.plan" id="plan">
				<c:forEach var="planVO" items="${listPlans}">
					<aui:option value="${planVO.id}" label="${planVO.name}" selected="${planVO.id==subscriptionVO.planId}"/>
				</c:forEach>
			</aui:select>
		</div>
		<div class="control-group">
			<aui:select label="label.cancelAtPeriodEnd" name="cancelAtPeriodEnd" helpMessage="label.cancelAtPeriodEnd" id="cancelAtPeriodEnd">
				<aui:option value="0" label="True" selected="${subscriptionVO.cancelAtPeriodEnd=='0'}"/>
				<aui:option value="1" label="False" selected="${subscriptionVO.cancelAtPeriodEnd=='1'}"/>
			</aui:select>
		</div>
		<div class="control-group">
			<aui:input label="label.quantity" helpMessage="help.quantity" showRequiredLabel="false" size="3" type="text" required="true" name="quantity" value="${subscriptionVO.quantity}">
				<aui:validator name="digits"/>
			</aui:input>
		</div>
		<div class="control-group">
			<aui:select label="label.status" name="status" helpMessage="help.status" id="status">
					<aui:option value="Trialing" label="Trialing" selected="${subscriptionVO.status=='Trialing'}"/>
					<aui:option value="Active" label="Active" selected="${subscriptionVO.status=='Active'}"/>
					<aui:option value="Past_due" label="Past_due" selected="${subscriptionVO.status=='Past_due'}"/>
					<aui:option value="Canceled" label="Canceled" selected="${subscriptionVO.status=='Canceled'}"/>
					<aui:option value="Unpaid" label="Unpaid" selected="${subscriptionVO.status=='Unpaid'}"/>
			</aui:select>
		</div>
		<div class="control-group">
			<aui:input label="label.applicationFeePercent" helpMessage="help.applicationFeePercent" showRequiredLabel="false" type="text" required="true" name="applicationFeePercent" value="${subscriptionVO.applicationFeePercent}">
				<aui:validator name="digits"/>
			</aui:input>
		</div>
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />startPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.start,6)}"  label="label.start" helpMessage="help.start" showRequiredLabel="false" size="10" type="text" required="true" name="startAt">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />endedAtPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.endedAt,6)}"  label="label.endedAt" helpMessage="help.endedAt" showRequiredLabel="false" size="10" type="text" required="true" name="endedAt">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />canceledAtPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.canceledAt,6)}" label="label.canceledAt" helpMessage="help.canceledAt" showRequiredLabel="false" size="10" type="text" required="true" name="canceledAt">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />currentPeriodStartPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.currentPeriodStart,6)}" label="label.currentPeriodStart" helpMessage="help.currentPeriodStart" showRequiredLabel="false" size="10" type="text" required="true" name="currentPeriodStart">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />currentPeriodEndPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.currentPeriodEnd,6)}" label="label.currentPeriodEnd" helpMessage="help.currentPeriodEnd" showRequiredLabel="false" size="10" type="text" required="true" name="currentPeriodEnd">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		
		
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />trialStartPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.trialStart,6)}" label="label.trialStart" helpMessage="help.trialStart" showRequiredLabel="false" size="10" type="text" required="true" name="trialStartDay">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />trialEndPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.currentPeriodEnd,6)}"  label="label.trialEnd" helpMessage="help.trialEnd" showRequiredLabel="false" size="10" type="text" required="true" name="trialEndDay">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		<div class="control-group">
			<aui:input label="label.taxPercent" helpMessage="help.taxPercent" showRequiredLabel="false" type="text" required="false" name="taxPercent" value="${subscriptionVO.taxPercent}">
				<aui:validator name="digits"/>
			</aui:input>
		</div>
		<a href="<%= goBackSubscription %>"><fmt:message key="label.goBack"/></a>
		<aui:button type="submit" name="save" value="label.save" />
	</div>
</fieldset>

<%-- 	<div class="table">
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
						<aui:validator name="number"/>
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
						<aui:validator name="number"/>
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
	</div> --%>
	
</aui:form>