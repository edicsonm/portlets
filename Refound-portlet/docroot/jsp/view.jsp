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
<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<%-- <liferay-ui:error key="success" message="label.success" />
<liferay-ui:error key="error" message="label.unsatisfactoryRegistration" />
<liferay-ui:error key="claveDuplicada" message="error.claveDuplicada"  /> --%>
<aui:script use="aui">
	showDetails = function(val){
		alert(val);
	}
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
	/* com.liferay.portal.kernel.dao.search.SearchContainer<ChargeVO> searchContainer = null; */
	ArrayList<ChargeVO> listCharge = (ArrayList)session.getAttribute("listCharge");
	if(listCharge == null) listCharge = new ArrayList<ChargeVO>();
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
				<liferay-ui:search-container emptyResultsMessage="label.noRegistros" delta="10" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
				   <liferay-ui:search-container-results>
				      <%
						listCharge = Methods.orderCharges(listCharge,orderByCol,orderByType);
						results = ListUtil.subList(listCharge, searchContainer.getStart(), searchContainer.getEnd());
						total = listCharge.size();
						pageContext.setAttribute("results", results);
						pageContext.setAttribute("total", total);
						session.setAttribute("results", results);
				       %>
					</liferay-ui:search-container-results>
					<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.ChargeVO" rowVar="posi" indexVar="indice" keyProperty="id" modelVar="chargeVO">
						
						<liferay-portlet:renderURL varImpl="rowURL">
							<portlet:param name="mvcPath" value="/jsp/refund.jsp" />
							<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
						</liferay-portlet:renderURL>
					
					<liferay-ui:search-container-column-text name="Charge" property="id" value="transactionId" orderable="true" orderableProperty="id" href="<%= rowURL %>"/>
					<liferay-ui:search-container-column-text name="Currency" property="currency" orderable="true" orderableProperty="currency" />
					<liferay-ui:search-container-column-text name="Amount" property="amount" orderable="true" orderableProperty="amount" />
					<liferay-ui:search-container-column-text name="Charge Date" property="creationTime" orderable="true" orderableProperty="creationTime" />
					<%-- <liferay-ui:search-container-column-text name="Last 4 Digits Card Number" property="cardVO.last4" orderable="true" orderableProperty="cardVO.last4" />
					<liferay-ui:search-container-column-text name="Brand" property="cardVO.brand" orderable="true" orderableProperty="cardVO.brand" />
					<liferay-ui:search-container-column-text name="Funding" property="cardVO.funding" orderable="true" orderableProperty="cardVO.funding" /> --%>
				   </liferay-ui:search-container-row>
				   <liferay-ui:search-iterator />
				</liferay-ui:search-container>
		</div>
	</div>
</aui:form>