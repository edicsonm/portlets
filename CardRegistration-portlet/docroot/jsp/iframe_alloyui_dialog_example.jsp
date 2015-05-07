<%@page import="javax.portlet.RenderRequest"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="javax.portlet.ActionRequest"%>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<portlet:defineObjects />
<liferay-theme:defineObjects />

<portlet:renderURL var="iFrmedilogRenderURL">
	<portlet:param name="message" value="Hi you have performed REDER REQUEST in iframe dialog.. thenk you.." />
	<portlet:param name="mvcPath" value="/jsp/iframe_alloyui_dialog_example.jsp" />
</portlet:renderURL>

<portlet:actionURL var="iFrmedilogActionURL">
	<portlet:param name="<%=ActionRequest.ACTION_NAME%>" value="getActionMessage" />
</portlet:actionURL>

<h1><%=ParamUtil.getString(renderRequest, "message")%></h1>
<div>
	<aui:a href="<%=iFrmedilogActionURL%>">Send Action Request</aui:a>
</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>
	<aui:a href="<%=iFrmedilogRenderURL%>">Send Render Request</aui:a>
</div>

