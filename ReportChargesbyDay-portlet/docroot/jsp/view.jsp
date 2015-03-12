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
		var url = '<%=createGraphicCharges%>';
	    $.ajax({
	    type : "POST",
	    url : url,
	    cache:false,
	    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    dataType: "html",
	    data: {fromDateCharges: $("#<portlet:namespace />fromDateCharges").val(),
	    	toDateCharges: $("#<portlet:namespace />toDateCharges").val()},
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
<aui:script>
    
    AUI().use('aui-datepicker', function(A) {
       var fromDate = new A.DatePicker({
         trigger: '#<portlet:namespace />fromDateCharges',
       }).render('##<portlet:namespace />fromDateChargesPicker');
    });
    
    AUI().use('aui-datepicker', function(A) {
        var toDate = new A.DatePicker({
          trigger: '#<portlet:namespace />toDateCharges',
        }).render('##<portlet:namespace />toDateChargesPicker');
     });

</aui:script>
<aui:form method="post">
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="column1-3-Report">
					<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />fromDateChargesPicker">
						<aui:input onkeypress="return false;" label="label.from" helpMessage="help.from" showRequiredLabel="false" size="10" type="text" required="true" name="fromDateCharges">
							 <aui:validator name="date" />
						</aui:input>
					</div>
				</div>
				<div class="column2-3-Report">
					<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace  />toDateChargesPicker">
						<aui:input onkeypress="return false;" label="label.to" helpMessage="help.to" showRequiredLabel="false" size="10" type="text" required="true" name="toDateCharges">
							 <aui:validator name="date" />
						</aui:input>
					</div>
				</div>
				<div class="column3-3-Report">
					<aui:button type="button" name="listRefunds" onClick="createGraphicCharges();" value="label.search" />
				</div>
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