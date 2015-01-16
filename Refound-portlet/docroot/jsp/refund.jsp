<%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%>
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
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.service.UserServiceUtil" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.PortletURL"%>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util"%>
<aui:script use="aui">
	enableField = function(){
		A.one("#<portlet:namespace/>refundAmount").set('disabled', false);
	}
</aui:script>

<portlet:resourceURL var="ajaxResourceUrl"/>

<portlet:renderURL var="showjspURL">
	<portlet:param name="jspPage" value="/jsp/refunds.jsp" />
</portlet:renderURL>

<fmt:setBundle basename="Language"/>
<liferay-ui:success key="refundSuccessful" message="label.success" />


<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException" message="error.ProcessorMDTR.processRefound.InvalidRequestException" />
<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException.1" message="error.ProcessorMDTR.processRefound.InvalidRequestException.1" />
<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException.2" message="error.ProcessorMDTR.processRefound.InvalidRequestException.2" />
<liferay-ui:error key="ProcessorMDTR.processRefound.InvalidRequestException.3" message="error.ProcessorMDTR.processRefound.InvalidRequestException.3" />
<liferay-ui:error key="ProcessorMDTR.processRefound.RefundDAOException" message="error.ProcessorMDTR.processRefound.RefundDAOException" />

<portlet:defineObjects />

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<portlet:renderURL var="ajaxUrl">
	<portlet:param name="jspPage" value="/jsp/refunds.jsp" />
</portlet:renderURL>

<portlet:actionURL name="processRefund" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURLRefunds" />
<%
	
	/* PortletPreferences prefs = renderRequest.getPreferences();
	String indice = (String)prefs.getValue("indice", "Hello! Welcome to our portal."); */
	
	/* String indice = ParamUtil.getString(request, "indice");
	System.out.println("indice: " + indice);
	
	String orderNumber = ParamUtil.getString(request, "orderNumber");
	session.setAttribute("orderNumber", orderNumber);
	System.out.println("orderNumber en jsp: " + orderNumber);
	
	
	ArrayList<ChargeVO> resultsListCharge = (ArrayList<ChargeVO>)session.getAttribute("results");
	ChargeVO chargeVO = (ChargeVO)resultsListCharge.get(Integer.parseInt(indice));
	pageContext.setAttribute("chargeVO", chargeVO);
	session.setAttribute("chargeVO", chargeVO);
	session.setAttribute("indice", indice); */
	
	ChargeVO chargeVO = (ChargeVO)session.getAttribute("chargeVO");
	
	String orderByColAnteriorRefunds = (String)session.getAttribute("orderByColRefunds");
	String orderByTypeAnteriorRefunds = (String)session.getAttribute("orderByTypeRefunds");
	
	String orderByColRefunds = "id";
	String orderByTypeRefunds = "asc";
	
	if(renderRequest != null){
		orderByColRefunds = (String)renderRequest.getParameter("orderByColRefunds");
		orderByTypeRefunds = (String)renderRequest.getAttribute("orderByTypeRefunds");
	
		if(orderByTypeRefunds == null){
			orderByTypeRefunds = "asc";
		}
		
		if(orderByColRefunds == null){
			orderByColRefunds = "id";
		}else if(orderByColRefunds.equalsIgnoreCase(orderByColAnteriorRefunds)){
			if (orderByTypeAnteriorRefunds.equalsIgnoreCase("asc")){
				orderByTypeRefunds = "desc";
			}else{
				orderByTypeRefunds = "asc";
			}
		}else{
			orderByTypeRefunds = "asc";
		}
	}
	ArrayList<RefundVO> listRefunds = (ArrayList<RefundVO>)session.getAttribute("listRefunds");
	if(listRefunds == null) listRefunds = new ArrayList<RefundVO>();
	session.setAttribute("orderByColRefunds", orderByColRefunds);
	session.setAttribute("orderByTypeRefunds", orderByTypeRefunds);
%>
<script type="text/javascript">
function listRefunds() {
	var url = '<%=ajaxResourceUrl%>';
    $.ajax({
    type : "POST",
    url : url,
    cache:false,
    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    dataType: "html",
    data: {orderNumber:<%=chargeVO.getTransactionId()%>},
    success : function(data){
    	alert("Termina: " + data);
    	<%-- $( "#listRefunds" ).load('<%=renderRequest.getContextPath()%>'+'/jsp/refunds.jsp'); --%>
    	$( "#listRefunds" ).load("<%=ajaxUrl%>");
    },error : function(XMLHttpRequest, textStatus, errorThrown){
          alert("XMLHttpRequest..." + XMLHttpRequest);
          alert("textStatus..." + textStatus);
          alert("errorThrown..." + errorThrown);
    }
  });
};
</script>

<aui:form action="<%= submitForm %>" method="post">
	<div class="tabla">
			<div class="section">
				<div class="row">
					<div class="column1-1">
						<label class="sub-title"><fmt:message key="label.title.refound"/></label>
					</div>
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.transactionNumber"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${chargeVO.transactionId}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.dateOrderPlaced"/></label>
					</div>
					<div class="column4-4">
						<c:out value="<%=Utilities.formatDate(chargeVO.getCreationTime()) %>"/>
					</div>
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.currency"/></label>
					</div>
					<div class="column2-4">
						<c:out value="${fn:toUpperCase(chargeVO.currency)}"/>
					</div>
					
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.transactionAmount"/></label>
					</div>
					<div class="column4-4">
						<c:out value="<%=Utilities.stripeToCurrency(chargeVO.getAmount(),chargeVO.getCurrency().toUpperCase()) %>"/>
					</div>
					
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.cardType"/></label>
					</div>
					<div class="column2-4">
						<c:out default="N/E" value="${chargeVO.cardVO.brand}"/>
					</div>
					<div class="column3-4">
						<label class="aui-field-label"><fmt:message key="label.paymentMethod"/></label>
					</div>
					<div class="column4-4">
						<c:out default="N/E" value="${fn:toUpperCase(fn:substring(chargeVO.cardVO.funding, 0, 1))}${fn:toLowerCase(fn:substring(chargeVO.cardVO.funding, 1,fn:length(chargeVO.cardVO.funding)))}"/>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="row">
					<div class="column1-1">
						<label class="sub-title"><fmt:message key="label.title.refoundDetails"/></label>
					</div>
				</div>
				<div class="row">
					<%-- <div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.reason"/></label>
					</div> --%>
					<div class="column1-2">
						<aui:input label="label.reason" type="textarea" showRequiredLabel="false" required="true" name="reason" value="${chargeVO.refundVO.reason}"/>
					</div>
					<%-- <div class="column2-2">
						<label class="aui-field-label"><fmt:message key="label.refundAmount"/></label>
					</div> --%>
					<div class="column2-2">
						<aui:input label="label.refundAmount" showRequiredLabel="false" required="true" id="refundAmount" name="refundAmount" disabled="false" value="<%=Utilities.stripeToCurrency(String.valueOf(Integer.parseInt(chargeVO.getAmount()) - Integer.parseInt(chargeVO.getAmountRefunded())),chargeVO.getCurrency().toUpperCase()) %>">
							<aui:validator name="number" />
						</aui:input>
						<%-- <span class="enableField"><a href="#" onclick="javascript:enableField()"><fmt:message key="label.enableField"/></a></span> --%>
					</div>
				</div>
				<div class="row">
					<div class="column1-4">
						<label class="aui-field-label"><fmt:message key="label.refunded"/></label>
					</div>
					<div class="column2-4">
						<%-- <c:out default="N/E" value="${chargeVO.refundVO.amount}"/> --%>
						<c:out default="N/E" value="<%=Utilities.stripeToCurrency(chargeVO.getAmountRefunded(),chargeVO.getCurrency().toUpperCase()) %>"/>
					</div>
					<div class="column3-4">
					</div>
					<div class="column4-4">
					</div>
				</div>
				
				<div class="row">
					<div class="column1-1">
						<label class="sub-title"><fmt:message key="label.title.refoundHistory"/></label>
					</div>
				</div>
				<div class="row">
						<liferay-ui:search-container delta="<%= listRefunds.size() %>" emptyResultsMessage="label.noRegistros">
						<%-- <liferay-ui:search-container emptyResultsMessage="label.noRegistros" iteratorURL="<%=renderURLRefunds%>" orderByCol="<%=orderByColRefunds%>" orderByType="<%=orderByTypeRefunds%>"> --%>
						   <liferay-ui:search-container-results  >
						      <%
						      results= ListUtil.subList(listRefunds, searchContainer.getStart(), searchContainer.getEnd());
						      total= listRefunds.size();
						      pageContext.setAttribute("results", results);
						      pageContext.setAttribute("total", total);	
						      
						      /* listRefunds = Methods.orderRefunds(listRefunds,orderByColRefunds,orderByTypeRefunds);
								results = ListUtil.subList(listRefunds, searchContainer.getStart(), searchContainer.getEnd());
								total = listRefunds.size();
								pageContext.setAttribute("results", results);
								pageContext.setAttribute("total", total); */
						       %>
							</liferay-ui:search-container-results>
							<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.RefundVO" rowVar="posi" indexVar="indiceTable" keyProperty="id" modelVar="refundVO">
							<liferay-ui:search-container-column-text name="Refund" property="id" value="id" orderable="false" orderableProperty="id"/>
							<liferay-ui:search-container-column-text name="Currency" property="currency" orderable="false" orderableProperty="currency" />
							<liferay-ui:search-container-column-text name="Amount" value="<%=Utilities.stripeToCurrency(refundVO.getAmount(),refundVO.getCurrency().toUpperCase()) %>" orderable="false" orderableProperty="amount" />
							<liferay-ui:search-container-column-text name="Charge Date" value="<%=Utilities.formatDate(refundVO.getCreationTime())%>"  orderable="false" orderableProperty="creationTime" />
							<liferay-ui:search-container-column-text name="Reason" property="reason" orderable="false" orderableProperty="reason" />
						   </liferay-ui:search-container-row>
						   <liferay-ui:search-iterator paginate="false" />
						</liferay-ui:search-container>					
				</div>	
				<div class="row">
					<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
					<div class="column2-2">
						<%-- <aui:button type="button" name="listRefunds" onClick="listRefunds();" value="label.listRefunds" /> --%>
						<aui:button type="submit" name="processRefund" value="label.processRefund" />
						<%-- <a href="#" onclick="javascript:submitForm()"><fmt:message key="label.processRefund"/></a> --%>
					</div>
				</div>
			</div>
		<%-- <div class="fila">
			<div class="columnaIzquierda">
				<label class="aui-field-label"><fmt:message key="label.transactionNumber"/></label>
			</div>
			<div class="columnaDerecha">
				<c:out value="${id}"/>
			</div>
		</div> --%>
	</div>
</aui:form>