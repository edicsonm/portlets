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
	backURL.setParameter("tabs", "Business Information");
	backURL.setParameter("jspPage", "/jsp/viewMerchant.jsp");
	
%>
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationPersonal"/></span>
	</legend>
	<div class="">
	<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
			<dl class="property-list">
				<dt><fmt:message key="label.firstName"/></dt>
				<dd><c:out value="${merchantVO.firstName}"/></dd>
				
				<dt><fmt:message key="label.lastName"/></dt>
				<dd><c:out value="${merchantVO.lastName}"/></dd>
				
				<dt><fmt:message key="label.phoneNumber"/></dt>
				<dd><c:out value="${merchantVO.phoneNumber}"/></dd>
				
				<dt><fmt:message key="label.faxNumber"/></dt>
				<dd><c:out value="${merchantVO.faxNumber}"/></dd>
				
				<dt><fmt:message key="label.emailAddress"/></dt>
				<dd><c:out value="${merchantVO.emailAddress}"/></dd>
				
				<dt><fmt:message key="label.alternateEmailAddress"/></dt>
				<dd><c:out value="${merchantVO.alternateEmailAddress}"/></dd>
				
				<dt><fmt:message key="label.cityPersonalInformation"/></dt>
				<dd><c:out value="${merchantVO.cityPersonalInformation}"/></dd>
				
				<dt><fmt:message key="label.postCodePersonalInformation"/></dt>
				<dd><c:out value="${merchantVO.postCodePersonalInformation}"/></dd>
				
				<dt><fmt:message key="label.countryPersonalInformation"/></dt>
				<dd><c:out value="${merchantVO.countryVOPersonalInformation.name}"/></dd>
				
			</dl>
		</div>
		<a class="btn" href="<%= backURL %>"><fmt:message key="label.goBack"/></a>
	</div>
</fieldset>
