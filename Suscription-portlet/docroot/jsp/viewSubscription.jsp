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
<portlet:renderURL var="goBackSubscription">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.informationSubscription"/> </span>
		</legend>
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="details">
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.plan"/></dt>
								<dd><c:out value="${subscriptionVO.planVO.name}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.status"/></dt>
								<dd><c:out value="${subscriptionVO.status}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">	
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.quantity"/></dt>
								<dd><c:out value="${subscriptionVO.quantity}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.cancelAtPeriodEnd"/></dt>
								<c:choose>
								  <c:when test="${subscriptionVO.cancelAtPeriodEnd == 0}">
								  	<dd>True</dd>
								  </c:when>
								  <c:otherwise>
								  	<dd>False</dd>
								  </c:otherwise>
								</c:choose>
							</dl>
						</div>
					</div>
					
					<div id="contenidos">	
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.applicationFeePercent"/></dt>
								<dd><c:out value="${subscriptionVO.applicationFeePercent}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.taxPercent"/></dt>
								<dd><c:out value="${subscriptionVO.taxPercent}"/></dd>
							</dl>
						</div>
					</div>
					
					<div id="contenidos">	
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.start"/></dt>
								<dd><c:out value="${Utils:formatDate(3,subscriptionVO.start,6)}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.endedAt"/></dt>
								<dd><c:out value="${Utils:formatDate(3,subscriptionVO.endedAt,6)}"/></dd>
							</dl>
						</div>
					</div>
					
					<div id="contenidos">	
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.canceledAt"/></dt>
								<dd><c:out value="${Utils:formatDate(3,subscriptionVO.canceledAt,6)}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
							</dl>
						</div>
					</div>
					
					<div id="contenidos">	
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.currentPeriodStart"/></dt>
								<dd><c:out value="${Utils:formatDate(3,subscriptionVO.currentPeriodStart,6)}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.currentPeriodEnd"/></dt>
								<dd><c:out value="${Utils:formatDate(3,subscriptionVO.currentPeriodEnd,6)}"/></dd>
							</dl>
						</div>
					</div>
					
					<div id="contenidos">	
						<div id="columna1-2">
							<dl class="property-list">
								<dt><fmt:message key="label.trialStart"/></dt>
								<dd><c:out value="${Utils:formatDate(3,subscriptionVO.trialStart,6)}"/></dd>
							</dl>
						</div>
						<div id="columna2-2">
							<dl class="property-list">
								<dt><fmt:message key="label.trialEnd"/></dt>
								<dd><c:out value="${Utils:formatDate(3,subscriptionVO.trialEnd,6)}"/></dd>
							</dl>
						</div>
					</div>
					<a href="<%= goBackSubscription %>"><fmt:message key="label.goBack"/></a>
				</div>
			</div>
		</div>
	</fieldset>
</aui:form>