<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ page import="com.liferay.portal.service.RoleServiceUtil" %>
<%@ page import="com.liferay.portal.service.UserLocalServiceUtil" %>
<%@ page import="com.liferay.portal.service.UserGroupRoleLocalServiceUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.liferay.portal.model.UserGroupRole" %>
<%@ page import="com.liferay.portal.model.Role" %>
<%@ page import="java.util.Iterator" %>

<portlet:defineObjects />

<liferay-theme:defineObjects />

<%
long groupId = scopeGroupId;
String name = portletDisplay.getRootPortletId();
String primKey = portletDisplay.getResourcePK();
String actionId = "ADD_SOMETHING";

System.out.println("groupId: " + groupId);
System.out.println("name: " + name);
System.out.println("primKey: " + primKey);
System.out.println("actionId: " + actionId);

/* 
if (permissionChecker.hasPermission(scopeGroupId, name,scopeGroupId, "ADD_SOMETHING")) {
	System.out.println("Entra a 1: ");
}else{
	System.out.println("Entra a 2: ");
} */

/* System.out.println("Resultado 1: " + UserLocalServiceUtil.hasRoleUser(themeDisplay.getCompanyId(), "administrator",themeDisplay.getUserId(), false));
System.out.println("Resultado 2: " + RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), "administrator", true));
 */

System.out.println("Resultado 3: " + UserLocalServiceUtil.hasRoleUser(themeDisplay.getCompanyId(), "MerchantVisitor",themeDisplay.getUserId(), false));
System.out.println("Resultado 3: " + UserLocalServiceUtil.hasRoleUser(themeDisplay.getCompanyId(), "MerchantAdministrator",themeDisplay.getUserId(), false));
/* System.out.println("Resultado 4: " + RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), "MerchantAdministrator", true)); */


List<UserGroupRole> lista = UserGroupRoleLocalServiceUtil.getUserGroupRoles(themeDisplay.getUserId());
for (Iterator iterator = lista.iterator(); iterator.hasNext();) {
	UserGroupRole userGroupRole = (UserGroupRole) iterator.next();
	System.out.println("Role1: " + userGroupRole.getRole().getName());
}
List l = RoleServiceUtil.getUserRoles(themeDisplay.getUserId());
for (Iterator iterator = l.iterator(); iterator.hasNext();) {
	Role role = (Role) iterator.next();
	System.out.println("Role2: " + role.getName());
}

List<Role> roles = (List<Role>) RoleServiceUtil.getUserRoles(user.getUserId());
for (Role role : roles) {
	out.println(role.getName() +"###"+ role.getRoleId() );
}

%>
<%-- 
<c:if test="<%= RoleServiceUtil.hasUserRole(user.getUserId(), user.getCompanyId(), \"administrator\", true) %>">
</c:if>

Do you have the <i><liferay-ui:message key='<%= "action." + actionId %>' /></i> permission for this portlet?

<strong>

<c:choose>
	<c:when test="<%= permissionChecker.hasPermission(groupId, name, primKey, actionId) %>">
		Yes
	</c:when>
	<c:otherwise>
		No
	</c:otherwise>
</c:choose>

</strong>

<br /><br />

<%
name = "com.sample.permissions.model.Something";
primKey = "1";
actionId = "VIEW";

System.out.println("groupId: " + groupId);
System.out.println("name: " + name);
System.out.println("primKey: " + primKey);
System.out.println("actionId: " + actionId);

%>

Do you have the <i><liferay-ui:message key='<%= "action." + actionId %>' /></i> permission for the model <i><liferay-ui:message key='<%= "model.resource." + name %>' /></i> with the primary key <i><%= primKey %></i>?

<strong>

<c:choose>
	<c:when test="<%= permissionChecker.hasPermission(groupId, name, primKey, actionId) %>">
		Yes
	</c:when>
	<c:otherwise>
		No
	</c:otherwise>
</c:choose>

</strong>

<br /><br />

<portlet:renderURL var="redirectURL" />

<liferay-security:permissionsURL
	modelResource="<%= name %>"
	modelResourceDescription='<%= "Hello World" %>'
	redirect="<%= redirectURL %>"
	resourcePrimKey="<%= primKey %>"
	var="permissionsURL"
/>

Click <a href="<%= permissionsURL %>">here</a> to edit the permissions for the <i><liferay-ui:message key='<%= "model.resource." + name %>' /></i> model. --%>