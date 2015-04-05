<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="au.com.billingbuddy.vo.objects.MerchantVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.CountryVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.BusinessTypeVO" %>
<%@ page import="au.com.billingbuddy.vo.objects.IndustryVO" %>

<portlet:defineObjects />
<fmt:setBundle basename="Language"/>
<% 
	MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
	ArrayList<CountryVO> listCountries = (ArrayList<CountryVO>)session.getAttribute("listCountries");
	ArrayList<BusinessTypeVO> listBusinessTypes = (ArrayList<BusinessTypeVO>)session.getAttribute("listBusinessTypes");
	ArrayList<IndustryVO> listIndustries = (ArrayList<IndustryVO>)session.getAttribute("listIndustries");
%>
<fieldset class="fieldset">
	<legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationBusiness"/></span>
	</legend>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="control-group">
			<aui:input label="label.name" helpMessage="help.name" name="name" value="${merchantVO.name}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.tradingName" helpMessage="help.tradingName" name="tradingName" value="${merchantVO.tradingName}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.legalPhysicalAddress" helpMessage="help.legalPhysicalAddress" name="legalPhysicalAddress" value="${merchantVO.legalPhysicalAddress}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input name="statementAddress"  label="label.statementAddress" helpMessage="help.statementAddress" value="${merchantVO.statementAddress}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.taxFileNumber" helpMessage="help.taxFileNumber" name="taxFileNumber" value="${merchantVO.taxFileNumber}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.cityBusinessInformation" helpMessage="help.cityBusinessInformation" name="cityBusinessInformation" value="${merchantVO.cityBusinessInformation}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.postCodeBusinessInformation" helpMessage="help.postCodeBusinessInformation" name="postCodeBusinessInformation" value="${merchantVO.postCodeBusinessInformation}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:select name="countryBusinessInformation" helpMessage="help.countryBusinessInformation"  label="label.countryBusinessInformation" id="countryBusinessInformation">
				<c:forEach var="countryVO" items="${listCountries}">
					<aui:option value="${countryVO.numeric}" label="${countryVO.name}" selected="${countryVO.numeric==merchantVO.countryNumericMerchant}"/>
				</c:forEach>
			</aui:select>
		</div>
		
		<div class="control-group">
			<aui:select name="businessType" helpMessage="help.businessType"  label="label.businessType" id="businessType">
				<c:forEach var="businessTypeVO" items="${listBusinessTypes}">
					<aui:option value="${businessTypeVO.id}" label="${businessTypeVO.description}" selected="${businessTypeVO.id==merchantVO.businessTypeId}"/>
				</c:forEach>
			</aui:select>
		</div>
		
		<div class="control-group">
			<aui:select name="industry" helpMessage="help.industry"  label="label.industry" id="industry">
				<c:forEach var="industryVO" items="${listIndustries}">
					<aui:option value="${industryVO.id}" label="${industryVO.description}" selected="${industryVO.id==merchantVO.industryId}"/>
				</c:forEach>
			</aui:select>
		</div>
		
		<div class="control-group">
			<aui:input label="label.issuedBusinessID" helpMessage="help.issuedBusinessID" name="issuedBusinessID" value="${merchantVO.issuedBusinessID}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.issuedPersonalID" helpMessage="help.issuedPersonalID" name="issuedPersonalID" value="${merchantVO.issuedPersonalID}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.typeAccountApplication" helpMessage="help.typeAccountApplication" name="typeAccountApplication" value="${merchantVO.typeAccountApplication}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input label="label.estimatedAnnualSales" helpMessage="help.estimatedAnnualSales" name="estimatedAnnualSales" value="${merchantVO.estimatedAnnualSales}" showRequiredLabel="false" type="text" required="true" >
			</aui:input>
		</div>
		
		<button class="btn" type="submit"><fmt:message key="label.next"/></button>
	</div>
</fieldset>
