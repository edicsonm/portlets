<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="au.com.billingbuddy.vo.objects.CardVO"%>

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
	ArrayList<CardVO> listCardsByCustomer = (ArrayList<CardVO>)session.getAttribute("listCardsByCustomer");
	if(listCardsByCustomer == null) listCardsByCustomer = new ArrayList<CardVO>();
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLCards">
	<portlet:param name="accion" value="renderURLCards"/>
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</liferay-portlet:renderURL>

<liferay-ui:search-container curParam="Cards" deltaConfigurable="true" totalVar="totalVarCards" deltaParam="deltaCards" delta="2" iteratorURL="<%=renderURLCards%>" emptyResultsMessage="label.empty">
    <liferay-ui:search-container-results resultsVar="resultsCards" totalVar="totalCards" results="<%= new ArrayList(ListUtil.subList(listCardsByCustomer, searchContainer.getStart(), searchContainer.getEnd()))%>" total="<%=listCardsByCustomer.size() %>"/>
	<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.CardVO" rowVar="posi" indexVar="indiceCard" keyProperty="id" modelVar="cardVO">
	
	<portlet:renderURL var="popupURLCardDetails" windowState="<%= LiferayWindowState.POP_UP.toString() %>" >
		<portlet:param name="jspPage" value="/jsp/cardDetails.jsp"/>
		<portlet:param name="idCard" value="<%=cardVO.getId()%>"/>
	</portlet:renderURL>
	
	<liferay-ui:search-container-column-text name="label.iterator" value="${cardVO.id}" orderable="false"/>
	<liferay-ui:search-container-column-text name="label.cardNumber">
		<a onclick="showDetailsCard('<%= popupURLCardDetails.toString() %>')" href="#">${Utils:printCardNumber(cardVO.number)}</a>
	</liferay-ui:search-container-column-text>
	<liferay-ui:search-container-column-text name="label.brand" value="${Utils:printString(cardVO.brand)}" orderable="false"/>
	<liferay-ui:search-container-column-text name="label.expire" value="${cardVO.expMonth} - ${cardVO.expYear}"  orderable="false"/>
	
	<liferay-ui:search-container-column-text name="Accion">
		<liferay-ui:icon-menu>
			
			<liferay-portlet:renderURL varImpl="editURLCard" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
				<portlet:param name="jspPage" value="/jsp/editCard.jsp" />
				<portlet:param name="idCard" value="<%=cardVO.getId()%>"/>
			</liferay-portlet:renderURL>
			<button type="button" onclick="editCard('<%=editURLCard.toString()%>')" name="<portlet:namespace />editCard" id="<portlet:namespace />editCard" class="btn-link"><fmt:message key="label.edit"/></button>
			
			<%-- <portlet:actionURL var="inactivateURLBusinessType" name="inactivateBusinessType">
				<portlet:param name="indiceCard" value="<%=String.valueOf(indiceCard)%>"/>
			</portlet:actionURL>
			<% if(cardVO.getStatus().equalsIgnoreCase("0")){%>
				<liferay-ui:icon-deactivate  label="label.inactivate" url="<%=inactivateURLBusinessType.toString()%>" />
			<%}else{ %>
				<liferay-ui:icon image="activate" label="label.inactivate" url="<%= inactivateURLBusinessType.toString() %>" />
			<%}%> --%>
		</liferay-ui:icon-menu>
	</liferay-ui:search-container-column-text>
	
   </liferay-ui:search-container-row>
   <liferay-ui:search-iterator />
</liferay-ui:search-container>