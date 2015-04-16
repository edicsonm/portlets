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
	ArrayList<MerchantVO> resultsListMerchants = (ArrayList<MerchantVO>)session.getAttribute("results");
	String indice = ParamUtil.getString(request, "indice",(String)session.getAttribute("indice"));
	MerchantVO merchantVO = (MerchantVO)resultsListMerchants.get(Integer.parseInt(indice));
	session.setAttribute("indice", indice);
	request.setAttribute("merchantVO", merchantVO);
	
	String tabs1 = ParamUtil.getString(request,"tabs","Business Information");
	PortletURL portletURL = renderResponse.createRenderURL();
    portletURL.setParameter("tabs", tabs1);
    portletURL.setParameter("jspPage", "/jsp/viewMerchant.jsp");
%>
<aui:form>
    <liferay-ui:tabs names="Business Information,Contact Information" param="tabs" onClick="submitTheForm();" url="<%=portletURL.toString()%>"/>            
        <c:choose>
        <c:when test='<%=tabs1.equalsIgnoreCase("Business Information")%>'>
            <%@include file="/jsp/tabs/viewBusiness.jsp" %>
        </c:when>
        <c:when test='<%=tabs1.equalsIgnoreCase("Contact Information")%>'>
            <%@include file="/jsp/tabs/viewContact.jsp" %>
        </c:when>
    </c:choose>
</aui:form>