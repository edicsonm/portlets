<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<portlet:defineObjects />

<%
    String tabs1 = ParamUtil.getString(request,"tabs","Business Information");
    PortletURL portletURL = renderResponse.createRenderURL();
    portletURL.setParameter("tabs", tabs1);
    System.out.println("tabs1: " + tabs1);
%>
<portlet:actionURL var="saveMerchant" name="saveMerchant">
</portlet:actionURL>

<portlet:actionURL var="keepInformation" name="keepInformation">
	<portlet:param name="action" value="saveBusinessInformation"/>
	<portlet:param name="jspPage" value="/jsp/newMerchant.jsp"/>
	<portlet:param name="tabs" value="<%=tabs1%>"/>
</portlet:actionURL>

<script>
	function submitTheForm(){
		$("#<portlet:namespace />myform").attr('action', '<%=keepInformation%>');
		$("#<portlet:namespace />myform").submit()
	}
	
	$(document).ready(function() {
		$("#<portlet:namespace />save").click(function(event) {
			$("#<portlet:namespace />myform").attr('action', '<%=saveMerchant%>');
		});
	});
</script>

<aui:form name="myform" id="myform" action="<%= keepInformation %>" method="post">
    <liferay-ui:tabs names="Business Information,Contact Information" refresh="<%=false %>" param="tabs" onClick="submitTheForm();" url=""/>            
        <c:choose>
        <c:when test='<%=tabs1.equalsIgnoreCase("Business Information")%>'>
            <%@include file="/jsp/tabs/business.jsp" %>
        </c:when>
        <c:when test='<%=tabs1.equalsIgnoreCase("Contact Information")%>'>
            <%@include file="/jsp/tabs/contact.jsp" %>
        </c:when>
    </c:choose>
</aui:form>