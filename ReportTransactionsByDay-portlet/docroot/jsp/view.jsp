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
	String orderByColAnterior = (String)session.getAttribute("orderByCol");
	String orderByTypeAnterior = (String)session.getAttribute("orderByType");
	
	String orderByCol = (String)renderRequest.getParameter("orderByCol");
	String orderByType = (String)renderRequest.getAttribute("orderByType");
	
	if(orderByType == null){
		orderByType = "asc";
	}
	
	if(orderByCol == null){
		orderByCol = "creationTime";
	}else if(orderByCol.equalsIgnoreCase(orderByColAnterior)){
		if (orderByTypeAnterior.equalsIgnoreCase("asc")){
			orderByType = "desc";
		}else{
			orderByType = "asc";
		}
	}else{
		orderByType = "asc";
	}	

	ArrayList<TransactionVO> listTransactionsByDay = (ArrayList<TransactionVO>)session.getAttribute("listTransactionsByDay");
	if(listTransactionsByDay == null) listTransactionsByDay = new ArrayList<TransactionVO>();
%>
<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form method="post">
	<div class="table">
		<div class="row">
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listTransactionsByDay = Methods.orderReportTransactionsByDay(listTransactionsByDay,orderByCol,orderByType);
						results = ListUtil.subList(listTransactionsByDay, searchContainer.getStart(), searchContainer.getEnd());
						total = listTransactionsByDay.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				    %>
				</liferay-ui:search-container-results>
				<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.TransactionVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="transactionVO">
					
					<liferay-ui:search-container-column-text name="label.amount" property="chargeVO.amount" value="chargeVO.amount" orderable="true" orderableProperty="chargeVO.amount"/>
					<%-- <liferay-ui:search-container-column-text name="label.date" property="creationTime" value="creationTime" orderable="true" orderableProperty="creationTime"/> --%>
					
					<liferay-ui:search-container-column-text name="label.date" value="<%=Utilities.formatDate(transactionVO.getCreationTime(),3,3) %>" orderable="true" orderableProperty="creationTime" />
					
					<%-- <liferay-ui:search-container-column-text name="label.volume" property="totalDateReport" value="totalDateReport" orderable="false" orderableProperty="totalDateReport"/> --%>
					<%-- <liferay-ui:search-container-column-text name="label.amount" value="<%=Utilities.stripeToCurrency(transactionVO.getAmountDateReport(),\"AUD\") %>" orderable="true" orderableProperty="amount" /> --%>
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</div>
	</div>
</aui:form>