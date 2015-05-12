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
<% 
	boolean answerSubscription = false;
	if(session.getAttribute("answerSubscription") != null && String.valueOf(session.getAttribute("answerSubscription")).equalsIgnoreCase("true")){
		answerSubscription = true;
	}
	
	Calendar calendar = new GregorianCalendar();
	Calendar cal = CalendarFactoryUtil.getCalendar();
	int initialYear = cal.get(Calendar.YEAR) + 1;
	
	SubscriptionVO subscriptionVO = (SubscriptionVO)session.getAttribute("subscriptionVO");
	ArrayList<PlanVO> listPlans = (ArrayList<PlanVO>)session.getAttribute("listPlans");
	ArrayList<CardVO> listCardsByCustomer = (ArrayList<CardVO>)session.getAttribute("listCardsByCustomer");
	
%>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>

<liferay-ui:success key="subscriptionSavedSuccessfully" message="label.subscriptionSavedSuccessfully" />
<liferay-ui:error key="ProcessorMDTR.saveSubscription.SubscriptionDAOException" message="error.ProcessorMDTR.saveSubscription.SubscriptionDAOException" />
<liferay-ui:error key="ProcessorMDTR.saveSubscription.SubscriptionDAOException.UNIQUE_Plan_ID_Mcca_ID" message="error.ProcessorMDTR.saveSubscription.SubscriptionDAOException.UNIQUE_Plan_ID_Mcca_ID" />


<portlet:resourceURL var="viewContentURL">
	<portlet:param name="action" value="trialStartDate"/>
	<portlet:param name="jspPage" value="/jsp/addSubscription.jsp" />
</portlet:resourceURL>

<portlet:actionURL name="saveSubscription" var="submitFormSubscription"/>

<script>
	function trialEnd() {
		var url = '<%=viewContentURL%>';
	    $.ajax({
	    type : "POST",
	    url : url,
	    cache:false,
	    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    dataType: "json",
	    data: {<portlet:namespace/>planId: $("#<portlet:namespace />plan").find('option:selected').attr('value'),
	    	<portlet:namespace/>trialEndDay: $("#<portlet:namespace />plan").find('option:selected').attr('value')},
	    success : function(data){
	    	$("#<portlet:namespace />trialEndDay").val(data.trialEnd);
	    },error : function(XMLHttpRequest, textStatus, errorThrown){
	    	alert('failure');
	    	alert("XMLHttpRequest..." + XMLHttpRequest);
          	alert("textStatus..." + textStatus);
          	alert("errorThrown..." + errorThrown);
	    }
	  });
	};
</script>

	
<aui:script> 
  
   YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />trialStartDay',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);	
	
	YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />trialEndDay',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
	
</aui:script>

<aui:form  action="<%= submitFormSubscription %>" method="post">
<fieldset class="fieldset">
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		
		<div class="control-group">
			<aui:select name="card" helpMessage="help.cardNumber"  label="label.cardNumber" id="card">
				<c:forEach var="cardVO" items="${listCardsByCustomer}">
					<aui:option value="${cardVO.merchantCustomerCardId}" label="${Utils:printCardNumber(cardVO.number)}" selected="${cardVO.merchantCustomerCardId==subscriptionVO.merchantCustomerCardId}"/>
				</c:forEach>
			</aui:select>
		</div>
	
		<div class="control-group">
			<aui:select name="plan" onChange="trialEnd();" helpMessage="help.plan"  label="label.plan" id="plan">
				<c:forEach var="planVO" items="${listPlans}">
					<aui:option value="${planVO.id}" label="${planVO.name}" selected="${planVO.id==subscriptionVO.planId}"/>
				</c:forEach>
			</aui:select>
		</div>
		
		<div class="control-group">
			<aui:input label="label.quantity" helpMessage="help.quantity" showRequiredLabel="false" size="3" type="text" required="true" name="quantity" value="${subscriptionVO.quantity}">
				<aui:validator name="digits"/>
			</aui:input>
		</div>
		
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />trialStartPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDateDefaultValue(6,subscriptionVO.trialStart,6,0)}" label="label.trialStart" helpMessage="help.trialStart" showRequiredLabel="false" size="10" type="text" required="true" name="trialStartDay">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />trialEndPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDateDefaultValue(6,subscriptionVO.trialEnd,6,0)}" label="label.trialEnd" helpMessage="help.trialEnd" showRequiredLabel="false" size="10" type="text" required="true" name="trialEndDay">
					 <aui:validator name="date" />
					 <aui:validator name="custom" errorMessage="error.invalidDate">
						function (val, fieldNode, ruleValue) {
							var startDateObj = document.getElementById("<portlet:namespace />trialStartDay");
							var startDate;
                            var result=false;
							if(val == ""){ return true;}
							if(startDateObj) {
                                startDate = new Date(startDateObj.value);
                            }else{
                                result = false;
                            }
                            var endDate = new Date(val);
                            if(startDate && endDate){
                                result = endDate.getTime()>=startDate.getTime();
                            }else{
                                result = false;
                            }
                            return result;
						}
					</aui:validator>
				</aui:input>
			</div>
		</div>
		
		<div class="control-group">
			<aui:input label="label.taxPercent" helpMessage="help.taxPercent" showRequiredLabel="false" type="text" required="false" name="taxPercent" value="${subscriptionVO.taxPercent}">
				<aui:validator name="custom" errorMessage="error.decimalNumber">
					function (val, fieldNode, ruleValue) {
						var result = ( /^(\d+|\d+.\d{1,2})$/.test(val));
						return result;
					}
				</aui:validator>
			</aui:input>
		</div>
		
		<aui:button type="submit" name="save" value="label.save" />
	</div>
</fieldset>
</aui:form>
<script>
	trialEnd();
</script>
<aui:script>
var answerSubscription = "<%=answerSubscription%>";
AUI().use('aui-base','aui-io-request', function(A){
	if(answerSubscription != 'false'){
		Liferay.Util.getOpener().rechargeSubscriptions();
	}
});
</aui:script>