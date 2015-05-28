<%--
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
--%>
<%@ include file="init.jsp" %>
<% 
	boolean answerScheduledJob = false;
	if(session.getAttribute("answerScheduledJob") != null && String.valueOf(session.getAttribute("answerScheduledJob")).equalsIgnoreCase("true")){
		answerScheduledJob = true;
	}
	ScheduledJobVO scheduledJobVO = (ScheduledJobVO)session.getAttribute("scheduledJobVO");
%>

<aui:script>
AUI().use(
  'aui-toggler',
  function(A) {
    new A.Toggler(
      {
    	closeAllOnExpand: true,
    	container: '#myToggler',
        content: '.content',
        expanded: false,
        header: '.header'
      }
    );
  }
);
</aui:script>

<fmt:setBundle basename="Language"/>
<portlet:defineObjects />
<liferay-theme:defineObjects />

<liferay-ui:success key="CardCreatedSuccessfully" message="label.CardCreatedSuccessfully" />
<liferay-ui:error key="ProcessorMDTR.saveCard.CardDAOException" message="error.ProcessorMDTR.saveCard.CardDAOException" />

<portlet:actionURL name="addScheduledJob" var="submitFormAddScheduledJob"/>

<aui:form  action="<%= submitFormAddScheduledJob %>" method="post">
	<fieldset class="fieldset">
		<div class="">
			<p class="description"><fmt:message key="label.descriptionPorlet"/></p>
			
			<div class="control-group">
					<aui:input label="label.name" helpMessage="help.name" showRequiredLabel="false" required="true" name="name" value="${scheduledJobVO.name}"/>
			</div>
			<div class="control-group">
					<aui:input label="label.description" helpMessage="help.description" showRequiredLabel="false" required="true" name="description" value="${scheduledJobVO.description}"/>
			</div>
			<button class="btn-link header aui-toggler-header-collapsed"><fmt:message key="label.helpCronPattern"/></button>
			<div id="myToggler" class="aui-toggler-content-collapsed content">
				<div class="portlet-msg-alert">
					"Segundos" "Minutos" "Horas" "D�a del mes" "Mes" "D�a de la semana" "A�o" </br>
				    * : Selecciona todos los valores de un campo (por ejemplo cada hora, cada minuto)</br>
				    ? : Selecciona sin un valor espec�fico cuando se puede utilizar (es similar a decir cualquiera)</br>
				    - : Selecciona rango de valores (por ejemplo 4-6 que es de 4 a 6)</br>
				    , : Selecciona valores espec�ficos (por ejemplo MON,WED,FRI es decir los lunes, mi�rcoles y viernes )</br>
				    / : Selecciona incrementos a partir del primer valor (por ejemplo 0/15 que es cada 15 minutos comenzando desde el minuto 0 -> 15, 30 ,45)</br>
				    L (D�a del mes) : Selecciona el �ltimo d�a del mes</br>
				    L (D�a de la semana) : Selecciona el �ltimo d�a de la semana (7 / sabado / SAT)</br>
				    XL (D�a de la semana) : Seleccona el �ltimo d�a de ese tipo del mes (por ejemplo 6L -> el �ltimo viernes del mes)</br>
				    W : Selecciona el d�a de la semana (de lunes a viernes) m�s cercano al d�a (weekday)</br>
				    LW : Selecciona el �ltimo weekday del mes</br>
				</div>
			</div>
			<div class="control-group">
				<aui:input label="label.cronPattern" helpMessage="help.cronPattern" showRequiredLabel="false" type="text" required="true" name="cronPattern" value="${scheduledJobVO.cronPattern}"/>
			</div>
			
			<div class="control-group">
				<aui:select name="storageType" label="label.storageType" helpMessage="help.storageType">
					<%-- <aui:option label="MEMORY" value="MEMORY"/> 
					<aui:option label="MEMORY_CLUSTERED" value="MEMORY_CLUSTERED"/> --%> 
					<aui:option label="PERSISTED" value="PERSISTED"/> 
				</aui:select>
			</div>
			<div class="control-group">
				<aui:select name="listener" label="label.listener" helpMessage="help.listener">
					<aui:option label="<%=ProcessSubscriptions.class.getName()%>" value="<%= ProcessSubscriptions.class.getName()%>"/>
				</aui:select>
			</div>
			<aui:button type="submit" name="addScheduledJob" value="label.addScheduledJob" />
		</div>
	</fieldset>
</aui:form>

<aui:script>
var answerScheduledJob = "<%=answerScheduledJob%>";
AUI().use('aui-base','aui-io-request', function(A){
	if(answerScheduledJob != 'false'){
		Liferay.Util.getOpener().rechargeScheduledJobs();
	}
});
</aui:script>