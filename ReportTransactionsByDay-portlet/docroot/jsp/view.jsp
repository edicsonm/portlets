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

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />

<portlet:actionURL name="searchTransactionsByDay" var="submitForm">
</portlet:actionURL>

<portlet:resourceURL var="viewContentURL">
    <portlet:param name="action" value="view_content"/>
</portlet:resourceURL>

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
	TransactionVO transactionVOTransactions = (TransactionVO)session.getAttribute("transactionVOTransactions");
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
   
   /* AUI().use('aui-loading-mask',
           function(A) {
               if (A.one('#<portlet:namespace/>contentview').loadingmask == null) {
                   A.one('#<portlet:namespace/>contentview').plug(A.LoadingMask, {background: '#000'});
                   A.one('#<portlet:namespace/>contentview').loadingmask.show();
               }
           }
	);
   
   AUI().use('aui-loading-mask',
           function(A){
               A.one('#<portlet:namespace/>contentview').loadingmask.hide();
               A.one('#<portlet:namespace/>contentview').unplug();
           }
	); */
   
</aui:script>

<aui:form id="frm" action="<%= submitForm %>" method="post">
 	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.reportDescription"/> </span>
		</legend>
		<div class="">
			
			<div id="contenedor">
				<div id="contenidos">
					<div id="columna1">
						<div class="control-group">
							<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />fromDateTransactionsPicker">
								<aui:input onkeypress="return false;" value="<%= transactionVOTransactions.getInitialDateReport()%>" label="label.from" helpMessage="help.from" showRequiredLabel="false" size="10" type="text" required="false" name="fromDateTransactions">
									 <aui:validator name="date" />
								</aui:input>
							</div>
						</div>
					</div>
					<div id="columna2">
						<div class="control-group">
							<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace  />toDateTransactionsPicker">
								<aui:input onkeypress="return false;" value="<%= transactionVOTransactions.getFinalDateReport()%>" label="label.to" helpMessage="help.to" showRequiredLabel="false" size="10" type="text" required="false" name="toDateTransactions">
									 <aui:validator name="date" />
								</aui:input>
							</div>
						</div>
					</div>
					<div id="columna3">
						<div class="control-group">
							<%-- <aui:button type="button" name="listRefunds" onClick="createGraphicAmount();" value="label.search" /> --%>
							<aui:button type="submit" name="listTransactions" value="label.search" />
						</div>
					</div>
				</div>
			</div>
		<!-- </div> -->
		 <%-- <aui:button name="load" onClick='<%=renderResponse.getNamespace() + "GetContent('param1', 'param2');" %>' /> --%>
		<%-- <aui:button name="load" value="Ejecutar" onClick="GetContent()" />
		<div id="<portlet:namespace/>contentview"></div> --%>
		
	<!-- </fieldset> -->
 
	<!-- <div class="table">
		<div class="row"> -->	
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				<liferay-ui:search-container-results>
					<%
						listTransactionsByDay = Methods.orderReportTransactionsByDay(listTransactionsByDay,orderByCol,orderByType);
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
							<portlet:param name="tranId" value="<%=String.valueOf(transactionVO.getId())%>"/>
					</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="label.amount" value="${Utils:stripeToCurrency(transactionVO.chargeVO.amount, transactionVO.chargeVO.currency)}" orderable="false" orderableProperty="chargeVO.amount" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.date" value="${Utils:formatDate(3,transactionVO.creationTime,3)}" orderable="false" orderableProperty="creationTime"/>
					<liferay-ui:search-container-column-text name="label.brand" value="${Utils:printString(transactionVO.cardVO.brand)}" orderable="false" orderableProperty="cardVO.brand"/>
					<liferay-ui:search-container-column-text name="label.currency" value="${Utils:toUpperCase(transactionVO.chargeVO.currency)}" orderable="false" orderableProperty="chargeVO.currency"/>
					
					<%-- <liferay-ui:search-container-column-text name="label.date" value="<%=Utilities.formatDate(transactionVO.getCreationTime(),3,3) %>" orderable="true" orderableProperty="creationTime" />
					<liferay-ui:search-container-column-text name="label.volume" property="totalDateReport" value="totalDateReport" orderable="false" orderableProperty="totalDateReport"/>
					<liferay-ui:search-container-column-text name="label.amount" value="<%=BBUtils.stripeToCurrency(transactionVO.getAmountDateReport(),\"AUD\") %>" orderable="true" orderableProperty="amount" /> --%>
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		<!-- </div>
	</div> -->
		</div>
	</fieldset>
</aui:form>