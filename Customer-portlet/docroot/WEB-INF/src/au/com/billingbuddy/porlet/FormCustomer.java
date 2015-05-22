package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.PortletRequest;
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
import au.com.billingbuddy.vo.objects.MerchantCustomerCardVO;
import au.com.billingbuddy.vo.objects.MerchantCustomerVO;
import au.com.billingbuddy.vo.objects.MerchantVO;
import au.com.billingbuddy.vo.objects.PlanVO;
import au.com.billingbuddy.vo.objects.RefundVO;
import au.com.billingbuddy.vo.objects.SubscriptionVO;
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
				ArrayList<MerchantCustomerVO> listCustomersMerchant = procesorFacade.listCustomersMerchant(merchantCustomerVO);
				session.setAttribute("listCustomersMerchant", listCustomersMerchant);
				
			} catch (ProcesorFacadeException e) {
				e.printStackTrace();
				PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(renderRequest,e.getErrorCode());
			}
		} else  if(request.getParameter("accion") != null && request.getParameter("accion").equalsIgnoreCase("renderURLCards")) {
			
			System.out.println("Entra por aca ... ");
			
		} else  if(request.getParameter("accion") != null && request.getParameter("accion").equalsIgnoreCase("renderURLCustomers")) {
			ArrayList<MerchantCustomerVO> listCustomersMerchant = (ArrayList)session.getAttribute("listCustomersMerchant");
			if(listCustomersMerchant == null) listCustomersMerchant = new ArrayList<MerchantCustomerVO>();
			listCustomersMerchant = Methods.orderCustomers(listCustomersMerchant,request.getParameter("orderByCol"),request.getParameter("orderByType"));
			session.setAttribute("listCustomersMerchant", listCustomersMerchant);
		}	
		super.doView(renderRequest, renderResponse);
	}
	
	public void listCustomerInformation(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		String indice = actionRequest.getParameter("indice");
		ArrayList<MerchantCustomerVO> resultsListCharge = (ArrayList<MerchantCustomerVO>)session.getAttribute("results");
		MerchantCustomerVO merchantCustomerVO = (MerchantCustomerVO)resultsListCharge.get(Integer.parseInt(indice));
		
		session.setAttribute("merchantCustomerVO", merchantCustomerVO);
		
		CardVO cardVO = new CardVO();
		cardVO.setCustomerId(merchantCustomerVO.getCustomerId());
		cardVO.setMerchantCustomerId(merchantCustomerVO.getId());
		
		try {
			
			ArrayList<CardVO> listCardsByCustomer = procesorFacade.listCardsByCustomer(cardVO);
			session.setAttribute("listCardsByCustomer", listCardsByCustomer);
			
			TransactionVO transactionVO = new TransactionVO(String.valueOf(PortalUtil.getUserId(request)));
			transactionVO.setMerchantId(null);
			transactionVO.setChargeVO(new ChargeVO());
			transactionVO.getChargeVO().setCardVO(new CardVO());
			transactionVO.getChargeVO().getCardVO().setCustomerId(merchantCustomerVO.getCustomerId());
			ArrayList<TransactionVO> listTransactionsByCustomer = procesorFacade.searchTransactionsByCustomer(transactionVO);
			session.setAttribute("listTransactionsByCustomer", listTransactionsByCustomer);
			
			ChargeVO chargeVO = new ChargeVO();
			chargeVO.setCardVO(new CardVO());
			chargeVO.getCardVO().setCustomerId(merchantCustomerVO.getCustomerId());
			
			ArrayList<ChargeVO> listChargesRefundedByCustomer = procesorFacade.listChargesRefundedByCustomer(chargeVO);
			session.setAttribute("listChargesRefundedByCustomer", listChargesRefundedByCustomer);
			
			SubscriptionVO subscriptionVO = new SubscriptionVO();
			subscriptionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
			subscriptionVO.setMerchantCustomerCardVO(new MerchantCustomerCardVO());
			subscriptionVO.getMerchantCustomerCardVO().setMerchantCustomerVO(merchantCustomerVO);
			
			ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(subscriptionVO);
			session.setAttribute("listSubscriptionsByCustomer", listSubscriptions);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/customer.jsp");
	}

	public void cancelSubscription(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		String idSubscription = (String)actionRequest.getParameter("idSubscription");
		SubscriptionVO subscriptionVO = new SubscriptionVO();
		subscriptionVO.setId(idSubscription);
		ArrayList<SubscriptionVO> listSubscriptionsByCustomer = (ArrayList<SubscriptionVO>)session.getAttribute("listSubscriptionsByCustomer");
		int indiceSubscription = listSubscriptionsByCustomer.indexOf(subscriptionVO);
		subscriptionVO = (SubscriptionVO)listSubscriptionsByCustomer.get(indiceSubscription);
		
		try {
			procesorFacade.cancelSubscription(subscriptionVO);
			if(subscriptionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(subscriptionVO);
				session.setAttribute("listSubscriptionsByCustomer", listSubscriptions);
				SessionMessages.add(actionRequest, "subscriptionCanceledSuccessfully");
				session.removeAttribute("subscriptionVO");
			} else {
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,subscriptionVO.getMessage());
				session.setAttribute("subscriptionVO", subscriptionVO);
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			session.setAttribute("subscriptionVO", subscriptionVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/customer.jsp");
	}

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException, IOException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		if(request.getParameter("accion") != null && request.getParameter("accion").equalsIgnoreCase("refundDetails")) {
			String idCharge = request.getParameter("idCharge");
			ChargeVO chargeVO = new ChargeVO();
			chargeVO.setId(idCharge);
			ArrayList<ChargeVO> listChargesRefundedByCustomer = (ArrayList<ChargeVO>)session.getAttribute("listChargesRefundedByCustomer");
			chargeVO = (ChargeVO)listChargesRefundedByCustomer.get(listChargesRefundedByCustomer.indexOf(chargeVO));
			session.setAttribute("chargeVO", chargeVO);
			
			RefundVO refundVO = new RefundVO();
			refundVO.setId(chargeVO.getId());
			ArrayList<RefundVO> listRefunds = null;
			
			try {
				listRefunds = procesorFacade.listRefunds(refundVO);
				session.setAttribute("listRefunds", listRefunds);
			} catch (ProcesorFacadeException e) {
				e.printStackTrace();
				PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(renderRequest,e.getErrorCode());
			}
		}else if(request.getParameter("accion") != null && request.getParameter("accion").equalsIgnoreCase("addSubscription")){
			try {
				PlanVO planVO = new PlanVO();
				planVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
				ArrayList<PlanVO> listPlans = procesorFacade.listPlans(planVO);
				session.setAttribute("listPlans", listPlans);
				session.removeAttribute("subscriptionVO");
			} catch (ProcesorFacadeException e) {
				e.printStackTrace();
				PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(renderRequest,e.getErrorCode());
			}
		/*}else if(request.getParameter("accion") != null && request.getParameter("accion").equalsIgnoreCase("savedSubscription")){
			 include("/jsp/newSubscription.jsp", renderRequest, renderResponse);*/
		}
		super.render(renderRequest, renderResponse);
	}
	
	public void processForm(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		if(request.getParameter("accion") != null && request.getParameter("accion").equalsIgnoreCase("addSubscription")) {
			try {
				ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
				session.setAttribute("listPlans", listPlans);
				session.removeAttribute("subscriptionVO");
				actionResponse.setRenderParameter("jspPage", "/jsp/newSubscription.jsp");
			} catch (ProcesorFacadeException e) {
				e.printStackTrace();
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest,e.getErrorCode());
				actionResponse.setRenderParameter("jspPage", "/jsp/customer.jsp");
			}
		}
		/*super.processAction(actionRequest, actionResponse);*/
	}

	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(resourceResponse);
		
		HttpSession session = request.getSession();
		String action = resourceRequest.getParameter("action");
		
		if (action != null && action.equals("trialStartDate") && resourceRequest.getParameter("planId") != null) {
			ArrayList<PlanVO> listPlans = (ArrayList<PlanVO>)session.getAttribute("listPlans");
			PlanVO planVO = (PlanVO)listPlans.get(listPlans.indexOf(new PlanVO((String)resourceRequest.getParameter("planId"))));
			response.setContentType("application/json");
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("trialEnd", BBUtils.getCurrentDate(6,Integer.parseInt(planVO.getTrialPeriodDays())));
			jsonObject.put("start", BBUtils.getCurrentDate(6,Integer.parseInt(planVO.getTrialPeriodDays()) + 1));
			PrintWriter writer = resourceResponse.getWriter();
			writer.write(jsonObject.toString());
			writer.flush();
			writer.close();
		}else if (action != null && action.equals("listCards")) {
			include("/jsp/cards.jsp", resourceRequest, resourceResponse, PortletRequest.RESOURCE_PHASE);
		}else if (action != null && action.equals("listSubscriptions")) {
			include("/jsp/subscriptions.jsp", resourceRequest, resourceResponse, PortletRequest.RESOURCE_PHASE);
		}
	}
	
	public void saveCard(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {

		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		MerchantCustomerVO merchantCustomerVO = (MerchantCustomerVO)session.getAttribute("merchantCustomerVO");
		CardVO cardVO = new CardVO();
		cardVO.setCustomerId(merchantCustomerVO.getCustomerId());
		
		cardVO.setName(request.getParameter("name"));
		cardVO.setNumber(request.getParameter("number"));
		cardVO.setLast4(request.getParameter("number").substring(request.getParameter("number").length()-4));
		
		cardVO.setCvv(request.getParameter("securityCode"));
		String expirationMonth = new DecimalFormat("00").format(Double.parseDouble(request.getParameter("expirationMonth")));
		cardVO.setExpMonth(expirationMonth.substring(expirationMonth.length()-2));
		cardVO.setExpYear(request.getParameter("expirationYear"));
		
		cardVO.setAddressLine1(request.getParameter("street"));
		cardVO.setAddressCity(request.getParameter("city"));
		cardVO.setAddressZip(BBUtils.isNullOrEmptyWithDefaulValue((String)request.getParameter("addressZip"),"0"));
		cardVO.setAddresState(request.getParameter("addresState"));
		cardVO.setAddressCountry(request.getParameter("country"));
		
		try {
			procesorFacade.saveCard(cardVO);
			if(cardVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CardVO> listCardsByCustomer = procesorFacade.listCardsByCustomer(cardVO);
				session.setAttribute("listCardsByCustomer", listCardsByCustomer);
				SessionMessages.add(actionRequest, "CardCreatedSuccessfully");
				session.removeAttribute("cardVO");
				session.setAttribute("answerCard","true");
			} else {
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,cardVO.getMessage());
				session.setAttribute("cardVO", cardVO);
				session.setAttribute("answerCard","false");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			session.setAttribute("cardVO", cardVO);
			session.setAttribute("answerCard","false");
		}
		
		
		/*try {
			procesorFacade.saveCard(cardVO);
			session.setAttribute("listCardsByCustomer", listCardsByCustomer);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
		}*/
		
		/*System.out.println("name: " + actionRequest.getParameter("name"));
		
		if(actionRequest.getParameter("name").equalsIgnoreCase("si")) {
			SessionMessages.add(actionRequest, "CardCreatedSuccessfully");
			session.setAttribute("answer","true");
		}else{
			session.setAttribute("answer","false");
			SessionErrors.add(actionRequest,"ErrorCreatingCard");
			SessionMessages.add(actionRequest, PortalUtil.getPortletId(actionRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
		}*/
		
		actionResponse.setRenderParameter("mvcPath", "/jsp/addCard.jsp");
	}
	
	public void editCard(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		String idCard = (String)request.getParameter("idCard");
		CardVO cardVO = new CardVO();
		cardVO.setId(idCard);
		
		ArrayList<CardVO> listCardsByCustomer = (ArrayList<CardVO>)session.getAttribute("listCardsByCustomer");
		int indiceCard = listCardsByCustomer.indexOf(cardVO);
		
		cardVO = (CardVO)listCardsByCustomer.get(indiceCard);
		
		cardVO.setName(request.getParameter("name"));
		cardVO.setNumber(request.getParameter("number"));
		cardVO.setLast4(request.getParameter("number").substring(request.getParameter("number").length()-4));
		
		cardVO.setCvv(request.getParameter("securityCode"));
		String expirationMonth = new DecimalFormat("00").format(Double.parseDouble(request.getParameter("expirationMonth")));
		cardVO.setExpMonth(expirationMonth.substring(expirationMonth.length()-2));
		cardVO.setExpYear(request.getParameter("expirationYear"));
		
		cardVO.setAddressLine1(request.getParameter("street"));
		cardVO.setAddressCity(request.getParameter("city"));
		cardVO.setAddressZip(BBUtils.isNullOrEmptyWithDefaulValue((String)request.getParameter("addressZip"),"0"));
		cardVO.setAddresState(request.getParameter("addresState"));
		cardVO.setAddressCountry(request.getParameter("country"));
		
		try {
			procesorFacade.updateCard(cardVO);
			if(cardVO.getStatus().equalsIgnoreCase("success")) {
				listCardsByCustomer = procesorFacade.listCardsByCustomer(cardVO);
				session.setAttribute("listCardsByCustomer", listCardsByCustomer);
				SessionMessages.add(actionRequest, "CardEditedSuccessfully");
				session.removeAttribute("cardVO");
				session.setAttribute("answerCard","true");
			} else {
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,cardVO.getMessage());
				session.setAttribute("cardVO", cardVO);
				session.setAttribute("answerCard","false");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			session.setAttribute("cardVO", cardVO);
			session.setAttribute("answerCard","false");
		}
		actionResponse.setRenderParameter("mvcPath", "/jsp/editCard.jsp");
		actionResponse.setRenderParameter("idCard", actionRequest.getParameter("idCard"));
	}
	
	public void saveSubscription(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		MerchantCustomerVO merchantCustomerVO = (MerchantCustomerVO)session.getAttribute("merchantCustomerVO");
		SubscriptionVO subscriptionVO = new SubscriptionVO();
		subscriptionVO.setMerchantCustomerCardId(actionRequest.getParameter("card"));
		
		subscriptionVO.setPlanId(actionRequest.getParameter("plan"));
		subscriptionVO.setQuantity(actionRequest.getParameter("quantity"));
		
		/*subscriptionVO.setCancelAtPeriodEnd(actionRequest.getParameter("cancelAtPeriodEnd"));
		subscriptionVO.setStatus(actionRequest.getParameter("status"));
		subscriptionVO.setApplicationFeePercent(actionRequest.getParameter("applicationFeePercent"));*/
		
		subscriptionVO.setStart(actionRequest.getParameter("start"));
		
		subscriptionVO.setTrialStart(actionRequest.getParameter("trialStartDay"));
		subscriptionVO.setTrialEnd(actionRequest.getParameter("trialEndDay"));
		
		/*Date date;
		
		try {
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("trialStartDay"));
			subscriptionVO.setTrialStart(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("trialEndDay"));
			subscriptionVO.setTrialEnd(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("startAt"));
			subscriptionVO.setStart(Utilities.getDateFormat(5).format(date));
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}*/
		
		if(Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent"))){
			subscriptionVO.setTaxPercent("0");
		} else {
			subscriptionVO.setTaxPercent(actionRequest.getParameter("taxPercent"));
		}
		session.setAttribute("subscriptionVO", subscriptionVO);
		try {
			procesorFacade.saveSubscription(subscriptionVO);
			if(subscriptionVO.getStatus().equalsIgnoreCase("success")) {
				
				subscriptionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
				subscriptionVO.setCardVO(new CardVO());
				subscriptionVO.getCardVO().setCustomerId(merchantCustomerVO.getCustomerId());
				
				subscriptionVO.setUserId(String.valueOf(PortalUtil.getUserId(request)));
				subscriptionVO.setMerchantCustomerCardVO(new MerchantCustomerCardVO());
				subscriptionVO.getMerchantCustomerCardVO().setMerchantCustomerVO(merchantCustomerVO);
				
				ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(subscriptionVO);
				session.setAttribute("listSubscriptionsByCustomer", listSubscriptions);
				
				SessionMessages.add(actionRequest, "subscriptionSavedSuccessfully");
				session.removeAttribute("subscriptionVO");
				session.setAttribute("answerSubscription","true");
			} else {
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,subscriptionVO.getMessage());
				session.setAttribute("subscriptionVO", subscriptionVO);
				session.setAttribute("answerSubscription","false");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			session.setAttribute("subscriptionVO", subscriptionVO);
			session.setAttribute("answerSubscription","false");
			/*e.printStackTrace();*/
			System.out.println("e.getErrorCode(): "  +  e.getErrorCode());
		}
		actionResponse.setRenderParameter("mvcPath", "/jsp/addSubscription.jsp");
	}
	
}

