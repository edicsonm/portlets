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
<%@ page import="au.com.billingbuddy.vo.objects.TransactionVO" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.liferay.portal.theme.ThemeDisplay" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<style>
	circle {
		stroke: #ffffff;
		fill  : #008cdd;
	}

	path.pathGraphic {
		opacity: 1; 
		fill-opacity: 1;
		stroke:#4cabe2;
		stroke-width:0;
		stroke-opacity:1;
		fill-opacity:1;
	}
	
	path.pathReferences {
		stroke-opacity: 0.10;
		fill: none;
		stroke: #4cabe2;
		stroke-width:2;
	}
		
	text.labelPoint{
		text-anchor: end; 
		font: 8px Arial;
		fill: #008cdd;
	}

</style>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<% 
	TransactionVO transactionVOCharges = (TransactionVO)session.getAttribute("transactionVOCharges");
	Calendar cal = CalendarFactoryUtil.getCalendar(GregorianCalendar.getInstance().getTimeZone());	
	Calendar fromCalendar = Utilities.getCalendar(transactionVOCharges.getInitialDateReport(),2);
	Calendar toCalendar = Utilities.getCalendar(transactionVOCharges.getFinalDateReport(),2);
%>
<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />

<portlet:resourceURL var="createGraphicCharges"/>
<script>
	function createGraphicCharges() {
		/* alert("fromday: " + $("#<portlet:namespace />fromday").find('option:selected').attr('value'));
		alert("frommonth: " + $("#<portlet:namespace />frommonth").find('option:selected').attr('value'));
		alert("fromyear: " + $("#<portlet:namespace />fromyear").find('option:selected').attr('value')); */
		/* alert("createGraphic .."+ $("#<portlet:namespace />frommonth").find('option:selected').attr('value'));
		alert("createGraphic .."+ $("#_ReportAmountbyDay_WAR_ReportAmountbyDayportlet_frommonth").find('option:selected').attr('value'));
		alert("createGraphic .."+ $("#_ReportAmountbyDay_WAR_ReportAmountbyDayportlet_fromYear").find('option:selected').attr('value')); */
		var url = '<%=createGraphicCharges%>';
	    $.ajax({
	    type : "POST",
	    url : url,
	    cache:false,
	    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    dataType: "html",
	    data: {fromDay: $("#<portlet:namespace />fromday").find('option:selected').attr('value'), 
	    	   fromMonth: $("#<portlet:namespace />frommonth").find('option:selected').attr('value'), 
	    	   fromYear: $("#<portlet:namespace />fromyear").find('option:selected').attr('value'),
	    	   toDay: $("#<portlet:namespace />today").find('option:selected').attr('value'), 
	    	   toMonth: $("#<portlet:namespace />tomonth").find('option:selected').attr('value'), 
	    	   toYear: $("#<portlet:namespace />toyear").find('option:selected').attr('value')},
	    success : function(data){
	    	$("#reportCharges").html(data);	    	
	    },error : function(XMLHttpRequest, textStatus, errorThrown){
	          alert("XMLHttpRequest..." + XMLHttpRequest);
	          alert("textStatus..." + textStatus);
	          alert("errorThrown..." + errorThrown);
	    }
	  });
	};
</script>

<aui:form method="post">
	<div class="table">
		<div class="row">
			<div class="column1-3-Report">
				<span class="aui-field aui-field-select aui-field-menu"> 
					<span class="aui-field-content"> 
						<label for="from" class="aui-field-label"><fmt:message key="label.from"/>
							<span class="taglib-icon-help">
								<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
								<span id="helpFrom" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.from"/></span>
							</span>
						</label>
						<span class="aui-field-element "> 
							<liferay-ui:input-date formName="from" dayParam="fromDay" dayValue="<%= fromCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
						    	monthParam="fromMonth" monthValue="<%= fromCalendar.get(Calendar.MONTH) %>" yearParam="fromYear" yearValue="<%= fromCalendar.get(Calendar.YEAR) %>"
						    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
						</span>
					</span>
				</span>
			</div>
			<div class="column2-3-Report">
				<span class="aui-field aui-field-select aui-field-menu"> 
					<span class="aui-field-content"> 
						<label for="to" class="aui-field-label"><fmt:message key="label.to"/>
							<span class="taglib-icon-help">
								<img tabindex="0" src="${themeDisplay.pathThemeImages}/portlet/help.png" onmouseover="Liferay.Portal.ToolTip.show(this);" onfocus="Liferay.Portal.ToolTip.show(this);" onblur="Liferay.Portal.ToolTip.hide();" alt="">
								<span id="toAt" class="aui-helper-hidden-accessible tooltip-text"><fmt:message key="help.to"/></span>
							</span>
						</label>
						<span class="aui-field-element "> 
							<liferay-ui:input-date  formName="to" dayParam="toDay" dayValue="<%= toCalendar.get(Calendar.DATE) %>" disabled="<%=false%>" firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
						    	monthParam="toMonth" monthValue="<%= toCalendar.get(Calendar.MONTH) %>" yearParam="toYear" yearValue="<%= toCalendar.get(Calendar.YEAR) %>"
						    	yearRangeStart="<%= cal.get(Calendar.YEAR) - 15 %>" yearRangeEnd="<%= cal.get(Calendar.YEAR) %>" />
						</span>
					</span>
				</span>
			</div>
			<div class="column3-3-Report">
				<aui:button type="button" name="listRefunds" onClick="createGraphicCharges();" value="label.search" />
			</div>
		</div>
		<%-- <div class="row">
			<div class="column1-1">
				<aui:button type="submit" name="search" value="label.search" />
				<aui:button type="button" name="listRefunds" onClick="createGraphic();" value="label.search" />
			</div>
		</div> --%>
		<div class="row">
			<div id="reportCharges">
			<%out.print(session.getAttribute("reportCharges"));%>
			</div>
		</div>	
	</div>
</aui:form>