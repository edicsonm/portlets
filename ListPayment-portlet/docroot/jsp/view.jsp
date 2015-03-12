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

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="success" message="label.success" />
<liferay-ui:error key="error" message="label.unsatisfactoryRegistration" />
<liferay-ui:error key="claveDuplicada" message="error.claveDuplicada"  />

<liferay-ui:message key="label.title"/>
<aui:script use="aui-io-request,aui-node">
</aui:script>
<%
	String orderByColAnterior = (String)session.getAttribute("orderByCol");
	String orderByTypeAnterior = (String)session.getAttribute("orderByType");

	String orderByCol = (String)renderRequest.getParameter("orderByCol");
	String orderByType = (String)renderRequest.getAttribute("orderByType");
	
	if(orderByType == null){
		orderByType = "asc";
	}
	
	if(orderByCol == null){
		orderByCol = "id";
	}else if(orderByCol.equalsIgnoreCase(orderByColAnterior)){
		if (orderByTypeAnterior.equalsIgnoreCase("asc")){
			orderByType = "desc";
		}else{
			orderByType = "asc";
		}
	}else{
		orderByType = "asc";
	}
	
	ArrayList<TransactionVO> listTransaction = (ArrayList)session.getAttribute("listTransaction");
	if(listTransaction == null) listTransaction = new ArrayList<TransactionVO>();
	session.setAttribute("orderByCol", orderByCol);
	session.setAttribute("orderByType", orderByType);
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />
<aui:form name="operacion" method="post">
	<div class="tabla">
			<%-- <div class="fila">
				<div class="columnaIzquierda">
					<aui:input name="busqueda" label="" inlineLabel="false" value="entre raza" type="text"/>
				</div>
				<div class="columnaIzquierdaMargen">
					<aui:button type="submit" value="search" onClick="javascript:buscarFuncion()"/>
				</div>
				<div class="columnaIzquierdaMargen">
					<aui:button type="submit" value="add" onClick="javascript:agregarFuncion()"/>
				</div>
			</div> --%>
			<div class="fila">
				<liferay-ui:search-container emptyResultsMessage="label.noRegistros" delta="5" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				   <liferay-ui:search-container-results>
				      <%
						listTransaction = Methods.orderTransactions(listTransaction,orderByCol,orderByType);
						results = ListUtil.subList(listTransaction, searchContainer.getStart(), searchContainer.getEnd());
						total = listTransaction.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				       %>
					</liferay-ui:search-container-results>
					<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.TransactionVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="transactionVO">
					<liferay-ui:search-container-column-text name="# Transaction" property="id"  orderable="true" orderableProperty="id" />
					<liferay-ui:search-container-column-text name="Currency" property="orderCurrency" orderable="true" orderableProperty="orderCurrency" />
					<liferay-ui:search-container-column-text name="Transaction Type" property="txnType" orderable="true" orderableProperty="txnType" />
					<liferay-ui:search-container-column-text name="Order Amount" property="orderAmount" orderable="true" orderableProperty="orderAmount" />
					<liferay-ui:search-container-column-text name="Card Number" property="cardVO.cardNumber" orderable="true" orderableProperty="cardVO.cardNumber" />
					<liferay-ui:search-container-column-text name="Card Holder Name" property="cardVO.name" orderable="true" orderableProperty="cardVO.name" />
					
					<!-- transactionVO = new TransactionVO();
					transactionVO.setId(rs.getString("Tran_Id"));
					transactionVO.setOrderCurrency(rs.getString("Tran_OrderCurrency"));
					transactionVO.setTxnType(rs.getString("Tran_TxnType"));
					transactionVO.setCustomerId(rs.getString("Tran_CustomerId"));
					transactionVO.setCardId(rs.getString("Tran_CardId"));
					transactionVO.setOrderAmount(rs.getString("Tran_OrderAmount"));
					transactionVO.setCardVO(new CardVO());
					transactionVO.getCardVO().setCardNumber(rs.getString("Card_Number"));
					transactionVO.getCardVO().setName(rs.getString("Card_Name")); -->
					
					
					<!-- transactionVO.setId(rs.getString("Tran_Id"));
					transactionVO.setOrderCurrency(rs.getString("Tran_OrderCurrency"));
					transactionVO.setTxnType(rs.getString("Tran_TxnType"));
					transactionVO.setCustomerId(rs.getString("Tran_CustomerId"));
					transactionVO.setCardId(rs.getString("Tran_CardId"));
					transactionVO.setOrderAmount(rs.getString("Tran_OrderAmount"));
					transactionVO.getCardVO().setCardNumber(rs.getString("Card_Number"));
					transactionVO.getCardVO().setName(rs.getString("Card_Name")); -->
					
					<%-- <liferay-ui:search-container-column-text name="Accion">
						<liferay-ui:icon-menu>
							<portlet:actionURL var="editarURL" name="editarInformacion">
								<portlet:param name="idRaza" value="<%=razaVO.getIdRaza()%>"/>
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="jspPage" value="/edit.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon image="edit" message="label.editar" url="<%=editarURL.toString()%>" />
							
							<portlet:actionURL var="eliminarURL" name="eliminarInformacion">
								<portlet:param name="idRaza" value="<%=razaVO.getIdRaza()%>"/>
								<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
								<portlet:param name="jspPage" value="/edit.jsp" />
							</portlet:actionURL>
							<liferay-ui:icon-delete message="label.eliminar" url="<%=eliminarURL.toString()%>" />
							 
						</liferay-ui:icon-menu>
					</liferay-ui:search-container-column-text> --%>
				   </liferay-ui:search-container-row>
				   <liferay-ui:search-iterator />
				</liferay-ui:search-container>
		</div>
	</div>
</aui:form>
