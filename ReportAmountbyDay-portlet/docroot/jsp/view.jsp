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
<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>
<% 
	TransactionVO transactionVOAmount = (TransactionVO)session.getAttribute("transactionVOAmount");
%>
<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />

<portlet:resourceURL var="createGraphicAmount"/>
<portlet:resourceURL var="prueba"/>
<script>
	function createGraphicAmount() {
		/* alert("fromday: " + $("#<portlet:namespace />fromday").find('option:selected').attr('value'));
		alert("frommonth: " + $("#<portlet:namespace />frommonth").find('option:selected').attr('value'));
		alert("fromyear: " + $("#<portlet:namespace />fromyear").find('option:selected').attr('value')); */
		/* alert("createGraphic .."+ $("#<portlet:namespace />frommonth").find('option:selected').attr('value'));
		alert("createGraphic .."+ $("#_ReportAmountbyDay_WAR_ReportAmountbyDayportlet_frommonth").find('option:selected').attr('value'));
		alert("createGraphic .."+ $("#_ReportAmountbyDay_WAR_ReportAmountbyDayportlet_fromYear").find('option:selected').attr('value')); */
		var url = '<%=createGraphicAmount%>';
	    $.ajax({
	    type : "POST",
	    url : url,
	    cache:false,
	    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    dataType: "html",
	    data: {<portlet:namespace/>fromDateAmount: $("#<portlet:namespace />fromDateAmount").val(),
	    	<portlet:namespace/>toDateAmount: $("#<portlet:namespace />toDateAmount").val()},
	    success : function(data){
	    	$("#reportAmount").html(data);	    	
	    },error : function(XMLHttpRequest, textStatus, errorThrown){
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
	        trigger: '#<portlet:namespace />fromDateAmount',
	        popover: {
	          zIndex: 1
	        }
	      });
	  }
	);
  
  YUI().use(
		  'aui-datepicker',
		  function(Y) {
		    new Y.DatePicker(
		      {
		        trigger: '#<portlet:namespace />toDateAmount',
		        popover: {
		          zIndex: 1
		        }/* ,
		        on: {
		          selectionChange: function(event) {
		            console.log(event.newSelection);
		            alert(event.newSelection);
		          }
		        } */
		      });
		  }
		);

</aui:script>
<aui:form method="post">
	<fieldset class="fieldset">
		<legend class="fieldset-legend">
			<span class="legend"><fmt:message key="label.reportDescription"/> </span>
		</legend>
		<div class="">
			
			<div id="contenedor">
				<div id="contenidos">
					<div id="columna1">
						<div class="control-group">
							<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace />fromDateAmountPicker">
								<aui:input onkeypress="return false;" value="<%= transactionVOAmount.getInitialDateReport()%>" label="label.from" helpMessage="help.from" showRequiredLabel="false" size="10" type="text" required="false" name="fromDateAmount">
									<aui:validator name="date" />
								</aui:input>
							</div>
						</div>
					</div>
					<div id="columna2">
						<div class="control-group">
							<div class="aui-datepicker aui-helper-clearfix" id="#<portlet:namespace  />toDateAmountPicker">
								<aui:input onkeypress="return false;" value="<%= transactionVOAmount.getFinalDateReport()%>" label="label.to" helpMessage="help.to" showRequiredLabel="false" size="10" type="text" required="false" name="toDateAmount">
									 <aui:validator name="date" />
								</aui:input>
							</div>
						</div>
					</div>
					<div id="columna3">
						<div class="control-group">
							<aui:button type="button" name="listRefunds" onClick="createGraphicAmount();" value="label.search" />
						</div>
					</div>
				</div>
			</div>
			
			<div id="reportAmount">
				<%out.print(session.getAttribute("reportAmount"));%>
			</div>
		</div>
	</fieldset>
</aui:form>


