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
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<% 
	ArrayList<CertificateVO> resultsListCertificates = (ArrayList<CertificateVO>)session.getAttribute("results");
	CertificateVO certificateVO = (CertificateVO)resultsListCertificates.get(Integer.parseInt(ParamUtil.getString(request, "indice")));
	request.setAttribute("certificateVO", certificateVO);
%>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<aui:form method="post">
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.informationCertificateGeneration"/></label>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.merchant"/></label>
				</div>
				<div class="column2-4">
					<c:out value="${certificateVO.merchantId}"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.commonName"/></label>
				</div>
				<div class="column4-4">
					<c:out value="${certificateVO.commonName}"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.creationTime"/></label>
				</div>
				<div class="column2-4">
					<c:out value="<%=Utilities.formatDate(certificateVO.getCreationTime()) %>"/>
				</div>
				<div class="column3-4">
					<label class="aui-field-label"><fmt:message key="label.expirationTime"/></label>
				</div>
				<div class="column4-4">
					<c:out value="<%=Utilities.formatDate(certificateVO.getExpirationTime()) %>"/>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-4">
					<label class="aui-field-label"><fmt:message key="label.status"/></label>
				</div>
				<div class="column2-4">
					<%
						if(!certificateVO.getStatus().equalsIgnoreCase("1")) {%><fmt:message key="label.active"/><%
						}else{%> <fmt:message key="label.inactive"/><%}
					%>
				</div>
				<div class="column3-4">
				</div>
				<div class="column4-4">
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
					<span class="goBack" >
						<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
					</span>
				</div>
			</div>
		</div>
	</div>
</aui:form>