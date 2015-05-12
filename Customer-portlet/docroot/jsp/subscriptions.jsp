<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="au.com.billingbuddy.vo.objects.SubscriptionVO"%>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState" %>
<%@page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@taglib uri="http://www.billingbuddy.com/.com/bbtlds" prefix="Utils" %>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>

<%
	ArrayList<SubscriptionVO> listSubscriptionsByCustomer = (ArrayList<SubscriptionVO>)session.getAttribute("listSubscriptionsByCustomer");
	if(listSubscriptionsByCustomer == null) listSubscriptionsByCustomer = new ArrayList<SubscriptionVO>();
	System.out.println("listSubscriptionsByCustomer.size() en ;a jsp: " + listSubscriptionsByCustomer.size());
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLSubscriptions">
	<portlet:param name="accion" value="renderURLSubscriptions"/>
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</liferay-portlet:renderURL>

<liferay-ui:search-container curParam="Subscriptions" deltaConfigurable="true" totalVar="totalVarSubscriptions" deltaParam="deltaSubscriptions" delta="3" iteratorURL="<%=renderURLSubscriptions%>" emptyResultsMessage="label.empty">
				   <liferay-ui:search-container-results resultsVar="resultsSubscriptions" totalVar="totalSubscriptions" results="<%= new ArrayList(ListUtil.subList(listSubscriptionsByCustomer, searchContainer.getStart(), searchContainer.getEnd()))%>" total="<%=listSubscriptionsByCustomer.size() %>"/>
					<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.SubscriptionVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="subscriptionVO">
	
	<portlet:renderURL var="popupURLSubscriptionsDetails" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
		<portlet:param name="jspPage" value="/jsp/subscriptionDetails.jsp"/>
		<portlet:param name="idSubscription" value="<%=subscriptionVO.getId()%>"/>
	</portlet:renderURL>
	<liferay-ui:search-container-column-text name="label.iterator" value="${subscriptionVO.id}" orderable="false"/>
	<liferay-ui:search-container-column-text name="label.plan">
		<a onclick="showDetailsSubscriptions('<%= popupURLSubscriptionsDetails.toString() %>')" href="#">${subscriptionVO.planVO.name}</a>
	</liferay-ui:search-container-column-text>
	<liferay-ui:search-container-column-text name="label.cardNumber" value="${Utils:printCardNumber(subscriptionVO.cardVO.number)}" orderable="false"/>
	<liferay-ui:search-container-column-text name="label.start" value="${Utils:formatDate(2,subscriptionVO.start,5)}" orderable="false"/>
	<liferay-ui:search-container-column-text name="label.quantity" property="quantity" orderable="false"/>
	
	<liferay-ui:search-container-column-text name="label.status" orderable="false">
		<fmt:message key="label.${subscriptionVO.status}"/>
	</liferay-ui:search-container-column-text>
	
	<%-- <% if(subscriptionVO.getStatus().equalsIgnoreCase("Canceled")){
		%>
			<liferay-ui:search-container-column-text name="label.<%=subscriptionVO.getStatus() %>" orderable="false"><fmt:message key="label.canceled"/></liferay-ui:search-container-column-text>
		<%
	}else{
		%>
			<liferay-ui:search-container-column-text name="label.status" orderable="false"><fmt:message key="label.active"/></liferay-ui:search-container-column-text>
	<%}%> --%>
	
	<liferay-ui:search-container-column-text name="Accion">
		<liferay-ui:icon-menu>
			<portlet:actionURL var="cancelSubscription" name="cancelSubscription">
				<portlet:param name="idSubscription" value="<%=subscriptionVO.getId()%>"/>
			</portlet:actionURL>
			<% if(subscriptionVO.getStatus().equalsIgnoreCase("Canceled")){
				%>
					<fmt:message key="label.noAvailable"/>
				<%
			}else{
				%>
				    <liferay-ui:icon image="delete" onClick="return confirm('Are you sure do you want to cancel this subscription ?')" message="label.cancel" url="<%=cancelSubscription.toString()%>" />
			<%}%>
		</liferay-ui:icon-menu>
	</liferay-ui:search-container-column-text>
	
   </liferay-ui:search-container-row>
   <liferay-ui:search-iterator />
</liferay-ui:search-container>

