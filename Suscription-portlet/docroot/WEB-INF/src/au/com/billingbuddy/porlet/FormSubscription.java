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
		System.out.println("Excecute doView");
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
			HttpSession session = request.getSession();
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
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("startDay") + "-"+(Integer.parseInt(actionRequest.getParameter("startMonth")) + 1)+"-"+actionRequest.getParameter("startYear"));
			subscriptionVO.setStart(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("endedAtDay") + "-"+(Integer.parseInt(actionRequest.getParameter("endedAtMonth")) + 1)+"-"+actionRequest.getParameter("endedAtYear"));
			subscriptionVO.setEndedAt(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("canceledAtDay") + "-"+(Integer.parseInt(actionRequest.getParameter("canceledAtMonth")) + 1)+"-"+actionRequest.getParameter("canceledAtYear"));
			subscriptionVO.setCanceledAt(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("currentPeriodStartDay") + "-"+(Integer.parseInt(actionRequest.getParameter("currentPeriodStartMonth")) + 1)+"-"+actionRequest.getParameter("currentPeriodStartYear"));
			subscriptionVO.setCurrentPeriodStart(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("currentPeriodEndDay") + "-"+(Integer.parseInt(actionRequest.getParameter("currentPeriodEndMonth")) + 1)+"-"+actionRequest.getParameter("currentPeriodEndYear"));
			subscriptionVO.setCurrentPeriodEnd(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("trialStartDay") + "-"+(Integer.parseInt(actionRequest.getParameter("trialStartMonth")) + 1)+"-"+actionRequest.getParameter("trialStartYear"));
			subscriptionVO.setTrialStart(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("trialEndDay") + "-"+(Integer.parseInt(actionRequest.getParameter("trialEndMonth")) + 1)+"-"+actionRequest.getParameter("trialEndYear"));
			subscriptionVO.setTrialEnd(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		System.out.println("Respuesta: " + Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent")));
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
	
	public void listPlan(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
			session.setAttribute("listPlans", listPlans);
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
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("startDay") + "-"+(Integer.parseInt(actionRequest.getParameter("startMonth")) + 1)+"-"+actionRequest.getParameter("startYear"));
			subscriptionVO.setStart(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("endedAtDay") + "-"+(Integer.parseInt(actionRequest.getParameter("endedAtMonth")) + 1)+"-"+actionRequest.getParameter("endedAtYear"));
			subscriptionVO.setEndedAt(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("canceledAtDay") + "-"+(Integer.parseInt(actionRequest.getParameter("canceledAtMonth")) + 1)+"-"+actionRequest.getParameter("canceledAtYear"));
			subscriptionVO.setCanceledAt(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("currentPeriodStartDay") + "-"+(Integer.parseInt(actionRequest.getParameter("currentPeriodStartMonth")) + 1)+"-"+actionRequest.getParameter("currentPeriodStartYear"));
			subscriptionVO.setCurrentPeriodStart(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("currentPeriodEndDay") + "-"+(Integer.parseInt(actionRequest.getParameter("currentPeriodEndMonth")) + 1)+"-"+actionRequest.getParameter("currentPeriodEndYear"));
			subscriptionVO.setCurrentPeriodEnd(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("trialStartDay") + "-"+(Integer.parseInt(actionRequest.getParameter("trialStartMonth")) + 1)+"-"+actionRequest.getParameter("trialStartYear"));
			subscriptionVO.setTrialStart(Utilities.getSimpleDateFormat().format(date));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("trialEndDay") + "-"+(Integer.parseInt(actionRequest.getParameter("trialEndMonth")) + 1)+"-"+actionRequest.getParameter("trialEndYear"));
			subscriptionVO.setTrialEnd(Utilities.getSimpleDateFormat().format(date));
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
		
//		String indice = actionRequest.getParameter("indice");
//		ArrayList<SubscriptionVO> resultsListCharge = (ArrayList<SubscriptionVO>)session.getAttribute("results");
//		SubscriptionVO subscriptionVO = (SubscriptionVO)resultsListCharge.get(Integer.parseInt(indice));
		try {
			procesorFacade.deleteSubscription(subscriptionVO);
			if(subscriptionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(new SubscriptionVO());
				session.setAttribute("listSubscriptions", listSubscriptions);
				SessionMessages.add(actionRequest, "subscriptionDeletedSuccessfully");
			}else{
				System.out.println("basicPaymentResponseModel.getMessage(): " + subscriptionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("subscriptionVO.getMessage(): " + subscriptionVO.getMessage());
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

