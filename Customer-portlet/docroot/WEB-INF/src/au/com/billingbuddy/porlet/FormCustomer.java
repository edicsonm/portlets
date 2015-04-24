package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
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
import au.com.billingbuddy.vo.objects.PlanVO;
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
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/customer.jsp");
	}

	@Override
	public void doEdit(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		System.out.println("Ejecuta doEdit");
		super.doEdit(renderRequest, renderResponse);
	}

	@Override
	public void doHelp(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		System.out.println("Ejecuta doHelp");
		super.doHelp(renderRequest, renderResponse);
	}

	@Override
	public void doPreview(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		System.out.println("Ejecuta doPreview");
		super.doPreview(renderRequest, renderResponse);
	}

	@Override
	public void doPrint(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		System.out.println("Ejecuta doPrint");
		super.doPrint(renderRequest, renderResponse);
	}

	@Override
	public void processAction(ActionRequest actionRequest,
			ActionResponse actionResponse) throws IOException, PortletException {
		System.out.println("Ejecuta processAction");
		super.processAction(actionRequest, actionResponse);
	}

	@Override
	public void render(RenderRequest renderRequest, RenderResponse response) throws PortletException, IOException {
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
			System.out.println("Ejecuta la opcion addSubscription .... ");
			try {
				ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
				session.setAttribute("listPlans", listPlans);
				session.removeAttribute("subscriptionVO");
			} catch (ProcesorFacadeException e) {
				e.printStackTrace();
				PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(renderRequest,e.getErrorCode());
			}
		}
		super.render(renderRequest, response);
	}
	
	
	public void saveSubscription(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		System.out.println("Ejecuta saveSubscription");
//		super.processAction(actionRequest, actionResponse);
	}
	
}

