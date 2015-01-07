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
<% 
	PlanVO planVO = (PlanVO)session.getAttribute("planVO");
%>

<portlet:actionURL name="savePlan" var="submitForm">
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
						<label class="aui-field-label sub-title"><fmt:message key="label.informationPlan"/></label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.amount" helpMessage="help.amount" showRequiredLabel="false" type="text" required="true" name="amount" value="${planVO.amount}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.currency" helpMessage="help.currency" showRequiredLabel="false" size="3" type="text" required="true" name="currency" value="${planVO.currency}">
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:select name="interval" helpMessage="help.interval" label="label.interval" id="interval">
						<aui:option value="Day" label="label.day" selected="${planVO.interval=='Day'}"/>
						<aui:option value="Week" label="label.week" selected="${planVO.interval=='Week'}"/>
						<aui:option value="Month" label="label.month" selected="${planVO.interval=='Month'}"/>
						<aui:option value="Year" label="label.year" selected="${planVO.interval=='Year'}"/>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.intervalCount" helpMessage="help.intervalCount" showRequiredLabel="false" type="text" required="false" name="intervalCount" value="${planVO.intervalCount}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.name" helpMessage="help.name" showRequiredLabel="false" type="text" required="true" name="name" value="${planVO.name}">
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.trialPeriodDays"  helpMessage="help.trialPeriodDays" showRequiredLabel="false" type="text" required="false" name="trialPeriodDays" value="${planVO.trialPeriodDays}">
						<aui:validator name="digits"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.statementDescriptor" helpMessage="help.statementDescriptor" showRequiredLabel="false" type="textarea" required="false" name="statementDescriptor" value="${planVO.statementDescriptor}">
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