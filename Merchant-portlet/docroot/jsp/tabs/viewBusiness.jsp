<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="javax.portlet.PortletURL"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="au.com.billingbuddy.vo.objects.MerchantVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.CountryVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.BusinessTypeVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.IndustryVO" %>

<portlet:defineObjects />
<fmt:setBundle basename="Language"/>
<% 
	PortletURL backURL = renderResponse.createRenderURL();
	backURL.setParameter("jspPage", "/jsp/view.jsp");
	
	PortletURL forwardURL = renderResponse.createRenderURL();
	forwardURL.setParameter("tabs", "Contact Information");
	forwardURL.setParameter("jspPage", "/jsp/viewMerchant.jsp");
%>

<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationBusiness"/> </span>
	</legend>
	<div class="">
		<div class="details">
			<dl class="property-list">
				<dt><fmt:message key="label.name"/></dt>
				<dd><c:out value="${merchantVO.name}"/></dd>
				
				<dt><fmt:message key="label.tradingName"/></dt>
				<dd><c:out value="${merchantVO.tradingName}"/></dd>
				
				<dt><fmt:message key="label.legalPhysicalAddress"/></dt>
				<dd><c:out value="${merchantVO.legalPhysicalAddress}"/></dd>
				
				<dt><fmt:message key="label.statementAddress"/></dt>
				<dd><c:out value="${merchantVO.statementAddress}"/></dd>
				
				<dt><fmt:message key="label.taxFileNumber"/></dt>
				<dd><c:out value="${merchantVO.taxFileNumber}"/></dd>
				
				<dt><fmt:message key="label.cityBusinessInformation"/></dt>
				<dd><c:out value="${merchantVO.cityBusinessInformation}"/></dd>
				
				<dt><fmt:message key="label.postCodeBusinessInformation"/></dt>
				<dd><c:out value="${merchantVO.postCodeBusinessInformation}"/></dd>
				
				<dt><fmt:message key="label.countryBusinessInformation"/></dt>
				<dd><c:out value="${merchantVO.countryVOBusiness.name}"/></dd>
				
				<dt><fmt:message key="label.businessType"/></dt>
				<dd><c:out value="${merchantVO.businessTypeVO.description}"/></dd>
				
				<dt><fmt:message key="label.industry"/></dt>
				<dd><c:out value="${merchantVO.industryVO.description}"/></dd>
				
				<dt><fmt:message key="label.issuedBusinessID"/></dt>
				<dd><c:out value="${merchantVO.issuedBusinessID}"/></dd>
				
				<dt><fmt:message key="label.issuedPersonalID"/></dt>
				<dd><c:out value="${merchantVO.issuedPersonalID}"/></dd>
				
				<dt><fmt:message key="label.typeAccountApplication"/></dt>
				<dd><c:out value="${merchantVO.typeAccountApplication}"/></dd>
				
				<dt><fmt:message key="label.estimatedAnnualSales"/></dt>
				<dd><c:out value="${merchantVO.estimatedAnnualSales}"/></dd>
				
			</dl>
		</div>
	<a class="btn" href="<%= backURL %>"><fmt:message key="label.goBack"/></a>
	<a class="btn" href="<%= forwardURL %>"><fmt:message key="label.next"/></a>
	</div>
</fieldset>
