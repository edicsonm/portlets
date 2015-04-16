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
	
	String indice = (String)request.getParameter("indice");
	ArrayList<CardVO> listCardsByCustomer = (ArrayList<CardVO>)session.getAttribute("listCardsByCustomer");
	CardVO cardVO =(CardVO)listCardsByCustomer.get(Integer.parseInt(indice));
	pageContext.setAttribute("cardVO", cardVO);
	
%>
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.cardDetails"/> </span>
	</legend>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
			<div id="contenedor">
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.name"/></dt>
							<dd><c:out value="${cardVO.name}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.cardNumber"/></dt>
							<dd><c:out value="${Utils:printCardNumber(cardVO.number)}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.brand"/></dt>
							<dd><c:out value="${cardVO.brand}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.expire"/></dt>
							<dd><c:out value="${cardVO.expMonth} - ${cardVO.expYear}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-3">
						<dl class="property-list">
							<dt><fmt:message key="label.addressCity"/></dt>
							<dd><c:out value="${cardVO.addressCity}"/></dd>
						</dl>
					</div>
					<div id="columna2-3">
						<dl class="property-list">
							<dt><fmt:message key="label.addressState"/></dt>
							<dd><c:out value="${cardVO.addresState}"/></dd>
						</dl>
					</div>
					<div id="columna3-3">
						<dl class="property-list">
							<dt><fmt:message key="label.addressCountry"/></dt>
							<dd><c:out value="${cardVO.addressCountry}"/></dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
	</div>
</fieldset>