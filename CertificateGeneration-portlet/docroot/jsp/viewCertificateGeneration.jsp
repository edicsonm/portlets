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

<%-- <portlet:actionURL var="downloadCertificate" name="downloadCertificate"/>--%>

<portlet:resourceURL var="downloadCertificate" >
	<portlet:param name="action" value="downloadCertificate" />
	<portlet:param name="idCertificate" value="<%=certificateVO.getId()%>" />
</portlet:resourceURL>

<portlet:renderURL var="goBackIndustryCertificate">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>

<script type="text/javascript">
<%-- function downloadCertificate() {
	var url = '<%=downloadCertificate%>';
    $.ajax({
    type : "GET",
    url : url,
    cache:false,
    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    dataType: "html",
    data: {idCertificate:<%=certificateVO.getId()%>},
    success : function(data){
    	alert("Termina: " + data);
    	$("#certificate").html(data);
    	$( "#certificate" ).load('<%=renderRequest.getContextPath()%>'+'/jsp/refunds.jsp');
    	$( "#listRefunds" ).load("<%=ajaxUrl%>");
    },error : function(XMLHttpRequest, textStatus, errorThrown){
          alert("XMLHttpRequest..." + XMLHttpRequest);
          alert("textStatus..." + textStatus);
          alert("errorThrown..." + errorThrown);
    }
  });
}; --%>
</script>

<aui:form method="post">

<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationCertificateGeneration"/> </span>
	</legend>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="details">
		<div id="contenedor">
			<div id="contenidos">
				<div id="columna1-2">
					<dl class="property-list">
						<dt><fmt:message key="label.merchant"/></dt>
						<dd><c:out value="${certificateVO.merchantVO.name}"/></dd>
					</dl>
				</div>
				<div id="columna2-2">
					<dl class="property-list">
						<dt><fmt:message key="label.commonName"/></dt>
						<dd><c:out value="${certificateVO.commonName}"/></dd>
					</dl>
				</div>
			</div>
			<div id="contenidos">
				<div id="columna1-2">
					<dl class="property-list">
						<dt><fmt:message key="label.creationTime"/></dt>
						<dd><c:out value="<%=Utilities.formatDate(certificateVO.getCreationTime()) %>"/></dd>
					</dl>
				</div>
				<div id="columna2-2">
					<dl class="property-list">
						<dt><fmt:message key="label.expirationTime"/></dt>
						<dd><c:out value="${Utils:formatDate(3,certificateVO.expirationTime,5)}"/></dd>
					</dl>
				</div>
			</div>
			<div id="contenidos">
				<div id="columna1-2">
					<dl class="property-list">
						<dt><fmt:message key="label.status"/></dt>
						<dd>
							<%
								if(!certificateVO.getStatus().equalsIgnoreCase("1")) {%><fmt:message key="label.active"/><%
								}else{%> <fmt:message key="label.inactive"/><%}
							%>
						</dd>
					</dl>
				</div>
			</div>
		</div>
		</div>
		<a href="<%= goBackIndustryCertificate %>"><fmt:message key="label.goBack"/></a>
		<a class="btn btn-primary" href="<%= downloadCertificate %>"><fmt:message key="label.downloadCertificate"/></a>
	</div>
</fieldset>
</aui:form>