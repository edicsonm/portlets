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

<liferay-ui:error key="ProcessorMDTR.updateBusinessType.BusinessTypeDAOException" message="error.ProcessorMDTR.updateBusinessType.BusinessTypeDAOException" />
<%
	ArrayList<BusinessTypeVO> resultsListCharge = (ArrayList<BusinessTypeVO>)session.getAttribute("results");
	BusinessTypeVO businessTypeVO = (BusinessTypeVO)resultsListCharge.get(Integer.parseInt(ParamUtil.getString(request, "indiceBusinessType")));
	session.setAttribute("indiceBusinessType", ParamUtil.getString(request, "indiceBusinessType"));
	request.setAttribute("businessTypeVO", businessTypeVO);
	session.setAttribute("businessTypeVO", businessTypeVO);
%>
<portlet:actionURL name="editBusinessType" var="editURLBusinessType">
	<portlet:param name="jspPage" value="/jsp/viewBusinessType.jsp" />
</portlet:actionURL>

<portlet:renderURL var="goBackBusinessType">
	<portlet:param name="jspPage" value="/jsp/viewBusinessType.jsp" />
</portlet:renderURL>

<aui:form  action="<%= editURLBusinessType %>" method="post">
	<div class="table">
		<div class="section">
			<div class="row">
				<div class="row">
					<div class="column1-1">
						<label class="aui-field-label sub-title"><fmt:message key="label.informationBusinessType"/></label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="column1-1">
					<aui:input label="label.description" helpMessage="help.description" showRequiredLabel="false" type="text" required="true" name="description" value="${businessTypeVO.description}">
					</aui:input>
				</div>
			</div>
			<div class="row">
				<div class="column1-2">
						<span class="goBack" >
							<a class="btn" href="<%= goBackBusinessType %>"><fmt:message key="label.goBack"/></a>
						</span>
					</div>
				<div class="column2-2">
					<aui:button type="submit" name="save" value="label.save" />
				</div>
			</div>
		</div>
	</div>
</aui:form>