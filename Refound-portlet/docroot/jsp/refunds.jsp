<%@ include file="init.jsp" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>

<%@ page import="javax.portlet.PortletURL" %>
<%@ page import="com.liferay.portlet.PortletURLUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.portlet.ActionRequest" %>


<%@ page import="au.com.billingbuddy.vo.objects.RefundVO" %>
<%@ page import="java.util.ArrayList" %>
<portlet:defineObjects />
<liferay-theme:defineObjects />
Pagina incluida
<%
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
	
	System.out.println("orderByColRefunds: " + orderByColRefunds);
	System.out.println("orderByTypeRefunds: " + orderByTypeRefunds);
	
	System.out.println("listRefunds en refunds.jsp: " + listRefunds.size());
%>
<% 
	Integer count = (Integer)request.getAttribute("count"); 
	Integer delta = (Integer)request.getAttribute("delta");
	if(delta == null){
	    delta = 20;
	}
	if(count == null){
        count = 0;
    }

	String search = (String) request.getAttribute("search");
	if(search == null){
	    search = "";    
	}
	/* PortletURL portletURL = renderResponse.createRenderURL();
	PortletURL portletURL = renderResponse.createActionURL();
    portletURL.setParameter("action", "search");
    portletURL.setParameter("entity", "hospital");
    portletURL.setParameter("search", search); */
    
    System.out.println("delta: " + delta);
    System.out.println("count: " + count);
%>
<div class="row">

	<liferay-ui:search-container delta="10" emptyResultsMessage="no-users-were-found">
		<liferay-ui:search-container-results results="<%= listRefunds %>" total="<%= listRefunds.size() %>"/>

	<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.RefundVO" keyProperty="id" modelVar="refundVO">
		<liferay-ui:search-container-column-text name="Id" value="<%= refundVO.getId() %>"/>
		<%-- <liferay-ui:search-container-column-text name="first-name" property="firstName"/> --%>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>



		<%-- <liferay-ui:search-container-results total="<%= count %>" results="<%= listRefunds %>" />
		<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.RefundVO" rowVar="posi" indexVar="indiceTable" keyProperty="id" modelVar="refundVO">
			<liferay-ui:search-container-column-text name="Refund" property="id" value="id" orderable="false" orderableProperty="id"/>
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator /> --%>
			
		<%-- <liferay-ui:search-container delta="10" iteratorURL="<%= portletURL %>" emptyResultsMessage="no-users-were-found">
			<liferay-ui:search-container-results total="<%= count %>" results="<%= listRefunds %>" />
			<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.RefundVO" rowVar="posi" indexVar="indiceTable" keyProperty="id" modelVar="refundVO">
				<liferay-ui:search-container-column-text name="Refund" property="id" value="id" orderable="false" orderableProperty="id"/>
			</liferay-ui:search-container-row>
			<liferay-ui:search-iterator />
		</liferay-ui:search-container> --%>
		
		<%-- <liferay-ui:search-container emptyResultsMessage="label.noRegistros" delta="30" iteratorURL="<%=iteratorURL%>" orderByCol="<%=orderByColRefunds%>" orderByType="<%=orderByTypeRefunds%>">
		   <liferay-ui:search-container-results>
		      <%
		      	listRefunds = Methods.orderRefunds(listRefunds,orderByColRefunds,orderByTypeRefunds);
				results = ListUtil.subList(listRefunds, searchContainer.getStart(), searchContainer.getEnd());
				total = listRefunds.size();
				pageContext.setAttribute("resultsRefunds", results);
				pageContext.setAttribute("totalRefunds", total);
				/* session.setAttribute("results", results); */
		       %>
			</liferay-ui:search-container-results>
			<liferay-ui:search-container-row className="au.com.billingbuddy.vo.objects.RefundVO" rowVar="posi" indexVar="indiceTable" keyProperty="id" modelVar="refundVO">
				
				<liferay-portlet:renderURL  varImpl="rowURL">
					<portlet:param name="mvcPath" value="/jsp/refund.jsp" />
					<portlet:param name="indiceTable" value="<%=String.valueOf(indiceTable)%>"/>
				</liferay-portlet:renderURL>
			
			<liferay-ui:search-container-column-text name="Refund" property="id" value="id" orderable="false" orderableProperty="id" href="<%= rowURL %>"/>
			<liferay-ui:search-container-column-text name="Currency" property="currency" orderable="true" orderableProperty="currency" />
			<liferay-ui:search-container-column-text name="Amount" property="amount" orderable="true" orderableProperty="amount" />
			<liferay-ui:search-container-column-text name="Charge Date" property="creationTime" orderable="true" orderableProperty="creationTime" />
			<liferay-ui:search-container-column-text name="Last 4 Digits Card Number" property="cardVO.last4" orderable="true" orderableProperty="cardVO.last4" />
			<liferay-ui:search-container-column-text name="Brand" property="cardVO.brand" orderable="true" orderableProperty="cardVO.brand" />
			<liferay-ui:search-container-column-text name="Funding" property="cardVO.funding" orderable="true" orderableProperty="cardVO.funding" />
		   </liferay-ui:search-container-row>
		   <liferay-ui:search-iterator />
		</liferay-ui:search-container>	 --%>				

</div>
<div class="row">
	Estoy aca !!!
</div>