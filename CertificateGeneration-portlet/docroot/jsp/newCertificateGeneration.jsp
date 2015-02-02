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
<liferay-ui:error key="SecurityMDTR.certificateGeneration.CertificateDAOException" message="error.SecurityMDTR.certificateGeneration.CertificateDAOException" />
<liferay-ui:error key="SecurityMDTR.certificateGeneration.Exception" message="error.SecurityMDTR.certificateGeneration.Exception" />

<% 
	CertificateVO certificateVO = (CertificateVO)session.getAttribute("certificateVO");
	ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
%>

<portlet:actionURL name="saveCertificateGeneration" var="submitForm">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBack">
	<portlet:param name="jspPage" value="/jsp/view.jsp" />
</portlet:renderURL>


<portlet:resourceURL var="searchMerchantInformation" >
	<%-- <portlet:param name="action" value="chargeMerchantInformation" />
	<portlet:param name="idMerchant" value="<%=certificateVO.getId()%>" /> --%>
</portlet:resourceURL>

<script>
/* 	$("select#_CertificateGeneration_WAR_CertificateGenerationportlet_merchant").change(function() {
		alert( "Handler for .change() called." );
	});
 */
function searchMerchantInformation(){
	var url = '<%=searchMerchantInformation%>';
    $.ajax({
    type : "GET",
    url : url,
    cache:false,
    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    dataType: "json",
    data: {idMerchant:$("#<portlet:namespace />merchant").find('option:selected').attr('value'), action:"chargeMerchantInformation"},
    success : function(data){
    	
    	$("#<portlet:namespace />commonName").val(data.commonName);
    	$("#<portlet:namespace />organization").val(data.organization);
    	$("#<portlet:namespace />organizationUnit").val(data.organizationUnit);
    	
    	
    	/* alert("Termina: " + data.saludo); */
    	/* jsonObject.put("commonName", merchantVO.getName());
		jsonObject.put("organization", merchantVO.getName());
		jsonObject.put("organizationUnit", "IT-Security"); */
		
		/* $("#_CertificateGeneration_WAR_CertificateGenerationportlet_commonName").val( data.commonName ); */
		/* alert(data.commonName); */
    	<%-- $("#certificate").html(data);
    	$( "#certificate" ).load('<%=renderRequest.getContextPath()%>'+'/jsp/refunds.jsp');
    	$( "#listRefunds" ).load("<%=ajaxUrl%>"); --%>
    },error : function(XMLHttpRequest, textStatus, errorThrown){
          alert("XMLHttpRequest..." + XMLHttpRequest);
          alert("textStatus..." + textStatus);
          alert("errorThrown..." + errorThrown);
    }
  });
}

</script>
<aui:form  action="<%= submitForm %>" method="post">
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
				<div class="column1-1">
					<aui:select name="merchant" onChange="searchMerchantInformation();" helpMessage="help.merchant" label="label.merchant" id="merchant">
						<%-- <aui:option value="" label=""/> --%>
						<c:forEach var="merchantVO" items="${listMerchants}">
							<aui:option value="${merchantVO.id}" label="${merchantVO.name}" selected="${merchantVO.id==certificateVO.merchantId}"/>
						</c:forEach>
					</aui:select>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.commonName" helpMessage="help.commonName" showRequiredLabel="false" type="text" id="commonName" required="true" name="commonName" value="${certificateVO.commonName}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.organization" helpMessage="help.organization" showRequiredLabel="false" type="text" required="true" name="organization" value="${certificateVO.organization}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.organizationUnit" helpMessage="help.organizationUnit" showRequiredLabel="false" type="text" required="true" name="organizationUnit" value="${certificateVO.organizationUnit}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.country" helpMessage="help.country" showRequiredLabel="false" type="text" required="true" name="country" value="${certificateVO.country}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
			</div>
			
			
			<div class="row">
				<div class="column1-2">
					<aui:input label="label.passwordKeyStore" helpMessage="help.passwordKeyStore" showRequiredLabel="false" type="password" required="true" name="passwordKeyStore" value="${certificateVO.passwordKeyStore}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
				<div class="column2-2">
					<aui:input label="label.passwordKeyStoreConfirmation" helpMessage="help.passwordKeyStoreConfirmation" showRequiredLabel="false" type="password" required="true" name="passwordKeyStoreConfirmation" value="${certificateVO.passwordKeyStore}">
						<aui:validator name="equalTo">'#<portlet:namespace />passwordKeyStore'</aui:validator>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
					<aui:input label="label.passwordkey" helpMessage="help.passwordkey" showRequiredLabel="false" type="password" required="true" name="passwordkey" value="${certificateVO.passwordkey}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
				<div class="column2-2">
					<aui:input label="label.passwordkeyConfirmation" helpMessage="help.passwordkeyConfirmation" showRequiredLabel="false" type="password" required="true" name="passwordkeyConfirmation" value="${certificateVO.passwordkey}">
						<aui:validator name="equalTo">'#<portlet:namespace />passwordkey'</aui:validator>
					</aui:input>
				</div>
			</div>
			
			<%-- <div class="row">
				<div class="column1-2">
					<aui:input label="label.privacyKeyStore" helpMessage="help.privacyKeyStore" showRequiredLabel="false" type="password" required="true" name="privacyKeyStore" value="${certificateVO.privacyKeyStore}">
						<aui:validator name="required"/>
					</aui:input>
				</div>
				<div class="column2-2">
					<aui:input label="label.privacyKeyStoreConfirmation" helpMessage="help.privacyKeyStoreConfirmation" showRequiredLabel="false" type="password" required="true" name="privacyKeyStoreConfirmation" value="${certificateVO.privacyKeyStoreConfirmation}">
						<aui:validator name="equalTo">'#<portlet:namespace />privacyKeyStore'</aui:validator>
					</aui:input>
				</div>
			</div> --%>
			
			
			
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.keyName" helpMessage="help.keyName" showRequiredLabel="false" type="text" required="true" name="keyName" value="${certificateVO.keyName}">
						<%-- <aui:validator name="alphanum"/> --%>
					</aui:input>
				</div>
			</div>
			
			<div class="row">
				<div class="column1-2">
						<span class="goBack" >
							<a href="<%= goBack %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
				<div class="column2-2">
					<aui:button type="submit" name="save" value="label.save" />
				</div>
			</div>
		</div>
	</div>
</aui:form>
<script>
	searchMerchantInformation();
</script>