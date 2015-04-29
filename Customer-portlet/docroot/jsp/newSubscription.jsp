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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.liferay.portal.theme.ThemeDisplay" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<liferay-ui:error key="ProcessorMDTR.saveSubscription.SubscriptionDAOException" message="error.ProcessorMDTR.saveSubscription.SubscriptionDAOException" />
<% 
	Calendar calendar = GregorianCalendar.getInstance();
	Calendar cal = CalendarFactoryUtil.getCalendar(calendar.getTimeZone());
	
	SubscriptionVO subscriptionVO = (SubscriptionVO)session.getAttribute("subscriptionVO");
	ArrayList<PlanVO> listPlans = (ArrayList<PlanVO>)session.getAttribute("listPlans");
%>

<portlet:resourceURL var="viewContentURL">
	<portlet:param name="action" value="trialStartDate"/>
</portlet:resourceURL>

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
            $("#<portlet:namespace />startAt").val(data.start)
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

	function GetContent() {
	    var url='<%=viewContentURL %>';
	    AUI().io.request(
	        url,
	        {
	            method: 'POST',
	            data: {
	                    <portlet:namespace/>planId: $("#<portlet:namespace />plan").find('option:selected').attr('value'),
	                    <portlet:namespace/>trialEndDay: $("#<portlet:namespace />trialEndDay").val()
	                  },
	            on: {
	                failure: function() {
	                            alert('failure');
	                         },
	                success: function(event, id, obj) {
	                            var instance = this;
	                            var message = instance.get('responseData');
	                            alert("message: " + message);
	                            $("#<portlet:namespace />trialEndDay").val(message)
	                         }
	            }
	        }
	    );
	}
  
  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker({
	        trigger: '#<portlet:namespace />startAt' ,
	        popover: {
	          zIndex: 1
	        } 
	      })
	  }
	);


  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />endedAt',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	); 

  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />canceledAt',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	); 

  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />currentPeriodStart',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	); 
  
  YUI().use('aui-datepicker', function(Y) {
	    new Y.DatePicker(
	    	{
	        trigger: '#<portlet:namespace />currentPeriodEnd',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
  
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

<portlet:actionURL name="saveSubscription" var="submitFormSubscription">
	<%-- <portlet:param name="jspPage" value="/jsp/view.jsp" /> --%>
</portlet:actionURL>

<portlet:renderURL var="goBackSubscription">
	<portlet:param name="jspPage" value="/jsp/customer.jsp" />
</portlet:renderURL>

<aui:form  action="<%= submitFormSubscription %>" method="post">
<fieldset class="fieldset">
	<%-- <legend class="fieldset-legend">
		<span class="legend"><fmt:message key="label.informationSubscription"/></span>
	</legend> --%>
	<div class="">
		<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
		
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
				<aui:input onkeypress="return false;" value="${Utils:formatDateDefaultValue(3,subscriptionVO.trialStart,6,0)}" label="label.trialStart" helpMessage="help.trialStart" showRequiredLabel="false" size="10" type="text" required="true" name="trialStartDay">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />trialEndPicker">
				<%-- <div id="<portlet:namespace/>contentview"></div> --%>
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.trialEnd,6)}"  label="label.trialEnd" helpMessage="help.trialEnd" showRequiredLabel="false" size="10" type="text" required="true" name="trialEndDay">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		<!-- planVO.setTrialPeriodDays -->
		
		<%-- <div class="control-group">
			<aui:select label="label.cancelAtPeriodEnd" name="cancelAtPeriodEnd" helpMessage="help.cancelAtPeriodEnd" id="cancelAtPeriodEnd">
				<aui:option value="0" label="True" selected="${subscriptionVO.cancelAtPeriodEnd=='0'}"/>
				<aui:option value="1" label="False" selected="${subscriptionVO.cancelAtPeriodEnd=='1'}"/>
			</aui:select>
		</div> --%>
		
		<%-- <div class="control-group">
			<aui:select label="label.status" name="status" helpMessage="help.status" id="status">
					<aui:option value="Trialing" label="Trialing" selected="${subscriptionVO.status=='Trialing'}"/>
					<aui:option value="Active" label="Active" selected="${subscriptionVO.status=='Active'}"/>
					<aui:option value="Past_due" label="Past_due" selected="${subscriptionVO.status=='Past_due'}"/>
					<aui:option value="Canceled" label="Canceled" selected="${subscriptionVO.status=='Canceled'}"/>
					<aui:option value="Unpaid" label="Unpaid" selected="${subscriptionVO.status=='Unpaid'}"/>
			</aui:select>
		</div> --%>
		
		<%-- <div class="control-group">
			<aui:input label="label.applicationFeePercent" helpMessage="help.applicationFeePercent" showRequiredLabel="false" type="text" required="true" name="applicationFeePercent" value="${subscriptionVO.applicationFeePercent}">
				<aui:validator name="custom" errorMessage="error.decimalNumber">
					function (val, fieldNode, ruleValue) {
						var result = ( /^(\d+|\d+.\d{1,2})$/.test(val));
						return result;
					}
				</aui:validator>
			</aui:input>
		</div> --%>
		
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />startPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDateDefaultValue(3,subscriptionVO.start,6,0)}"  label="label.start" helpMessage="help.start" showRequiredLabel="false" size="10" type="text" required="true" name="startAt">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		<%-- <div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />endedAtPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.endedAt,6)}"  label="label.endedAt" helpMessage="help.endedAt" showRequiredLabel="false" size="10" type="text" required="true" name="endedAt">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />canceledAtPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.canceledAt,6)}" label="label.canceledAt" helpMessage="help.canceledAt" showRequiredLabel="false" size="10" type="text" required="true" name="canceledAt">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div> --%>
	<%-- 	<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />currentPeriodStartPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.currentPeriodStart,6)}" label="label.currentPeriodStart" helpMessage="help.currentPeriodStart" showRequiredLabel="false" size="10" type="text" required="true" name="currentPeriodStart">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div>
		<div class="control-group">
			<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />currentPeriodEndPicker">
				<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.currentPeriodEnd,6)}" label="label.currentPeriodEnd" helpMessage="help.currentPeriodEnd" showRequiredLabel="false" size="10" type="text" required="true" name="currentPeriodEnd">
					 <aui:validator name="date" />
				</aui:input>
			</div>
		</div> --%>
		
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
		<a href="<%= goBackSubscription %>"><fmt:message key="label.goBack"/></a>
		<aui:button type="submit" name="save" value="label.save" />
	</div>
</fieldset>
</aui:form>
<script>
	trialEnd();
</script>