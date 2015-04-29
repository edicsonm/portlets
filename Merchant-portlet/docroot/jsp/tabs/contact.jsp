<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
		<span class="legend"><fmt:message key="label.informationPersonal"/></span>
	</legend>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		<div class="control-group">
			<aui:input name="firstName"  label="label.firstName" helpMessage="help.firstName" value="${merchantVO.firstName}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input name="lastName"  label="label.lastName" helpMessage="help.lastName" value="${merchantVO.lastName}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input name="phoneNumber"  label="label.phoneNumber" helpMessage="help.phoneNumber" value="${merchantVO.phoneNumber}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input name="faxNumber"  label="label.faxNumber" helpMessage="help.faxNumber" value="${merchantVO.faxNumber}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input name="emailAddress"  label="label.emailAddress" helpMessage="help.emailAddress" value="${merchantVO.emailAddress}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input name="alternateEmailAddress"  label="label.alternateEmailAddress" helpMessage="help.alternateEmailAddress" value="${merchantVO.alternateEmailAddress}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input name="cityPersonalInformation"  label="label.cityPersonalInformation" helpMessage="help.cityPersonalInformation" value="${merchantVO.cityPersonalInformation}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:input name="postCodePersonalInformation"  label="label.postCodePersonalInformation" helpMessage="help.postCodePersonalInformation" value="${merchantVO.postCodePersonalInformation}" showRequiredLabel="false" type="text" required="true">
			</aui:input>
		</div>
		
		<div class="control-group">
			<aui:select name="countryPersonalInformation" helpMessage="help.countryPersonalInformation"  label="label.countryPersonalInformation" id="countryPersonalInformation">
				<c:forEach var="countryVO" items="${listCountries}">
					<aui:option value="${countryVO.numeric}" label="${countryVO.name}" selected="${countryVO.numeric==merchantVO.countryNumericPersonalInformation}"/>
				</c:forEach>
			</aui:select>
		</div>
		
		<button class="btn" id="atras" name="atras" type="button" onclick="submitTheForm();"><fmt:message key="label.goBack"/></button>
		<aui:button class="btn btn-primary" type="submit" id="save" name="save" value="label.save" />
	</div>
</fieldset>
