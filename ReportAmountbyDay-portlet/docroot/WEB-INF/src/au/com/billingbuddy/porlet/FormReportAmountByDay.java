package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.portlet.PortletConfig;
import javax.portlet.PortletContext;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.transform.stream.StreamSource;

import au.com.billigbuddy.utils.BBUtils;
import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.business.objects.ReportFacade;
import au.com.billingbuddy.common.objects.ConfigurationSystem;
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.exceptions.objects.ReportFacadeException;
import au.com.billingbuddy.exceptions.objects.ReporteAmountByDayException;
import au.com.billingbuddy.porlet.reports.ReporteAmountByDay;
import au.com.billingbuddy.porlet.utilities.GraphTemplate;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormReportAmountByDay extends MVCPortlet {
	
	private ReportFacade reportFacade = ReportFacade.getInstance();
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		
		try {
			session.removeAttribute("transactionVOAmount");
			TransactionVO transactionVO = new TransactionVO();
//			transactionVO.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(Integer.parseInt(ConfigurationSystem.getKey("days.PROC_SEARCH_AMOUNT_BY_DAY")))));
			transactionVO.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
			transactionVO.setFinalDateReport(BBUtils.getCurrentDate(2,0));
			
//			for (Map.Entry entry : GraphTemplate.getMap().entrySet()) {
//			    System.out.println(entry.getKey() + ", " + entry.getValue());
//			}
			
			StreamSource xslStream = new StreamSource("/mnt/Informacion/NuevoBB/Liferay/tomcat-7.0.42/webapps/ReportAmountbyDay-portlet/WEB-INF/src/graphTemplate/graphTemplate.xsl");
//			StreamSource xslStream = new StreamSource(renderRequest.getContextPath() + "/WEB-INF/src/graphTemplate/graphTemplate.xsl");
			
//			StringWriter report = reportFacade.searchAmountByDay(transactionVO, xslStream, GraphTemplate.getMap());
			
			ArrayList<TransactionVO> listAmountsByDay = procesorFacade.searchAmountByDay(transactionVO);
			
			System.out.println("listAmountsByDay.size(); " + listAmountsByDay.size());
			
			ReporteAmountByDay reporteAmountByDay = new ReporteAmountByDay(xslStream, GraphTemplate.getMap());
			StringWriter report = reporteAmountByDay.CreateXml(listAmountsByDay);
			
			transactionVO.setInitialDateReport(BBUtils.getCurrentDate(6,-1*(150)));
			transactionVO.setFinalDateReport(BBUtils.getCurrentDate(6,0));
			
			session.setAttribute("reportAmount", report.toString());
			session.setAttribute("transactionVOAmount", transactionVO);
		} catch (ProcesorFacadeException | ReporteAmountByDayException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(renderRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
		}
		super.doView(renderRequest, renderResponse);
	}
	
	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpSession session = request.getSession();
        
		/*Este codigo tambien funciona
		HttpServletRequest httpReq = PortalUtil.getHttpServletRequest(resourceRequest);
		System.out.println("uno 1: " + PortalUtil.getOriginalServletRequest(httpReq).getParameter("uno"));*/
		
		try {
			session.removeAttribute("transactionVOAmount");
			session.removeAttribute("reportAmount");
			TransactionVO transactionVO = new TransactionVO();
			Date date;
			try {
				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("fromDateAmount"));
				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("toDateAmount"));
				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			
			StreamSource xslStream = new StreamSource("/mnt/Informacion/NuevoBB/Liferay/tomcat-7.0.42/webapps/ReportAmountbyDay-portlet/WEB-INF/src/graphTemplate/graphTemplate.xsl");
//			StreamSource xslStream = new StreamSource(resourceRequest.getContextPath() + "/WEB-INF/src/graphTemplate/graphTemplate.xsl");
//			StreamSource xslStream = new StreamSource("graphTemplate/graphTemplate.xsl");
			StringWriter report = reportFacade.searchAmountByDay(transactionVO, xslStream, GraphTemplate.getMap());
			
			resourceResponse.setContentType("text/html");
			PrintWriter writer = resourceResponse.getWriter();
			writer.print(report.toString());
	        writer.flush();
	        writer.close();
			session.setAttribute("transactionVOAmount", transactionVO);
		} catch (ReportFacadeException e) {
			e.printStackTrace();
//			PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//			SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//			SessionErrors.add(renderRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
		}
        
        
		
	}
}

