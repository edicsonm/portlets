package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import au.com.billigbuddy.utils.BBUtils;
import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.ChargeVO;
import au.com.billingbuddy.vo.objects.PlanVO;
import au.com.billingbuddy.vo.objects.SubscriptionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormSubscription extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
			HttpSession session = request.getSession();
			
			
			SubscriptionVO subscriptionVO = new SubscriptionVO();
			subscriptionVO.setStart(BBUtils.getCurrentDate(6,0));
			subscriptionVO.setEndedAt(BBUtils.getCurrentDate(6,0));
			subscriptionVO.setCanceledAt(BBUtils.getCurrentDate(6,0));
			subscriptionVO.setCurrentPeriodStart(BBUtils.getCurrentDate(6,0));
			subscriptionVO.setCurrentPeriodEnd(BBUtils.getCurrentDate(6,0));
			subscriptionVO.setTrialStart(BBUtils.getCurrentDate(6,0));
			subscriptionVO.setTrialEnd(BBUtils.getCurrentDate(6,0));
			
			session.setAttribute("subscriptionVO", subscriptionVO);
			
			ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(new SubscriptionVO());
			session.setAttribute("listSubscriptions", listSubscriptions);
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
	
	public void saveSubscription(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		SubscriptionVO subscriptionVO = new SubscriptionVO();
		subscriptionVO.setPlanId(actionRequest.getParameter("plan"));
		subscriptionVO.setCancelAtPeriodEnd(actionRequest.getParameter("cancelAtPeriodEnd"));
		subscriptionVO.setQuantity(actionRequest.getParameter("quantity"));
		subscriptionVO.setStatus(actionRequest.getParameter("status"));
		subscriptionVO.setApplicationFeePercent(actionRequest.getParameter("applicationFeePercent"));
		subscriptionVO.setStart(actionRequest.getParameter("start"));
		Date date;
		try {
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("startAt"));
			subscriptionVO.setStart(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("endedAt"));
			subscriptionVO.setEndedAt(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("canceledAt"));
			subscriptionVO.setCanceledAt(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("currentPeriodStart"));
			subscriptionVO.setCurrentPeriodStart(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("currentPeriodEnd"));
			subscriptionVO.setCurrentPeriodEnd(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("trialStartDay"));
			subscriptionVO.setTrialStart(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("trialEndDay"));
			subscriptionVO.setTrialEnd(Utilities.getDateFormat(5).format(date));
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if(Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent"))){
			subscriptionVO.setTaxPercent("0");
		} else {
			subscriptionVO.setTaxPercent(actionRequest.getParameter("taxPercent"));
		}
		
		session.setAttribute("subscriptionVO", subscriptionVO);
		try {
			procesorFacade.saveSubscription(subscriptionVO);
			if(subscriptionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(new SubscriptionVO());
				session.setAttribute("listSubscriptions", listSubscriptions);
				SessionMessages.add(actionRequest, "subscriptionSavedSuccessfully");
				session.removeAttribute("subscriptionVO");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("basicPaymentResponseModel.getMessage(): " + subscriptionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("subscriptionVO.getMessage(): " + subscriptionVO.getMessage());
				SessionErrors.add(actionRequest,subscriptionVO.getMessage());
				session.setAttribute("subscriptionVO", subscriptionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newSubscription.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("subscriptionVO", subscriptionVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newSubscription.jsp");
		}
	}
	
	public void listPlanSubscriptions(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
			session.setAttribute("listPlans", listPlans);
			session.removeAttribute("subscriptionVO");
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/newSubscription.jsp");
	}
	
	public void listPlanEditPlan(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<SubscriptionVO> resultsListSubscriptions = (ArrayList<SubscriptionVO>)session.getAttribute("results");
			SubscriptionVO subscriptionVO = (SubscriptionVO)resultsListSubscriptions.get(Integer.parseInt(actionRequest.getParameter("indice")));
			session.setAttribute("subscriptionVO", subscriptionVO);
			
			ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
			session.setAttribute("listPlans", listPlans);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/editSubscription.jsp");
	}	
	
	public void editSubscription(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		SubscriptionVO subscriptionVO = (SubscriptionVO)session.getAttribute("subscriptionVO");
		subscriptionVO.setPlanId(actionRequest.getParameter("plan"));
		subscriptionVO.setCancelAtPeriodEnd(actionRequest.getParameter("cancelAtPeriodEnd"));
		subscriptionVO.setQuantity(actionRequest.getParameter("quantity"));
		subscriptionVO.setStatus(actionRequest.getParameter("status"));
		subscriptionVO.setApplicationFeePercent(actionRequest.getParameter("applicationFeePercent"));
		subscriptionVO.setStart(actionRequest.getParameter("start"));
		
		Date date;
		try {
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("startAt"));
			subscriptionVO.setStart(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("endedAt"));
			subscriptionVO.setEndedAt(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("canceledAt"));
			subscriptionVO.setCanceledAt(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("currentPeriodStart"));
			subscriptionVO.setCurrentPeriodStart(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("currentPeriodEnd"));
			subscriptionVO.setCurrentPeriodEnd(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("trialStartDay"));
			subscriptionVO.setTrialStart(Utilities.getDateFormat(5).format(date));
			
			date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("trialEndDay"));
			subscriptionVO.setTrialEnd(Utilities.getDateFormat(5).format(date));
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if(Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent"))){
			subscriptionVO.setTaxPercent("0");
		} else {
			subscriptionVO.setTaxPercent(actionRequest.getParameter("taxPercent"));
		}
		session.setAttribute("subscriptionVO", subscriptionVO);
		try {
			procesorFacade.updateSubscription(subscriptionVO);
			if(subscriptionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(new SubscriptionVO());
				session.setAttribute("listSubscriptions", listSubscriptions);
				session.removeAttribute("subscriptionVO");
				SessionMessages.add(actionRequest, "subscriptionSavedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("basicPaymentResponseModel.getMessage(): " + subscriptionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("subscriptionVO.getMessage(): " + subscriptionVO.getMessage());
				SessionErrors.add(actionRequest,subscriptionVO.getMessage());
				session.setAttribute("subscriptionVO", subscriptionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editSubscription.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("subscriptionVO", subscriptionVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editSubscription.jsp");
		}
	}
	
	public void deleteSubscription(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		ArrayList<SubscriptionVO> resultsListSubscriptions = (ArrayList<SubscriptionVO>)session.getAttribute("results");
		SubscriptionVO subscriptionVO = (SubscriptionVO)resultsListSubscriptions.get(Integer.parseInt(actionRequest.getParameter("indice")));
		
		try {
			procesorFacade.deleteSubscription(subscriptionVO);
			if(subscriptionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(new SubscriptionVO());
				session.setAttribute("listSubscriptions", listSubscriptions);
				SessionMessages.add(actionRequest, "subscriptionDeletedSuccessfully");
			}else{
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
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("subscriptionVO", subscriptionVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}
	
}

