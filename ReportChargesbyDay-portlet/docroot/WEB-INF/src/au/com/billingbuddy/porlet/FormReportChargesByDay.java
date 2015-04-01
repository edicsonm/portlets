package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;

import javax.portlet.PortletConfig;
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
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.exceptions.objects.ReporteChargesByDayException;
import au.com.billingbuddy.porlet.reports.ReporteChargesByDay;
import au.com.billingbuddy.porlet.utilities.GraphTemplate;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormReportChargesByDay extends MVCPortlet {
	
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			session.removeAttribute("transactionVOCharges");
			TransactionVO transactionVO = new TransactionVO();
			
			transactionVO.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
			transactionVO.setFinalDateReport(BBUtils.getCurrentDate(2,0));
			transactionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
			
			StreamSource xslStream = new StreamSource(renderRequest.getPortletSession().getPortletContext().getRealPath("/WEB-INF/src/graphTemplate/graphTemplate.xsl"));
			
			ArrayList<TransactionVO> listAmountsByDay = procesorFacade.searchChargesByDay(transactionVO);
			ReporteChargesByDay reporteChargesByDay = new ReporteChargesByDay(xslStream, GraphTemplate.getMap());
			StringWriter report = reporteChargesByDay.CreateXml(listAmountsByDay);
			
			transactionVO.setInitialDateReport(BBUtils.getCurrentDate(6,-1*(150)));
			transactionVO.setFinalDateReport(BBUtils.getCurrentDate(6,0));
			
			session.setAttribute("reportCharges", report.toString());
			session.setAttribute("transactionVOCharges", transactionVO);
		} catch (ProcesorFacadeException | ReporteChargesByDayException e) {
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
        try {
			session.removeAttribute("transactionVOCharges");
			session.removeAttribute("reportCharges");
			TransactionVO transactionVO = new TransactionVO();
			Date date;
			try {
				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("fromDateCharges"));
				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("toDateCharges"));
				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			StreamSource xslStream = new StreamSource(resourceRequest.getPortletSession().getPortletContext().getRealPath("/WEB-INF/src/graphTemplate/graphTemplate.xsl"));
			
			transactionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
			ArrayList<TransactionVO> listChargesByDay = procesorFacade.searchChargesByDay(transactionVO);
			ReporteChargesByDay reporteChargesByDay = new ReporteChargesByDay(xslStream, GraphTemplate.getMap());
			StringWriter report = reporteChargesByDay.CreateXml(listChargesByDay);
			resourceResponse.setContentType("text/html");
			PrintWriter writer = resourceResponse.getWriter();
			writer.print(report.toString());
	        writer.flush();
	        writer.close();
			session.setAttribute("transactionVOCharges", transactionVO);
        } catch (ProcesorFacadeException | ReporteChargesByDayException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)resourceRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(resourceRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(resourceRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
		}
        
        
		
	}
}

