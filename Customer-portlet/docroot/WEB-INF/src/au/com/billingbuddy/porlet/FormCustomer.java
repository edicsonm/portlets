package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import au.com.billigbuddy.utils.BBUtils;
import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.business.objects.TransactionFacade;
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.exceptions.objects.ReportFacadeException;
import au.com.billingbuddy.porlet.utilities.Methods;
import au.com.billingbuddy.vo.objects.CardVO;
import au.com.billingbuddy.vo.objects.ChargeVO;
import au.com.billingbuddy.vo.objects.CountryVO;
import au.com.billingbuddy.vo.objects.CurrencyVO;
import au.com.billingbuddy.vo.objects.MerchantCustomerVO;
import au.com.billingbuddy.vo.objects.MerchantVO;
import au.com.billingbuddy.vo.objects.RefundVO;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.mail.service.MailServiceUtil;
import com.liferay.portal.kernel.mail.MailMessage;
import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.Http.Response;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.ContentUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormCustomer extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		if(request.getParameter("accion") == null) {
			try {
				MerchantCustomerVO merchantCustomerVO = new MerchantCustomerVO(String.valueOf(PortalUtil.getUserId(request)));
				merchantCustomerVO.setMerchantId(null);
				System.out.println("merchantCustomerVO.getUserId(): " + merchantCustomerVO.getUserId());
				ArrayList<MerchantCustomerVO> listCustomersMerchant = procesorFacade.listCustomersMerchant(merchantCustomerVO);
				session.setAttribute("listCustomersMerchant", listCustomersMerchant);
			} catch (ProcesorFacadeException e) {
				e.printStackTrace();
				PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(renderRequest,e.getErrorCode());
			}
		} else  if(request.getParameter("accion") != null && request.getParameter("accion").equalsIgnoreCase("renderURLCustomers")) {
			ArrayList<MerchantCustomerVO> listCustomersMerchant = (ArrayList)session.getAttribute("listCustomersMerchant");
			if(listCustomersMerchant == null) listCustomersMerchant = new ArrayList<MerchantCustomerVO>();
			listCustomersMerchant = Methods.orderCustomers(listCustomersMerchant,request.getParameter("orderByCol"),request.getParameter("orderByType"));
			session.setAttribute("listCustomersMerchant", listCustomersMerchant);
		}	
		super.doView(renderRequest, renderResponse);
	}
	
	public void showDetails(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		System.out.println("Ejecuta showDetails");
//		System.out.println("Ejecuta showDetails ...");
//		String id = actionRequest.getParameter("id");
//		String jspPage = actionRequest.getParameter("jspPage");
//		System.out.println("id: " + id);
//		System.out.println("jspPage: " + jspPage);
//		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
//		HttpSession session = request.getSession();
//		actionResponse.setRenderParameter("jspPage", jspPage);
//		super.processAction(actionRequest, actionResponse);
		
	}
	
	public void listCustomerInformation(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		String indice = actionRequest.getParameter("indice");
		ArrayList<MerchantCustomerVO> resultsListCharge = (ArrayList<MerchantCustomerVO>)session.getAttribute("results");
		MerchantCustomerVO merchantCustomerVO = (MerchantCustomerVO)resultsListCharge.get(Integer.parseInt(indice));
		
		System.out.println("merchantCustomerVO.getId(): " + merchantCustomerVO.getId());
		session.setAttribute("merchantCustomerVO", merchantCustomerVO);
		
		
		CardVO cardVO = new CardVO();
		cardVO.setCustomerId(merchantCustomerVO.getCustomerId());
		
		try {
			ArrayList<CardVO> listCardsByCustomer = procesorFacade.listCardsByCustomer(cardVO);
			session.setAttribute("listCardsByCustomer", listCardsByCustomer);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
//			actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
		}
		
//		RefundVO refundVO = new RefundVO();
//		
//		refundVO.setId(chargeVO.getId());
//		ArrayList<RefundVO> listRefunds = null;
//		try {
//			chargeVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
//			chargeVO = procesorFacade.listChargeDetail(chargeVO);
//			session.setAttribute("chargeVO", chargeVO);
//			
//			listRefunds = procesorFacade.listRefunds(refundVO);
//			session.setAttribute("listRefunds", listRefunds);
//			
//			session.setAttribute("indiceRefunds", indice);
//			
//		} catch (ProcesorFacadeException e) {
//			e.printStackTrace();
//			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//			SessionErrors.add(actionRequest,e.getErrorCode());
//			System.out.println("e.getMessage(): " + e.getMessage());
//			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
//			System.out.println("e.getErrorCode(): " + e.getErrorCode());
//			actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
//		}
		actionResponse.setRenderParameter("jspPage", "/jsp/customer.jsp");
	}

	public void listRefunds(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException{
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
//		Methods.printParameters(actionRequest);
		
		ChargeVO chargeVO = new ChargeVO();	
//		System.out.println("displayTerms.isAdvancedSearch()? ... " + actionRequest.getParameter("advancedSearch"));	
		
		if (actionRequest.getParameter("advancedSearch").equalsIgnoreCase("true")) {//Entra aca si selecciona la busqueda avanzada
//			System.out.println("Entra por el if ... ");
			
			if(actionRequest.getParameter("andOperator").equalsIgnoreCase("1")){//Selecciono ALL
//				System.out.println("Selecciono *ALL");
				
				/* currency
				merchant
				countryCard */
				
				chargeVO.setCardVO(new CardVO());
				chargeVO.getCardVO().setNumber(BBUtils.nullStringToNULL(actionRequest.getParameter("cardNumber")));
				
				chargeVO.setTransactionVO(new TransactionVO());
				chargeVO.getTransactionVO().setMerchantId(BBUtils.nullStringToNULL(actionRequest.getParameter("merchant")));
				
				chargeVO.getCardVO().setBrand(BBUtils.nullStringToNULL(actionRequest.getParameter("brand")));
				chargeVO.getCardVO().setCountry(BBUtils.nullStringToNULL(actionRequest.getParameter("countryCard")));
				chargeVO.setCurrency(BBUtils.nullStringToNULL(actionRequest.getParameter("currency")));
				chargeVO.setMatch("0");
				
//				chargeVO.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
//				chargeVO.setFinalDateReport(BBUtils.getCurrentDate(2,0));
//				chargeVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
				
				
				
//				if(fromDateTransactions.isEmpty() || toDateTransactions.isEmpty()){
//					transactionVOAUX.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
//					transactionVOAUX.setFinalDateReport(BBUtils.getCurrentDate(2,0));
//				}else{
					Date date;
					try {
						date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("fromDateCharges"));
						chargeVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
						date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("toDateCharges"));
						chargeVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
					} catch (NumberFormatException | ParseException e) {
						e.printStackTrace();
					}
//				}
					chargeVO.setUserId(String.valueOf(String.valueOf(PortalUtil.getUserId(request))));
				
			}else{
				
//				System.out.println("Selecciono *ANY");
				chargeVO.setCardVO(new CardVO());
				chargeVO.getCardVO().setNumber(BBUtils.nullStringToNULL(actionRequest.getParameter("cardNumber")));
				
				chargeVO.setTransactionVO(new TransactionVO());
				chargeVO.getTransactionVO().setMerchantId(BBUtils.nullStringToNULL(actionRequest.getParameter("merchant")));
				
				chargeVO.getCardVO().setBrand(BBUtils.nullStringToNULL(actionRequest.getParameter("brand")));
				chargeVO.getCardVO().setCountry(BBUtils.nullStringToNULL(actionRequest.getParameter("countryCard")));
				chargeVO.setCurrency(BBUtils.nullStringToNULL(actionRequest.getParameter("currency")));
				chargeVO.setMatch("0");
				
//				if(fromDateTransactions.isEmpty() || toDateTransactions.isEmpty()){
//					transactionVOAUX.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
//					transactionVOAUX.setFinalDateReport(BBUtils.getCurrentDate(2,0));
//				}else{
					Date date;
					try {
						date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("fromDateCharges"));
						chargeVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
						date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("toDateCharges"));
						chargeVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
					} catch (NumberFormatException | ParseException e) {
						e.printStackTrace();
					}
//				}
					chargeVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
				
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
//			System.out.println("Entra por el else ... " + actionRequest.getParameter("keywords"));
			chargeVO.setCardVO(new CardVO());
			chargeVO.getCardVO().setNumber(actionRequest.getParameter("keywords"));
			
			chargeVO.setTransactionVO(new TransactionVO());
			chargeVO.getTransactionVO().setMerchantId(null);
			
			chargeVO.getCardVO().setBrand(null);
			chargeVO.getCardVO().setCountry(null);
			chargeVO.setCurrency(null);
			
			chargeVO.setMatch("1");
			
//			if(fromDateTransactions.isEmpty() || toDateTransactions.isEmpty()){
//				transactionVOAUX.setInitialDateReport(BBUtils.getCurrentDate(2,-1*(150)));
//				transactionVOAUX.setFinalDateReport(BBUtils.getCurrentDate(2,0));
//			}else{
				Date date;
				try {
					date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("fromDateCharges"));
					chargeVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
					date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("toDateCharges"));
					chargeVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
				} catch (NumberFormatException | ParseException e) {
					e.printStackTrace();
				}
//			}
			
//			System.out.println("fromDateTransactions ... " + transactionVO.getInitialDateReport());
//			System.out.println("toDateTransactions ... " + transactionVO.getFinalDateReport());
			chargeVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
			actionResponse.setRenderParameter("keywords", actionRequest.getParameter("keywords"));
		}
		
		try {
			
			ArrayList<ChargeVO> listCharge = procesorFacade.listChargeByDayFiter(chargeVO);
			session.setAttribute("listCharge", listCharge);
			
			chargeVO.setInitialDateReport(actionRequest.getParameter("fromDateCharges"));
			chargeVO.setFinalDateReport(actionRequest.getParameter("toDateCharges"));
			
			session.setAttribute("chargeVOCharges", chargeVO);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest, "error");
			SessionErrors.add(actionRequest,chargeVO.getMessage());
			session.setAttribute("chargeVO", chargeVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}

	
	public void processRefund(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		ChargeVO chargeVO = (ChargeVO)session.getAttribute("chargeVO");
		chargeVO.setRefundVO(new RefundVO());
		chargeVO.getRefundVO().setReason(actionRequest.getParameter("reason"));
		chargeVO.getRefundVO().setAmount(actionRequest.getParameter("refundAmount"));
		chargeVO.getRefundVO().setTransactionId(chargeVO.getTransactionId());
		chargeVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
		try {
			procesorFacade.processRefund(chargeVO);
			if(chargeVO.getStatus().equalsIgnoreCase("success")) {
				RefundVO refundVO = new RefundVO();
				refundVO.setId(chargeVO.getId());
				ArrayList<RefundVO> listRefunds = null;
				try {
					try {
						InternetAddress fromAddress = new InternetAddress("noreply@billingbuddy.com"); // from address
						InternetAddress toAddress = new InternetAddress(chargeVO.getCardVO().getCustomerVO().getEmail());  // to address
						
						String body = ContentUtil.get("/templates/RefundProcessed.tmpl", true);  
						String subject = "subject";
						body = StringUtil.replace(body, new String []{"[$NAME$]","[$AMOUNT$]"}, new String []{chargeVO.getCardVO().getName(), BBUtils.stripeToCurrency(chargeVO.getRefundVO().getAmount(),chargeVO.getCurrency().toUpperCase())}); // replacing the body with our content.
						MailMessage mailMessage = new MailMessage();
						mailMessage.setTo(toAddress);
						mailMessage.setFrom(fromAddress);
						mailMessage.setSubject(subject);
						mailMessage.setBody(body);
						mailMessage.setHTMLFormat(true);
						MailServiceUtil.sendEmail(mailMessage); // Sending message
						
					} catch (AddressException e1) {
						e1.printStackTrace();
					}
					
//					ArrayList<ChargeVO> resultsListCharge = (ArrayList<ChargeVO>)session.getAttribute("results");
//					ChargeVO chargeVOAux = (ChargeVO)resultsListCharge.get(Integer.parseInt((String)session.getAttribute("indiceRefunds")));
					
					chargeVO = procesorFacade.listChargeDetail(chargeVO);
					session.setAttribute("chargeVO", chargeVO);
					
					listRefunds = procesorFacade.listRefunds(refundVO);
					session.setAttribute("listRefunds", listRefunds);
					
					ArrayList<ChargeVO> listCharge = (ArrayList<ChargeVO>)session.getAttribute("listCharge");
					
					listCharge.set(listCharge.indexOf(chargeVO), chargeVO);
					
					session.setAttribute("listCharge", listCharge);
					
					ArrayList<ChargeVO> resultsListCharge = (ArrayList<ChargeVO>)session.getAttribute("results");
					resultsListCharge.set(resultsListCharge.indexOf(chargeVO), chargeVO);
					session.setAttribute("results", resultsListCharge);
					
				} catch (ProcesorFacadeException e) {
					e.printStackTrace();
				}
				
				SessionMessages.add(actionRequest, "refundSuccessful");
				session.setAttribute("transactionId", chargeVO.getId());
				actionResponse.setRenderParameter("jspPage", "/jsp/refund.jsp");
			}else{
				System.out.println("basicPaymentResponseModel.getMessage(): " + chargeVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("chargeVO.getMessage(): " + chargeVO.getMessage());
				SessionErrors.add(actionRequest,chargeVO.getMessage());
				session.setAttribute("chargeVO", chargeVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/refund.jsp");
			}
		} catch (ProcesorFacadeException e) {
			
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);

			SessionErrors.add(actionRequest,e.getErrorCode());
			
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			
			session.setAttribute("chargeVO", chargeVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/refund.jsp");
		}
	}

	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpSession session = request.getSession();
		String salida1 = "<label class='aui-field-label'><fmt:message key='label.refunded'/></label>";
		String salida2 = "<span class='red'>Hello <b>Again 222 </b></span>";
		String salida3 = "<%@ include file='refunds.jsp'%>";
		System.out.println("Executing serveResource ....");
		String orderNumber = resourceRequest.getParameter("orderNumber");
		System.out.println("orderNumber: " + resourceRequest.getParameter("orderNumber"));
		System.out.println("orderNumber: " + resourceRequest.getAttribute("orderNumber"));
		RefundVO refundVO = new RefundVO();
		orderNumber = "40";
		refundVO.setId(orderNumber);
		ArrayList<RefundVO> listRefunds;
		try {
			listRefunds = procesorFacade.listRefunds(refundVO);
			resourceResponse.setContentType("text/html");
			PrintWriter writer = resourceResponse.getWriter();
			JSONObject jsonObject = new JSONObject();
	        jsonObject.put("listRefundsSize", listRefunds.size());
//			writer.print(jsonObject.toString());
			writer.print("Finish");
	        writer.flush();
	        writer.close();
			session.setAttribute("listRefunds", listRefunds);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
		}
		
//		resourceResponse.setContentType("text/html");
//		PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/jsp/refunds.jsp");
//		dispatcher.include(resourceRequest, resourceResponse);
//		
//		getPortletContext().getRequestDispatcher("myMainJSP.jsp").include(request, resourceResponse);
//		resourceResponse.setContentType("application/json");
		
//		resourceResponse.setContentType("text/html");
//		PrintWriter writer = resourceResponse.getWriter();
//		JSONObject jsonObject = new JSONObject();
//		jsonObject.put("key", "value");
//		resourceResponse.getWriter().write(jsonObject.toString());
		
//		String countryId= ParamUtil.getString(resourceRequest, "orderNumber");
//		JSONObject jsonObject = new JSONObject();
//		String statesStr = "1213";
//		jsonObject.put("statesStr ", statesStr );
//		PrintWriter writer = resourceResponse.getWriter();
//		writer.write(jsonObject.toString());
		
//		resourceResponse.setContentType("text/html");
//        PrintWriter writer = resourceResponse.getWriter();
//        JSONObject jsonObject = new JSONObject();
//        jsonObject.put("fullName", "Matches email id. The full name of the user: Edicson");
//        writer.print(jsonObject.toString());
//        writer.flush();
//        writer.close();
//		super.serveResource(resourceRequest, resourceResponse);
	}

	@Override
	public void doEdit(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("Ejecuta doEdit");
		super.doEdit(renderRequest, renderResponse);
	}

	@Override
	public void doHelp(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("Ejecuta doHelp");
		super.doHelp(renderRequest, renderResponse);
	}

	@Override
	public void doPreview(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("Ejecuta doPreview");
		super.doPreview(renderRequest, renderResponse);
	}

	@Override
	public void doPrint(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("Ejecuta doPrint");
		super.doPrint(renderRequest, renderResponse);
	}

	@Override
	public void processAction(ActionRequest actionRequest,
			ActionResponse actionResponse) throws IOException, PortletException {
		super.processAction(actionRequest, actionResponse);
	}

//	public void renderqwqwe(RenderRequest request, RenderResponse response) throws PortletException, IOException {
//		System.out.println("Ejecuta render");
//		HttpServletRequest httpServletRequest = PortalUtil.getHttpServletRequest(request);
//		HttpSession session = httpServletRequest.getSession();
//		String orderNumber = httpServletRequest.getParameter("orderNumber");
//		if(orderNumber != null){
//			RefundVO refundVO = new RefundVO();
//			refundVO.setId(orderNumber!= null ? orderNumber :  (String)session.getAttribute("orderNumber"));
//			ArrayList<RefundVO> listRefunds;
//			try {
//				listRefunds = procesorFacade.listRefunds(refundVO);
//				session.setAttribute("listRefunds", listRefunds);
//			} catch (ProcesorFacadeException e) {
//				e.printStackTrace();
//			}
//		}else{
//			
//		}
//			
//		super.render(request, response);
//	}
	
}

