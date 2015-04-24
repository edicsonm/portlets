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
<fmt:setBundle basename="Language"/>
<%
	
	String indiceTransaction = (String)request.getParameter("indiceTransaction");
	ArrayList<TransactionVO> listTransactionsByCustomer = (ArrayList<TransactionVO>)session.getAttribute("listTransactionsByCustomer");
	TransactionVO transactionVO =(TransactionVO)listTransactionsByCustomer.get(Integer.parseInt(indiceTransaction));
	pageContext.setAttribute("transactionVO", transactionVO);
%>
<fieldset class="fieldset">
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			<div class="details">
				<p id="sub-legend" class="description"><fmt:message key="label.paymentDetails"/></p>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-3">
							<dl class="property-list">
								<dt><fmt:message key="label.amount"/></dt>
								<dd><c:out value="${Utils:stripeToCurrency(transactionVO.chargeVO.amount, transactionVO.chargeVO.currency)}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna2-3">
							<dl class="property-list">
								<dt><fmt:message key="label.currency"/></dt>
								<dd><c:out value="${Utils:toUpperCase(transactionVO.chargeVO.currency)}"/></dd>
							</dl>
						</div>
						<div id="columna3-3">
							<dl class="property-list">
								<dt><fmt:message key="label.creationTime"/></dt>
								<dd><c:out value="${Utils:formatDate(3,transactionVO.creationTime,7)}"/></dd>
							</dl>
						</div>
					</div>
				</div>
				
				<p id="sub-legend" class="description"><fmt:message key="label.cardDetails"/></p>
				<hr>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-3">
							<dl class="property-list">
								<dt><fmt:message key="label.name"/></dt>
								<dd><c:out value="${transactionVO.cardVO.name}"/></dd>
							</dl>
						</div>
						<div id="columna2-3">
							<dl class="property-list">
								<dt><fmt:message key="label.cardNumber"/></dt>
								<dd><c:out value="${Utils:printCardNumber(transactionVO.cardVO.number)}"/></dd>
							</dl>
						</div>
						<div id="columna3-3">
							<dl class="property-list">
								<dt><fmt:message key="label.brand"/></dt>
								<dd><c:out value="${transactionVO.cardVO.brand}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-3">
							<dl class="property-list">
								<dt><fmt:message key="label.type"/></dt>
								<dd><c:out value="${Utils:capitalize(transactionVO.cardVO.funding)}"/></dd>
							</dl>
						</div>
						<div id="columna2-3">
							<dl class="property-list">
								<dt><fmt:message key="label.expMonth"/></dt>
								<dd><c:out value="${transactionVO.cardVO.expMonth}"/></dd>
							</dl>
						</div>
						<div id="columna3-3">
							<dl class="property-list">
								<dt><fmt:message key="label.expYear"/></dt>
								<dd><c:out value="${transactionVO.cardVO.expYear}"/></dd>
							</dl>
						</div>
					</div>
					<div id="contenidos">
						<div id="columna1-3">
							<dl class="property-list">
								<dt><fmt:message key="label.countryCard"/></dt>
								<dd><c:out value="${transactionVO.cardVO.country}"/></dd>
							</dl>
						</div>
					</div>
				</div>
				
				<p id="sub-legend" class="description"><fmt:message key="label.transactionDetails"/></p>
				<hr>
				<div id="contenedor">
					<div id="contenidos">
						<div id="columna1-4">
							<dl class="property-list">
								<dt><fmt:message key="label.ipCity"/></dt>
								<dd><c:out value="${transactionVO.ipCity}"/></dd>
							</dl>
						</div>
						<div id="columna2-4">
							<dl class="property-list">
								<dt><fmt:message key="label.ipRegionName"/></dt>
								<dd><c:out value="${transactionVO.ipRegionName}"/></dd>
							</dl>
						</div>
						<div id="columna3-4">
							<dl class="property-list">
								<dt><fmt:message key="label.countryCode"/></dt>
								<dd><c:out value="${transactionVO.countryCode}"/></dd>
							</dl>
						</div>
						<div id="columna4-4">
							<dl class="property-list">
								<dt><fmt:message key="label.countryName"/></dt>
								<dd><c:out value="${transactionVO.ipCountryName}"/></dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
		</div>
	</fieldset>