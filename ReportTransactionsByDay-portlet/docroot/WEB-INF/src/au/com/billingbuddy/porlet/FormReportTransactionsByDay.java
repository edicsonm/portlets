package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.PortletMode;
import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.WindowState;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import au.com.billigbuddy.utils.BBUtils;
import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.business.objects.ReportFacade;
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.exceptions.objects.ReportFacadeException;
import au.com.billingbuddy.porlet.utilities.Methods;
import au.com.billingbuddy.vo.objects.CardVO;
import au.com.billingbuddy.vo.objects.ChargeVO;
import au.com.billingbuddy.vo.objects.CountryVO;
import au.com.billingbuddy.vo.objects.CurrencyVO;
import au.com.billingbuddy.vo.objects.MerchantVO;
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
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		
		System.err.println("XXXXXXXXXXXXXXXXXXXXXXX renderRequest XXXXXXXXXXXXXXXXXXXXXXX " + request.getParameter("accion"));
		if(request.getParameter("accion") == null) {
			try {
				
				TransactionVO transactionVO = new TransactionVO();
	//			transactionVO.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(Integer.parseInt(ConfigurationSystem.getKey("days.PROC_SEARCH_AMOUNT_BY_DAY")))));
				transactionVO.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
				transactionVO.setFinalDateReport(BBUtils.getCurrentDate(2,0));
				transactionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
				
				ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(transactionVO);
				session.setAttribute("listTransactionsByDay", listTransactionsByDay);
				
				ArrayList<CountryVO> listCountries = procesorFacade.listCountries();
				session.setAttribute("listCountries", listCountries);
				
				ArrayList<CurrencyVO> listCurrencies = procesorFacade.listCurrencies();
				session.setAttribute("listCurrencies", listCurrencies);
				
				ArrayList<MerchantVO> listMerchants = procesorFacade.listAllMerchants(new MerchantVO(String.valueOf(PortalUtil.getUserId(request))));
				session.setAttribute("listMerchants", listMerchants);
				
				transactionVO.setInitialDateReport(BBUtils.getCurrentDate(6,-1*(150)));
				transactionVO.setFinalDateReport(BBUtils.getCurrentDate(6,0));
				session.setAttribute("transactionVOTransactions", transactionVO);
			} catch (ReportFacadeException | ProcesorFacadeException e) {
				e.printStackTrace();
				PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(renderRequest,e.getErrorCode());
				System.out.println("e.getMessage(): " + e.getMessage());
				System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
				System.out.println("e.getErrorCode(): " + e.getErrorCode());
			}
		} else  if(request.getParameter("accion") != null && request.getParameter("accion").equalsIgnoreCase("renderURLTransactionsByDay")) {
//			Methods.printParameters(renderRequest);
//			if(request.getParameter("lastCur") != null &&  (request.getParameter("lastCur") != request.getParameter("cur"))) {
//				System.out.println("Paginando ... ");
//			} else {
				ArrayList<TransactionVO> listTransactionsByDay = (ArrayList<TransactionVO>)session.getAttribute("listTransactionsByDay");
				if(listTransactionsByDay == null) listTransactionsByDay = new ArrayList<TransactionVO>();
				listTransactionsByDay = Methods.orderReportTransactionsByDay(listTransactionsByDay,request.getParameter("orderByCol"),request.getParameter("orderByType"));
				session.setAttribute("listTransactionsByDay", listTransactionsByDay);
				System.out.println("Ordenando ... ");
//			}
		}
//		include("/hola.jsp", renderRequest, renderResponse, PortletRequest.RESOURCE_PHASE);
		super.doView(renderRequest, renderResponse);
	}
	
	public void listarTransacciones(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException{
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
//		Methods.printParameters(actionRequest);
		
		TransactionVO transactionVO = new TransactionVO();	
		System.out.println("displayTerms.isAdvancedSearch()? ... " + actionRequest.getParameter("advancedSearch"));	
		
		if (actionRequest.getParameter("advancedSearch").equalsIgnoreCase("true")) {//Entra aca si selecciona la busqueda avanzada
			System.out.println("Entra por el if ... ");
			
			if(actionRequest.getParameter("andOperator").equalsIgnoreCase("1")){//Selecciono ALL
				System.out.println("Selecciono *ALL");
				
				/* currency
				merchant
				countryCard */
				transactionVO.setCardVO(new CardVO());
				transactionVO.getCardVO().setNumber(BBUtils.nullStringToNULL(actionRequest.getParameter("cardNumber")));
				transactionVO.setMerchantId(BBUtils.nullStringToNULL(actionRequest.getParameter("merchant")));
				transactionVO.getCardVO().setBrand(BBUtils.nullStringToNULL(actionRequest.getParameter("brand")));
				transactionVO.getCardVO().setCountry(BBUtils.nullStringToNULL(actionRequest.getParameter("countryCard")));
				transactionVO.setChargeVO(new ChargeVO());
				transactionVO.getChargeVO().setCurrency(BBUtils.nullStringToNULL(actionRequest.getParameter("currency")));
				transactionVO.setMatch("0");
				
//				if(fromDateTransactions.isEmpty() || toDateTransactions.isEmpty()){
//					transactionVOAUX.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
//					transactionVOAUX.setFinalDateReport(BBUtils.getCurrentDate(2,0));
//				}else{
					Date date;
					try {
						date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("fromDateTransactions"));
						transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
						date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("toDateTransactions"));
						transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
					} catch (NumberFormatException | ParseException e) {
						e.printStackTrace();
					}
//				}
					transactionVO.setUserId(String.valueOf(String.valueOf(PortalUtil.getUserId(request))));
				
			}else{
				
				System.out.println("Selecciono *ANY");
				transactionVO.setCardVO(new CardVO());
				transactionVO.getCardVO().setNumber(BBUtils.nullStringToNULL(actionRequest.getParameter("cardNumber")));
				transactionVO.setMerchantId(BBUtils.nullStringToNULL(actionRequest.getParameter("merchant")));
				transactionVO.getCardVO().setBrand(BBUtils.nullStringToNULL(actionRequest.getParameter("brand")));
				transactionVO.getCardVO().setCountry(BBUtils.nullStringToNULL(actionRequest.getParameter("countryCard")));
				transactionVO.setChargeVO(new ChargeVO());
				transactionVO.getChargeVO().setCurrency(BBUtils.nullStringToNULL(actionRequest.getParameter("currency")));
				transactionVO.setMatch("1");
				
//				if(fromDateTransactions.isEmpty() || toDateTransactions.isEmpty()){
//					transactionVOAUX.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
//					transactionVOAUX.setFinalDateReport(BBUtils.getCurrentDate(2,0));
//				}else{
					Date date;
					try {
						date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("fromDateTransactions"));
						transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
						date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("toDateTransactions"));
						transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
					} catch (NumberFormatException | ParseException e) {
						e.printStackTrace();
					}
//				}
					transactionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
				
			}
		
			actionResponse.setRenderParameter("cardNumber", actionRequest.getParameter("cardNumber"));
			actionResponse.setRenderParameter("brand", actionRequest.getParameter("brand"));
			actionResponse.setRenderParameter("merchant", actionRequest.getParameter("merchant"));
			actionResponse.setRenderParameter("countryCard", actionRequest.getParameter("countryCard"));
			actionResponse.setRenderParameter("currency", actionRequest.getParameter("currency"));
		
//			session.setAttribute("cardNumber", actionRequest.getParameter("cardNumber"));
//			session.setAttribute("brand", actionRequest.getParameter("brand"));
//			session.setAttribute("merchant", actionRequest.getParameter("merchant"));
//			session.setAttribute("countryCard", actionRequest.getParameter("countryCard"));
//			session.setAttribute("currency", actionRequest.getParameter("currency"));
			
		} else {
			System.out.println("Entra por el else ... " + actionRequest.getParameter("keywords"));
			transactionVO.setCardVO(new CardVO());
			transactionVO.getCardVO().setNumber(actionRequest.getParameter("keywords"));
			transactionVO.setChargeVO(new ChargeVO());
			transactionVO.getChargeVO().setCurrency(null);
			transactionVO.setMatch("1");
//			if(fromDateTransactions.isEmpty() || toDateTransactions.isEmpty()){
//				transactionVOAUX.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
//				transactionVOAUX.setFinalDateReport(BBUtils.getCurrentDate(2,0));
//			}else{
				Date date;
				try {
					date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("fromDateTransactions"));
					transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
					date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("toDateTransactions"));
					transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
				} catch (NumberFormatException | ParseException e) {
					e.printStackTrace();
				}
//			}
			
			System.out.println("fromDateTransactions ... " + transactionVO.getInitialDateReport());
			System.out.println("toDateTransactions ... " + transactionVO.getFinalDateReport());
			transactionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
			actionResponse.setRenderParameter("keywords", actionRequest.getParameter("keywords"));
		}
		
		try {
			
			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDayFilter(transactionVO);
			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
			
		} catch (ReportFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest, "error");
			SessionErrors.add(actionRequest,transactionVO.getMessage());
			session.setAttribute("transactionVO", transactionVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
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
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			transactionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(transactionVO);
			session.setAttribute("transactionVO", transactionVO);
			
			transactionVO.setInitialDateReport(actionRequest.getParameter("fromDateTransactions"));
			transactionVO.setFinalDateReport(actionRequest.getParameter("toDateTransactions"));
			
	        session.setAttribute("transactionVOTransactions", transactionVO);
			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
			
		} catch (ReportFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest, "error");
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
		
		String action = resourceRequest.getParameter("action");
        //load view for folder content
        if (action.equals("view_content")) {
            include("/hola.jsp", resourceRequest, resourceResponse, PortletRequest.RESOURCE_PHASE);
        }
		
		
//		try {
//			Date date;
//			try {
//				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("fromDateTransactions"));
//				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
//				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("toDateTransactions"));
//				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
//				
//				System.out.println("transactionVO.getInitialDateReport(): " + transactionVO.getInitialDateReport());
//				System.out.println("transactionVO.getFinalDateReport(): " + transactionVO.getFinalDateReport());
//				
//			} catch (NumberFormatException e) {
//				e.printStackTrace();
//			} catch (ParseException e) {
//				e.printStackTrace();
//			}
//			
//			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(transactionVO);
//			System.out.println("listTransactionsByDay.size(): " + listTransactionsByDay.size());
//			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
//		} catch (ReportFacadeException e) {
//			e.printStackTrace();
//			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
//			PortletConfig portletConfig = (PortletConfig)resourceRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//			SessionMessages.add(resourceRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//			SessionErrors.add(resourceRequest, "error");
//			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
//			SessionErrors.add(resourceRequest,transactionVO.getMessage());
//			session.setAttribute("chargeVO", transactionVO);
//		}
//		resourceResponse.setContentType("text/html");
//		PrintWriter writer = resourceResponse.getWriter();
//		writer.print("procesado....");
//        writer.flush();
//        writer.close();
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

