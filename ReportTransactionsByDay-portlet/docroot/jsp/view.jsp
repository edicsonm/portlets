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
<%@ page import="java.util.Enumeration"%>

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
	System.out.println("listTransactionsByDay.size() en view.jsp: " + listTransactionsByDay.size());
	
	TransactionVO transactionVOAux = (TransactionVO)session.getAttribute("transactionVO");
	if(transactionVOAux != null){
		System.out.println("Fecha guardada: " + Utilities.getDateFormat(6).format(Utilities.getDateFormat(2).parse(transactionVOAux.getInitialDateReport())));
	}
%>
<aui:script>
    
    AUI().use('aui-datepicker', function(A) {
       var fromDate = new A.DatePicker({
         trigger: '#<portlet:namespace />fromDateTransactions',
         mask: '%m/%d/%Y',
         calendar: {
       	 	setValue: true
         }
       }).render('#<portlet:namespace />fromDateTransactionsPicker');
       <%
       	if(transactionVOAux!=null){
       		%>
       		A.one('#<portlet:namespace />fromDateTransactions').val('<%= Utilities.getDateFormat(6).format(Utilities.getDateFormat(2).parse(transactionVOAux.getInitialDateReport()))%>'); 
       		<%
       	}
       %>
       /* A.one('#<portlet:namespace />fromDateTransactions').val('<%= transactionVOAux!=null ? Utilities.getDateFormat(6).format(Utilities.getDateFormat(2).parse(transactionVOAux.getInitialDateReport())): "new Date()"%>'); */
    });
    
    AUI().use('aui-datepicker', function(A) {
        var toDate = new A.DatePicker({
          trigger: '#<portlet:namespace />toDateTransactions',
          mask: '%m/%d/%Y',
          calendar: {
         	 	setValue: true
           }
        }).render('#<portlet:namespace />toDateTransactionsPicker');
        <%
       	if(transactionVOAux!=null){
       		%>
       		A.one('#<portlet:namespace />toDateTransactions').val('<%= Utilities.getDateFormat(6).format(Utilities.getDateFormat(2).parse(transactionVOAux.getFinalDateReport()))%>'); 
       		<%
       	}
       %>
        /* A.one('#<portlet:namespace />toDateTransactions').val(new Date()); */
     });

</aui:script>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />

<portlet:actionURL name="searchTransactionsByDay" var="submitForm">
</portlet:actionURL>

 <aui:form action="<%= submitForm %>" method="post">
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="column1-3-Report">
					<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />fromDateTransactionsPicker">
						<aui:input onkeypress="return false;" label="label.from" helpMessage="help.from" showRequiredLabel="false" size="10" type="text" required="true" name="fromDateTransactions">
							 <aui:validator name="date" />
						</aui:input>
					</div>
				</div>
				<div class="column2-3-Report">
					<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace  />toDateTransactionsPicker">
						<aui:input onkeypress="return false;" label="label.to" helpMessage="help.to" showRequiredLabel="false" size="10" type="text" required="true" name="toDateTransactions">
							 <aui:validator name="date" />
						</aui:input>
					</div>
				</div>
				<div class="column3-3-Report">
					<aui:button type="submit" name="listTransactions" value="label.search" />
					<%-- <aui:button type="button" name="test-button" value="label.search" /> --%>
					<%-- <aui:button value="redirectButton" onClick="<%=renderURL.toString()%>" name="redirectButton" /> --%>
				</div>
			</div>
		</div>
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
					
					<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
							<portlet:param name="jspPage" value="/jsp/viewTransaction.jsp" />
							<portlet:param name="tranId" value="<%=String.valueOf(transactionVO.getId())%>"/>
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.amount" property="chargeVO.amount" value="chargeVO.amount" orderable="false" orderableProperty="chargeVO.amount" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.date" property="creationTime" value="creationTime" orderable="false" orderableProperty="creationTime"/>
					<liferay-ui:search-container-column-text name="label.brand" property="cardVO.brand" value="cardVO.brand" orderable="false" orderableProperty="cardVO.brand"/>
					
					<%-- <liferay-ui:search-container-column-text name="label.date" value="<%=Utilities.formatDate(transactionVO.getCreationTime(),3,3) %>" orderable="true" orderableProperty="creationTime" />
					<liferay-ui:search-container-column-text name="label.volume" property="totalDateReport" value="totalDateReport" orderable="false" orderableProperty="totalDateReport"/>
					<liferay-ui:search-container-column-text name="label.amount" value="<%=Utilities.stripeToCurrency(transactionVO.getAmountDateReport(),\"AUD\") %>" orderable="true" orderableProperty="amount" /> --%>
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</div>
	</div>
	<!-- <ul id="navlist">
		<li id="home"><a href="default.asp"></a></li>
	</ul> -->
	
	<img id="home" src="img_trans.gif"><br><br>
	<img id="next" src="img_trans.gif">
</aui:form>