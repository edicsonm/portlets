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
//		subscriptionVO.setCustomerId(actionRequest.getParameter("amount"));
//		subscriptionVO.setDiscountId(actionRequest.getParameter("amount"));
		subscriptionVO.setCancelAtPeriodEnd(actionRequest.getParameter("cancelAtPeriodEnd"));
		subscriptionVO.setQuantity(actionRequest.getParameter("quantity"));
		subscriptionVO.setStatus(actionRequest.getParameter("status"));
		subscriptionVO.setApplicationFeePercent(actionRequest.getParameter("applicationFeePercent"));
		subscriptionVO.setStart(actionRequest.getParameter("start"));
		
		
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
		Date date;
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("startDay") + "-"+(Integer.parseInt(actionRequest.getParameter("startMonth")) + 1)+"-"+actionRequest.getParameter("startYear"));
			subscriptionVO.setStart(Utilities.getSimpleDateFormat().format(date));
			System.out.println("subscriptionVO.getStart(): " + subscriptionVO.getStart());
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("endedAtDay") + "-"+(Integer.parseInt(actionRequest.getParameter("endedAtMonth")) + 1)+"-"+actionRequest.getParameter("endedAtYear"));
			subscriptionVO.setEndedAt(Utilities.getSimpleDateFormat().format(date));
			System.out.println("subscriptionVO.getEndedAt(): " + subscriptionVO.getEndedAt());
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("canceledAtDay") + "-"+(Integer.parseInt(actionRequest.getParameter("canceledAtMonth")) + 1)+"-"+actionRequest.getParameter("canceledAtYear"));
			subscriptionVO.setCanceledAt(Utilities.getSimpleDateFormat().format(date));
			System.out.println("subscriptionVO.getCanceledAt(): " + subscriptionVO.getCanceledAt());
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("currentPeriodStartDay") + "-"+(Integer.parseInt(actionRequest.getParameter("currentPeriodStartMonth")) + 1)+"-"+actionRequest.getParameter("currentPeriodStartYear"));
			subscriptionVO.setCurrentPeriodStart(Utilities.getSimpleDateFormat().format(date));
			System.out.println("subscriptionVO.getCurrentPeriodStart(): " + subscriptionVO.getCurrentPeriodStart());
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("currentPeriodEndDay") + "-"+(Integer.parseInt(actionRequest.getParameter("currentPeriodEndMonth")) + 1)+"-"+actionRequest.getParameter("currentPeriodEndYear"));
			subscriptionVO.setCurrentPeriodEnd(Utilities.getSimpleDateFormat().format(date));
			System.out.println("subscriptionVO.getCurrentPeriodEnd(): " + subscriptionVO.getCurrentPeriodEnd());
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("trialStartDay") + "-"+(Integer.parseInt(actionRequest.getParameter("trialStartMonth")) + 1)+"-"+actionRequest.getParameter("trialStartYear"));
			subscriptionVO.setTrialStart(Utilities.getSimpleDateFormat().format(date));
			System.out.println("subscriptionVO.getTrialStart(): " + subscriptionVO.getTrialStart());
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			date = Utilities.getSimpleDateFormat().parse(actionRequest.getParameter("trialEndDay") + "-"+(Integer.parseInt(actionRequest.getParameter("trialEndMonth")) + 1)+"-"+actionRequest.getParameter("trialEndYear"));
			subscriptionVO.setTrialEnd(Utilities.getSimpleDateFormat().format(date));
			System.out.println("subscriptionVO.getTrialEnd(): " + subscriptionVO.getTrialEnd());
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		if(Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent"))){
			subscriptionVO.setTaxPercent(actionRequest.getParameter("0"));
		} else {
			subscriptionVO.setTaxPercent(actionRequest.getParameter("taxPercent"));
		}
		
		System.out.println( "plan: "+ actionRequest.getParameter("plan"));
		System.out.println( "cancelAtPeriodEnd: "+ actionRequest.getParameter("cancelAtPeriodEnd"));
		System.out.println( "quantity: "+ actionRequest.getParameter("quantity"));
		System.out.println( "start: "+ subscriptionVO.getStart());
		System.out.println( "status: "+ actionRequest.getParameter("status"));
		System.out.println( "applicationFeePercent: "+ actionRequest.getParameter("applicationFeePercent"));
		System.out.println( "canceledAt: "+ actionRequest.getParameter("canceledAt"));
		System.out.println( "currentPeriodStart: "+ actionRequest.getParameter("currentPeriodStart"));
		System.out.println( "trialEnd: "+ actionRequest.getParameter("trialEnd"));
		System.out.println( "endedAt: "+ actionRequest.getParameter("endedAt"));
		System.out.println( "trialStart: "+ actionRequest.getParameter("trialStart"));
		System.out.println( "taxPercent: "+ actionRequest.getParameter("taxPercent"));
		session.setAttribute("subscriptionVO", subscriptionVO);
		actionResponse.setRenderParameter("jspPage", "/jsp/newSubscription.jsp");
		
//		if(Utilities.isNullOrEmpty(actionRequest.getParameter("trialPeriodDays"))){
//			planVO.setTrialPeriodDays("0");
//		} else {
//			planVO.setTrialPeriodDays(actionRequest.getParameter("trialPeriodDays"));			
//		}
		
/*		try {
			procesorFacade.saveSubscription(subscriptionVO);
			if(subscriptionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(new SubscriptionVO());
				session.setAttribute("listSubscriptions", listSubscriptions);
				SessionMessages.add(actionRequest, "subscriptionSavedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			}else{
				System.out.println("basicPaymentResponseModel.getMessage(): " + subscriptionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("planVO.getMessage(): " + subscriptionVO.getMessage());
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
		}*/
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
	
	public void editSubscription(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		SubscriptionVO subscriptionVO = (SubscriptionVO)session.getAttribute("subscriptionVO");
		subscriptionVO.setPlanId(actionRequest.getParameter("amount"));
		subscriptionVO.setCustomerId(actionRequest.getParameter("amount"));
		subscriptionVO.setDiscountId(actionRequest.getParameter("amount"));
		subscriptionVO.setCancelAtPeriodEnd(actionRequest.getParameter("amount"));
		subscriptionVO.setQuantity(actionRequest.getParameter("amount"));
		subscriptionVO.setStart(actionRequest.getParameter("amount"));
		subscriptionVO.setStatus(actionRequest.getParameter("amount"));
		subscriptionVO.setApplicationFeePercent(actionRequest.getParameter("amount"));
		subscriptionVO.setCanceledAt(actionRequest.getParameter("amount"));
		subscriptionVO.setCurrentPeriodStart(actionRequest.getParameter("amount"));
		subscriptionVO.setTrialEnd(actionRequest.getParameter("amount"));
		subscriptionVO.setEndedAt(actionRequest.getParameter("amount"));
		subscriptionVO.setTrialStart(actionRequest.getParameter("amount"));
		subscriptionVO.setTaxPercent(actionRequest.getParameter("amount"));
		subscriptionVO.setCreationTime(actionRequest.getParameter("amount"));
		
		try {
			procesorFacade.updateSubscription(subscriptionVO);
			if(subscriptionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<SubscriptionVO> listSubscriptions = procesorFacade.listSubscriptions(new SubscriptionVO());
				session.setAttribute("listSubscriptions", listSubscriptions);
				SessionMessages.add(actionRequest, "planUpdatedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			}else{
				System.out.println("basicPaymentResponseModel.getMessage(): " + subscriptionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("subscriptionVO.getMessage(): " + subscriptionVO.getMessage());
				SessionErrors.add(actionRequest,subscriptionVO.getMessage());
				session.setAttribute("subscriptionVO", subscriptionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editPlan.jsp");
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
			actionResponse.setRenderParameter("jspPage", "/jsp/newPlan.jsp");
		}
	}
	
	public void deleteSubscription(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		String indice = actionRequest.getParameter("indice");
		ArrayList<SubscriptionVO> resultsListCharge = (ArrayList<SubscriptionVO>)session.getAttribute("results");
		SubscriptionVO subscriptionVO = (SubscriptionVO)resultsListCharge.get(Integer.parseInt(indice));
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

