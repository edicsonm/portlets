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
	ArrayList<SubscriptionVO> resultsListSubscriptions = (ArrayList<SubscriptionVO>)session.getAttribute("results");
	SubscriptionVO subscriptionVO = (SubscriptionVO)resultsListSubscriptions.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("subscriptionVO", subscriptionVO);
%>
<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form method="post">
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
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.plan"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${subscriptionVO.planVO.name}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.status"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${subscriptionVO.status}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.quantity"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${subscriptionVO.quantity}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.cancelAtPeriodEnd"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${subscriptionVO.cancelAtPeriodEnd}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.applicationFeePercent"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${subscriptionVO.applicationFeePercent}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.taxPercent"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${subscriptionVO.taxPercent}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.start"/></label>
				</div>
				<div class="column2-4">
					<%-- <c:out value="${subscriptionVO.start}"/> --%>
					<c:out value="<%=Utilities.formatDate(subscriptionVO.getStart()) %>"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.endedAt"/></label>
				</div>
				<div class="column4-4">
					<%-- <c:out value="${subscriptionVO.endedAt}"/> --%>
					<c:out value="<%=Utilities.formatDate(subscriptionVO.getEndedAt()) %>"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.canceledAt"/></label>
				</div>
				<div class="column2-4">
					<%-- <c:out value="${subscriptionVO.canceledAt}"/> --%>
					<c:out value="<%=Utilities.formatDate(subscriptionVO.getCanceledAt()) %>"/>
				</div>
				<div class="column3-4">
					<%-- <label class="aui-field-label"><fmt:message key="label.endedAt"/></label> --%>
				</div>
				<div class="column4-4">
					<%-- <c:out value="${subscriptionVO.endedAt}"/> --%>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.currentPeriodStart"/></label>
				</div>
				<div class="column2-4">
					<%-- <c:out value="${subscriptionVO.currentPeriodStart}"/> --%>
					<c:out value="<%=Utilities.formatDate(subscriptionVO.getCurrentPeriodStart()) %>"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.currentPeriodEnd"/></label>
				</div>
				<div class="column4-4">
					<%-- <c:out value="${subscriptionVO.currentPeriodEnd}"/> --%>
					<c:out value="<%=Utilities.formatDate(subscriptionVO.getCurrentPeriodEnd()) %>"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.trialStart"/></label>
				</div>
				<div class="column2-4">
					<%-- <c:out value="${subscriptionVO.trialStart}"/> --%>
					<c:out value="<%=Utilities.formatDate(subscriptionVO.getTrialStart()) %>"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.trialEnd"/></label>
				</div>
				<div class="column4-4">
					<%-- <c:out value="${Utilities.formatDate(subscriptionVO.trialEnd)}"/> --%>
					<c:out value="<%=Utilities.formatDate(subscriptionVO.getTrialEnd()) %>"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
				<div class="column2-2">
				</div>
			</div>
		</div>
	</div>
</aui:form>