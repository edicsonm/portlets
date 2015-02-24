package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.PortletMode;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.WindowState;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.ReportFacade;
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ReportFacadeException;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormReportTransactionsByDay extends MVCPortlet {
	
	private ReportFacade reportFacade = ReportFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		System.out.println("Ejecuta doView en FormReportTransactionsByDay ");
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			
			TransactionVO transactionVO = new TransactionVO();
			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(transactionVO);
			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
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
	
	public void searchTransactionsByDay(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException{
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		TransactionVO transactionVO = new TransactionVO();
		try {
			Date date;
			try {
				date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("fromDateTransactions"));
				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
				date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("toDateTransactions"));
				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
				
				System.out.println("transactionVO.getInitialDateReport(): " + transactionVO.getInitialDateReport());
				System.out.println("transactionVO.getFinalDateReport(): " + transactionVO.getFinalDateReport());
				
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(transactionVO);
			System.out.println("listTransactionsByDay.size(): " + listTransactionsByDay.size());
			session.setAttribute("transactionVO", transactionVO);
			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
		} catch (ReportFacadeException e) {
			e.printStackTrace();
			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest, "error");
			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
			SessionErrors.add(actionRequest,transactionVO.getMessage());
			session.setAttribute("chargeVO", transactionVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}

	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpSession session = request.getSession();
		TransactionVO transactionVO = new TransactionVO();
		System.out.println("Ejecuta searchTransactionsByDay en FormReportTransactionsByDay");
		try {
			Date date;
			try {
				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("fromDateTransactions"));
				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("toDateTransactions"));
				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
				
				System.out.println("transactionVO.getInitialDateReport(): " + transactionVO.getInitialDateReport());
				System.out.println("transactionVO.getFinalDateReport(): " + transactionVO.getFinalDateReport());
				
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(transactionVO);
			System.out.println("listTransactionsByDay.size(): " + listTransactionsByDay.size());
			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
		} catch (ReportFacadeException e) {
			e.printStackTrace();
			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
			PortletConfig portletConfig = (PortletConfig)resourceRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(resourceRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(resourceRequest, "error");
			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
			SessionErrors.add(resourceRequest,transactionVO.getMessage());
			session.setAttribute("chargeVO", transactionVO);
		}
		resourceResponse.setContentType("text/html");
		PrintWriter writer = resourceResponse.getWriter();
		writer.print("procesado....");
        writer.flush();
        writer.close();
	}
	
	
//	
//	@Override
//	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
//		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
//		HttpSession session = request.getSession();
//        try {
//			session.removeAttribute("transactionVOTransactions");
//			
//			TransactionVO transactionVO = new TransactionVO();
//			Date date;
//			try {
//				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("fromDateTransactions"));
//				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
//				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("toDateTransactions"));
//				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
//			} catch (NumberFormatException e) {
//				e.printStackTrace();
//			} catch (ParseException e) {
//				e.printStackTrace();
//			}
//			
//			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(new TransactionVO());
//			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
//			session.setAttribute("transactionVOTransactions", transactionVO);
//		} catch (ReportFacadeException e) {
//			e.printStackTrace();
////			PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
////			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
////			SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
////			SessionErrors.add(renderRequest,e.getErrorCode());
//			System.out.println("e.getMessage(): " + e.getMessage());
//			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
//			System.out.println("e.getErrorCode(): " + e.getErrorCode());
//		}
//		
//	}
	
}

