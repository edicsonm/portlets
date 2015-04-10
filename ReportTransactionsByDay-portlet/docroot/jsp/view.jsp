<%@page import="au.com.billigbuddy.utils.BBUtils"%>
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
<%@ taglib uri="http://www.billingbuddy.com/.com/bbtlds" prefix="Utils" %>
<%@ page import="java.util.Enumeration"%>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLTransactionsByDay">
	<portlet:param name="accion" value="renderURLTransactionsByDay"/>
	<portlet:param name="cardNumber" value="<%=cardNumber%>"/>
	<portlet:param name="brand" value="<%=brand%>"/>
	<portlet:param name="merchant" value="<%=merchant%>"/>
	<portlet:param name="countryCard" value="<%=countryCard%>"/>
	<portlet:param name="currency" value="<%=currency%>"/>
	<portlet:param name="lastCur" value="<%=ParamUtil.getString(request, \"cur\")%>"/>
</liferay-portlet:renderURL>

<portlet:actionURL name="searchTransactionsByDay" var="submitForm">
	
</portlet:actionURL>

<portlet:resourceURL var="viewContentURL">
    <portlet:param name="action" value="view_content"/>
</portlet:resourceURL>

<% 
	//orderByCol is the column name passed in the request while sorting
	 String orderByCol = ParamUtil.getString(request, "orderByCol", "creationTime");

	//orderByType is passed in the request while sorting. It can be either asc or desc
	String orderByType = ParamUtil.getString(request, "orderByType","desc");
	
	System.out.println("JSP orderByCol: " + orderByCol);
	System.out.println("JSP orderByType: " + orderByType);
	
	//Logic for toggle asc and desc
	
	/* if(orderByType.equals("desc")){
	  orderByType = "asc";
	}else{
	  orderByType = "desc";
	}
	
	if(Validator.isNull(orderByType)){
	  orderByType = "desc";
	} */
	
	pageContext.setAttribute("orderByCol", orderByCol);
    pageContext.setAttribute("orderByType", orderByType); 

	ArrayList<TransactionVO> listTransactionsByDay = (ArrayList<TransactionVO>)session.getAttribute("listTransactionsByDay");
	if(listTransactionsByDay == null) listTransactionsByDay = new ArrayList<TransactionVO>();
	TransactionVO transactionVOTransactions = (TransactionVO)session.getAttribute("transactionVOTransactions");
	if(transactionVOTransactions == null) transactionVOTransactions = new TransactionVO();
	
%>
<aui:script>

     YUI().use('aui-datepicker', function(Y) {
 	    new Y.DatePicker(
 	    	{
 	        trigger: '#<portlet:namespace />fromDateTransactions',
 	        popover: {
 	          zIndex: 1
 	        }
 	      });
 	  }
 	);
   
   YUI().use(
 		  'aui-datepicker',
 		  function(Y) {
 		    new Y.DatePicker(
 		      {
 		        trigger: '#<portlet:namespace />toDateTransactions',
 		        popover: {
 		          zIndex: 1
 		        }
 		      });
 		  }
 		);
     
   function GetContent() {
       var url='<%=viewContentURL %>';
       AUI().io.request(
           url,
           {
               method: 'POST',
               form: {id: '<portlet:namespace />frm'},
               data: {
                       <portlet:namespace/>param1: "param1",
                       <portlet:namespace/>param2: "param2"
                     },
               on: {
                   failure: function() {
	                      alert('failure');
	                   },
                   success: function(event, id, obj) {
                       var instance = this;
                       var message = instance.get('responseData');
                       AUI().one('#<portlet:namespace/>contentview').html(message);
                    }
               }
           }
       );
   }
   
</aui:script>

<portlet:actionURL name="listarTransacciones" var="listarTransacciones">
</portlet:actionURL>

<aui:form action="<%=listarTransacciones %>" method="post">
 	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.reportDescription"/> </span>
		</legend>
		<div class="">
		<%-- orderByType="<%=orderByType %>" --%>
			<liferay-ui:search-container orderByType="<%=orderByType %>" orderByCol="<%=orderByCol %>"  displayTerms="<%= new DisplayTerms(renderRequest) %>" emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURLTransactionsByDay%>">
				<div id="contenedor">
					<div id="contenidos">
						<div id=columna1-3>
							<div class="control-group">
								<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />fromDateTransactionsPicker">
									<aui:input onkeypress="return false;" value="<%= transactionVOTransactions.getInitialDateReport()%>" label="label.from" helpMessage="help.from" showRequiredLabel="false" size="10" type="text" required="false" name="fromDateTransactions">
										 <aui:validator name="date" />
									</aui:input>
								</div>
							</div>
						</div>
						<div id="columna2-3">
							<div class="control-group">
								<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace  />toDateTransactionsPicker">
									<aui:input onkeypress="return false;" value="<%= transactionVOTransactions.getFinalDateReport()%>" label="label.to" helpMessage="help.to" showRequiredLabel="false" size="10" type="text" required="false" name="toDateTransactions">
										 <aui:validator name="date" />
									</aui:input>
								</div>
							</div>
						</div>
						<div id="columna3-3">
							<div class="control-group">
								<liferay-ui:search-form  page="/jsp/transaction_search.jsp" servletContext="<%= application %>"/>
							</div>
						</div>
					</div>
				</div>
				<liferay-ui:search-container-results>
					<%
						/* listTransactionsByDay = Methods.orderReportTransactionsByDay(listTransactionsByDay,orderByCol,orderByType); */
						results = new ArrayList(ListUtil.subList(listTransactionsByDay, searchContainer.getStart(), searchContainer.getEnd()));
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
					</liferay-portlet:renderURL>
					
					<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"BillingBuddyAdministrator\", true) %>">
						<liferay-ui:search-container-column-text property="merchantVO.name" name="label.merchant" orderable="true" orderableProperty="merchantVO.name"/>
					</c:if>
					
					<liferay-ui:search-container-column-text name="label.amount" value="${Utils:stripeToCurrency(transactionVO.chargeVO.amount, transactionVO.chargeVO.currency)}" orderable="true" orderableProperty="chargeVO.amount" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.date" value="${Utils:formatDate(3,transactionVO.creationTime,3)}" orderable="true" orderableProperty="creationTime"/>
					<liferay-ui:search-container-column-text name="label.cardNumber" value="${Utils:printCardNumber(transactionVO.cardVO.number)}" orderable="false"/>
					<liferay-ui:search-container-column-text name="label.brand" value="${Utils:printString(transactionVO.cardVO.brand)}" orderable="true" orderableProperty="cardVO.brand"/>
					<liferay-ui:search-container-column-text name="label.currency" value="${Utils:toUpperCase(transactionVO.chargeVO.currency)}" orderable="true" orderableProperty="chargeVO.currency"/>
					
					<%-- <liferay-ui:search-container-column-text name="label.date" value="<%=Utilities.formatDate(transactionVO.getCreationTime(),3,3) %>" orderable="true" orderableProperty="creationTime" />
					<liferay-ui:search-container-column-text name="label.volume" property="totalDateReport" value="totalDateReport" orderable="false" orderableProperty="totalDateReport"/>
					<liferay-ui:search-container-column-text name="label.amount" value="<%=BBUtils.stripeToCurrency(transactionVO.getAmountDateReport(),\"AUD\") %>" orderable="true" orderableProperty="amount" /> --%>
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</div>
	</fieldset>
</aui:form>