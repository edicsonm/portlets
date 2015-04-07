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
			<liferay-ui:search-container displayTerms="<%= new DisplayTerms(renderRequest) %>" emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				
				<liferay-ui:search-form  page="/jsp/transaction_search.jsp" servletContext="<%= application %>"/>
				
				<liferay-ui:search-container-results>
					<%
						
						DisplayTerms displayTerms =searchContainer.getDisplayTerms();
						TransactionVO transactionVOAUX = new TransactionVO();	
						System.out.println("displayTerms.isAdvancedSearch()? ... " + displayTerms.isAdvancedSearch());	
						if (displayTerms.isAdvancedSearch()) {//Entra aca si selecciona la busqueda avanzada
							System.out.println("Entra por el if ... ");
							if(displayTerms.isAndOperator()){//Selecciono ALL
								System.out.println("Selecciono *ALL");
								
								/* currency
								merchant
								countryCard */
								transactionVOAUX.setCardVO(new CardVO());
								transactionVOAUX.getCardVO().setNumber(cardNumber);
								transactionVOAUX.setMerchantId(merchant);
								transactionVOAUX.getCardVO().setBrand(brand);
								
								transactionVOAUX.getCardVO().setCountry(countryCard);
								
								transactionVOAUX.setChargeVO(new ChargeVO());
								transactionVOAUX.getChargeVO().setCurrency(currency);
								transactionVOAUX.setMatch("0");
								
								transactionVOAUX.getInitialDateReport();
								transactionVOAUX.getFinalDateReport();
								transactionVOAUX.getUserId(String.valueOf(PortalUtil.getUserId(request)));
								
								transactionVOAUX.setCountryNumericMerchant(BBUtils.nullStringToNULL(countryBusinessInformation));
								merchantVOAUX.setBusinessTypeId(BBUtils.nullStringToNULL(businessType));
								merchantVOAUX.setIndustryId(BBUtils.nullStringToNULL(industry));
								merchantVOAUX.setStatus(BBUtils.nullStringToNULL(status));
								
								/* System.out.println("merchantVOAUX.getName() " + merchantVOAUX.getName());
								System.out.println("merchantVOAUX.getCountryNumericMerchant() " + merchantVOAUX.getCountryNumericMerchant());
								System.out.println("merchantVOAUX.getBusinessTypeId() " + merchantVOAUX.getBusinessTypeId());
								System.out.println("merchantVOAUX.getIndustryId() " + merchantVOAUX.getIndustryId());
								System.out.println("merchantVOAUX.getStatus() " + merchantVOAUX.getStatus());
								System.out.println("merchantVOAUX.getMatch() " + merchantVOAUX.getMatch());
								System.out.println("merchantVOAUX.getUserId() " + merchantVOAUX.getUserId()); */
								
							}else{
								
								System.out.println("Selecciono *ANY");
								/* merchantVOAUX.setName(nameMerchant);
								merchantVOAUX.setCountryNumericMerchant(BBUtils.nullStringToNULL(countryBusinessInformation));
								merchantVOAUX.setBusinessTypeId(BBUtils.nullStringToNULL(businessType));
								merchantVOAUX.setIndustryId(BBUtils.nullStringToNULL(industry));
								merchantVOAUX.setStatus(BBUtils.nullStringToNULL(status));
								merchantVOAUX.setMatch("1");
								merchantVOAUX.setUserId(String.valueOf(PortalUtil.getUserId(request))); */
								
								/* System.out.println("merchantVOAUX.getName() " + merchantVOAUX.getName());
								System.out.println("merchantVOAUX.getCountryNumericMerchant() " + merchantVOAUX.getCountryNumericMerchant());
								System.out.println("merchantVOAUX.getBusinessTypeId() " + merchantVOAUX.getBusinessTypeId());
								System.out.println("merchantVOAUX.getIndustryId() " + merchantVOAUX.getIndustryId());
								System.out.println("merchantVOAUX.getStatus() " + merchantVOAUX.getStatus());
								System.out.println("merchantVOAUX.getMatch() " + merchantVOAUX.getMatch());
								System.out.println("merchantVOAUX.getUserId() " + merchantVOAUX.getUserId()); */
								
							}
							/* System.out.println("nameMerchant ... " + nameMerchant);
							System.out.println("status ... " + status); */
						}else{
							System.out.println("Entra por el else ... ");
							/* pstmt.setString(1,merchantVO.getName());
							pstmt.setString(2,merchantVO.getCountryNumericMerchant());
							pstmt.setString(3,merchantVO.getBusinessTypeId());
							pstmt.setString(4,merchantVO.getIndustryId());
							pstmt.setString(5,merchantVO.getStatus());
							pstmt.setString(6,merchantVO.getMatch());
							pstmt.setString(7,merchantVO.getUserId()); */
							
							merchantVOAUX.setName(displayTerms.getKeywords());
							merchantVOAUX.setMatch("1");
							merchantVOAUX.setUserId(String.valueOf(PortalUtil.getUserId(request)));
							
							/* listMerchants = Methods.listAllMerchantsFilter(merchantVOAUX);
							results = new ArrayList<MerchantVO>(ListUtil.subList(listMerchants, searchContainer.getStart(), searchContainer.getEnd()));
							searchContainer.setTotal(listMerchants.size());
							searchContainer.setResults(results); */
							
							/* System.out.println("listMerchants.size(): " + listMerchants.size()); */
							
							/* String searchkeywords = displayTerms.getKeywords(); */
							/* System.out.println("searchkeywords: " + searchkeywords);
							String numbesearchkeywords = Validator.isNumber(searchkeywords) ? searchkeywords : String.valueOf(0);
							System.out.println("numbesearchkeywords: " + numbesearchkeywords);
							System.out.println("nameMerchant ... " + nameMerchant);
							System.out.println("status ... " + status); */
						}
						System.out.println("displayTerms.isAndOperator()? ... " + displayTerms.isAndOperator());
						System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ... ");	
					
						
						
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
					
					<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"BillingBuddyAdministrator\", true) %>">
						<liferay-ui:search-container-column-text property="merchantVO.name" name="label.merchant" orderable="false" orderableProperty="merchantVO.name"/>
					</c:if>
					
					<liferay-ui:search-container-column-text name="label.amount" value="${Utils:stripeToCurrency(transactionVO.chargeVO.amount, transactionVO.chargeVO.currency)}" orderable="false" orderableProperty="chargeVO.amount" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="label.date" value="${Utils:formatDate(3,transactionVO.creationTime,3)}" orderable="false" orderableProperty="creationTime"/>
					<liferay-ui:search-container-column-text name="label.tdcNumber" value="${Utils:printCardNumber(transactionVO.cardVO.number)}" orderable="false"/>
					<liferay-ui:search-container-column-text name="label.brand" value="${Utils:printString(transactionVO.cardVO.brand)}" orderable="false" orderableProperty="cardVO.brand"/>
					<liferay-ui:search-container-column-text name="label.currency" value="${Utils:toUpperCase(transactionVO.chargeVO.currency)}" orderable="false" orderableProperty="chargeVO.currency"/>
					
					<%-- <liferay-ui:search-container-column-text name="label.date" value="<%=Utilities.formatDate(transactionVO.getCreationTime(),3,3) %>" orderable="true" orderableProperty="creationTime" />
					<liferay-ui:search-container-column-text name="label.volume" property="totalDateReport" value="totalDateReport" orderable="false" orderableProperty="totalDateReport"/>
					<liferay-ui:search-container-column-text name="label.amount" value="<%=BBUtils.stripeToCurrency(transactionVO.getAmountDateReport(),\"AUD\") %>" orderable="true" orderableProperty="amount" /> --%>
				</liferay-ui:search-container-row>
				<liferay-ui:search-iterator />
			</liferay-ui:search-container>
		</div>
	</fieldset>
</aui:form>