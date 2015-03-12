package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.MerchantRestrictionVO;
import au.com.billingbuddy.vo.objects.MerchantVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormMerchantRestriction extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			session.removeAttribute("merchantRestrictionVO");
			ArrayList<MerchantRestrictionVO> listMerchantRestrictions = procesorFacade.listMerchantRestrictions(new MerchantRestrictionVO());
			session.setAttribute("listMerchantRestrictions", listMerchantRestrictions);
		} catch (ProcesorFacadeException e) {
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
	
	public void saveMerchantRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		MerchantRestrictionVO merchantRestrictionVO = new MerchantRestrictionVO();
		merchantRestrictionVO.setMerchantId(actionRequest.getParameter("merchant"));
		merchantRestrictionVO.setValue(actionRequest.getParameter("value"));
		merchantRestrictionVO.setConcept(actionRequest.getParameter("concept"));
		merchantRestrictionVO.setTimeUnit(actionRequest.getParameter("timeUnit"));
		
//		if(Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent"))){
//			subscriptionVO.setTaxPercent("0");
//		} else {
//			subscriptionVO.setTaxPercent(actionRequest.getParameter("taxPercent"));
//		}
		session.setAttribute("merchantRestrictionVO", merchantRestrictionVO);
		try {
			procesorFacade.saveMerchantRestriction(merchantRestrictionVO);
			if(merchantRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantRestrictionVO> listMerchantRestrictions = procesorFacade.listMerchantRestrictions(new MerchantRestrictionVO());
				session.setAttribute("listMerchantRestrictions", listMerchantRestrictions);
				SessionMessages.add(actionRequest, "merchantRestrictionSavedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("merchantRestrictionVO.getMessage(): " + merchantRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("countryRestrictionVO.getMessage(): " + merchantRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,merchantRestrictionVO.getMessage());
				session.setAttribute("merchantRestrictionVO", merchantRestrictionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newMerchantRestriction.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("countryRestrictionVO", merchantRestrictionVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newMerchantRestriction.jsp");
		}
	}
	
	public void listMerchants(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants();
			session.setAttribute("listMerchants", listMerchants);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/newMerchantRestriction.jsp");
	}
	
	public void listMerchantsEditMerchantRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<MerchantRestrictionVO> resultsListMerchantRestriction = (ArrayList<MerchantRestrictionVO>)session.getAttribute("results");
			MerchantRestrictionVO merchantRestrictionVO = (MerchantRestrictionVO)resultsListMerchantRestriction.get(Integer.parseInt(actionRequest.getParameter("indice")));
			session.setAttribute("merchantRestrictionVO", merchantRestrictionVO);
			
			ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants();
			session.setAttribute("listMerchants", listMerchants);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/editMerchantRestriction.jsp");
	}	
	
	public void editMerchantRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		MerchantRestrictionVO merchantRestrictionVO = (MerchantRestrictionVO)session.getAttribute("merchantRestrictionVO");
		merchantRestrictionVO.setMerchantId(actionRequest.getParameter("merchant"));
		merchantRestrictionVO.setValue(actionRequest.getParameter("value"));
		merchantRestrictionVO.setConcept(actionRequest.getParameter("concept"));
		merchantRestrictionVO.setTimeUnit(actionRequest.getParameter("timeUnit"));
		
//		if(Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent"))){
//			subscriptionVO.setTaxPercent("0");
//		} else {
//			subscriptionVO.setTaxPercent(actionRequest.getParameter("taxPercent"));
//		}
		
		session.setAttribute("merchantRestrictionVO", merchantRestrictionVO);
		try {
			procesorFacade.updateMerchantRestriction(merchantRestrictionVO);
			if(merchantRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantRestrictionVO> listMerchantRestrictions = procesorFacade.listMerchantRestrictions(new MerchantRestrictionVO());
				session.setAttribute("listMerchantRestrictions", listMerchantRestrictions);
				SessionMessages.add(actionRequest, "merchantRestrictionUpdatedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("merchantRestrictionVO.getMessage(): " + merchantRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("merchantRestrictionVO.getMessage(): " + merchantRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,merchantRestrictionVO.getMessage());
				session.setAttribute("merchantRestrictionVO", merchantRestrictionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editMerchantRestriction.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("merchantRestrictionVO", merchantRestrictionVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editMerchantRestriction.jsp");
		}
	}
	
	public void deleteCountryRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		ArrayList<MerchantRestrictionVO> resultsListSubscriptions = (ArrayList<MerchantRestrictionVO>)session.getAttribute("results");
		MerchantRestrictionVO merchantRestrictionVO = (MerchantRestrictionVO)resultsListSubscriptions.get(Integer.parseInt(actionRequest.getParameter("indice")));
//		String indice = actionRequest.getParameter("indice");
//		ArrayList<SubscriptionVO> resultsListCharge = (ArrayList<SubscriptionVO>)session.getAttribute("results");
//		SubscriptionVO subscriptionVO = (SubscriptionVO)resultsListCharge.get(Integer.parseInt(indice));
		try {
			procesorFacade.deleteMerchantRestriction(merchantRestrictionVO);
			if(merchantRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantRestrictionVO> listMerchantRestrictions = procesorFacade.listMerchantRestrictions(new MerchantRestrictionVO());
				session.setAttribute("listMerchantRestrictions", listMerchantRestrictions);
				SessionMessages.add(actionRequest, "merchantRestrictionDeletedSuccessfully");
			}else{
				System.out.println("merchantRestrictionVO.getMessage(): " + merchantRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("merchantRestrictionVO.getMessage(): " + merchantRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,merchantRestrictionVO.getMessage());
				session.setAttribute("merchantRestrictionVO", merchantRestrictionVO);
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("merchantRestrictionVO", merchantRestrictionVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}
	
}

