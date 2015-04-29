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
	
	String idSubscription = (String)request.getParameter("idSubscription");
	SubscriptionVO subscriptionVO = new SubscriptionVO();
	subscriptionVO.setId(idSubscription);
	
	ArrayList<SubscriptionVO> listSubscriptionsByCustomer = (ArrayList<SubscriptionVO>)session.getAttribute("listSubscriptionsByCustomer");
	int indiceSubscription = listSubscriptionsByCustomer.indexOf(subscriptionVO);
	
	subscriptionVO =(SubscriptionVO)listSubscriptionsByCustomer.get(indiceSubscription);
	pageContext.setAttribute("subscriptionVO", subscriptionVO);
	
%>
<fieldset class="fieldset">
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
			<div id="contenedor">
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.plan"/></dt>
							<dd><c:out value="${subscriptionVO.planVO.name}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.quantity"/></dt>
							<dd><c:out value="${subscriptionVO.quantity}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.trialStart"/></dt>
							<dd><c:out value="${Utils:formatDate(3,subscriptionVO.trialStart,5)}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.trialEnd"/></dt>
							<dd><c:out value="${Utils:formatDate(3,subscriptionVO.trialEnd,5)}"/></dd>
						</dl>
					</div>
				</div>
				<div id="contenidos">
					<div id="columna1-2">
						<dl class="property-list">
							<dt><fmt:message key="label.start"/></dt>
							<dd><c:out value="${Utils:formatDate(3,subscriptionVO.start,5)}"/></dd>
						</dl>
					</div>
					<div id="columna2-2">
						<dl class="property-list">
							<dt><fmt:message key="label.status"/></dt>
							<dd><c:out value="${subscriptionVO.status}"/></dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
	</div>
</fieldset>