<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="co"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util"%>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.GregorianCalendar"%>
<%@ page import="java.util.Locale"%>

<%@ page import="com.liferay.portal.kernel.util.CalendarFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.dao.search.SearchContainer"%>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="au.com.billingbuddy.porlet.utilities.Methods" %>
<%@ page import="au.com.billingbuddy.common.objects.Utilities" %>
<%@ page import="au.com.billingbuddy.common.objects.Currency" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="au.com.billingbuddy.vo.objects.TransactionVO" %>
<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<%
	TransactionVO transactionVOTransactions = (TransactionVO)session.getAttribute("transactionVOTransactions");
%>


bla bla bla !!! <%out.print(transactionVOTransactions.getInitialDateReport()); %>

<% 
	String orderByCol= "creationTime";
	String orderByType = "asc";
	
	/* String orderByColAnterior = (String)session.getAttribute("orderByCol");
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
	}	 */

	ArrayList<TransactionVO> listTransactionsByDay = (ArrayList<TransactionVO>)session.getAttribute("listTransactionsByDay");
	if(listTransactionsByDay == null) listTransactionsByDay = new ArrayList<TransactionVO>();
	System.out.println("listTransactionsByDay.size() en view.jsp: " + listTransactionsByDay.size());
	
	TransactionVO transactionVOAux = (TransactionVO)session.getAttribute("transactionVO");
	if(transactionVOAux != null){
		System.out.println("Fecha guardada: " + Utilities.getDateFormat(6).format(Utilities.getDateFormat(2).parse(transactionVOAux.getInitialDateReport())));
	}
	
%>
<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />

<div class="table">
		<div class="row">	
			<liferay-ui:search-container emptyResultsMessage="label.empty" delta="30" iteratorURL="<%=renderURL%>" orderByCol="<%=orderByCol%>" orderByType="<%=orderByType%>">
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