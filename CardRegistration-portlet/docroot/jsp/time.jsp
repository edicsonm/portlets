<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="au.com.billingbuddy.vo.TimeVO"%>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<fmt:setBundle basename="Language"/>

<%
	ArrayList<TimeVO> listaHoras = (ArrayList<TimeVO>)session.getAttribute("listaHoras");
	if(listaHoras == null){
		listaHoras = new ArrayList<TimeVO>();
	}
	/* System.out.println(Calendar.getInstance().getTime());
	out.print(Calendar.getInstance().getTime()); */
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="renderURL" />

<liferay-ui:search-container emptyResultsMessage="La lista esta vacia " delta="50" iteratorURL="<%=renderURL%>">
	<liferay-ui:search-container-results results="<%=listaHoras %>" total="<%=listaHoras.size()%>">
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row className="au.com.billingbuddy.vo.TimeVO" rowVar="posi" indexVar="indice" keyProperty="time" modelVar="timeVO">
		
		<liferay-portlet:renderURL varImpl="rowURL">
				<portlet:param name="indice" value="<%=String.valueOf(indice)%>"/>
				<portlet:param name="jspPage" value="/jsp/viewCertificateGeneration.jsp" />
		</liferay-portlet:renderURL>
		
		<liferay-ui:search-container-column-text name="label.hora" property="time" orderable="true"/>
		
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>