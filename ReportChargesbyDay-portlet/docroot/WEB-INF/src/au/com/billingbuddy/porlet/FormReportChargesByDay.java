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

import org.json.simple.JSONObject;

import au.com.billingbuddy.business.objects.ReportFacade;
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ReportFacadeException;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormReportChargesByDay extends MVCPortlet {
	
	private ReportFacade reportFacade = ReportFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			session.removeAttribute("transactionVOCharges");
			TransactionVO transactionVO = new TransactionVO();
			StringWriter report = reportFacade.searchChargesByDay(transactionVO);
			
			System.out.println("transactionVO.getInitialDateReport(): "+ transactionVO.getInitialDateReport());
			System.out.println("transactionVO.getFinalDateReport(): " + transactionVO.getFinalDateReport());
			
			session.setAttribute("reportCharges", report.toString());
			session.setAttribute("transactionVOCharges", transactionVO);
		} catch (ReportFacadeException e) {
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
				date = Utilities.getDateFormat(5).parse(resourceRequest.getParameter("fromDay") + "-"+(Integer.parseInt(resourceRequest.getParameter("fromMonth")) + 1)+"-"+resourceRequest.getParameter("fromYear"));
				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
				date = Utilities.getDateFormat(5).parse(resourceRequest.getParameter("toDay") + "-"+(Integer.parseInt(resourceRequest.getParameter("toMonth")) + 1)+"-"+resourceRequest.getParameter("toYear"));
				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			StringWriter report = reportFacade.searchChargesByDay(transactionVO);
			resourceResponse.setContentType("text/html");
			PrintWriter writer = resourceResponse.getWriter();
			writer.print(report.toString());
	        writer.flush();
	        writer.close();
			session.setAttribute("transactionVOCharges", transactionVO);
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

