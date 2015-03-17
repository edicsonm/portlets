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
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.CountryVO;
import au.com.billingbuddy.vo.objects.CurrencyVO;
import au.com.billingbuddy.vo.objects.MerchantVO;
import au.com.billingbuddy.vo.objects.PlanVO;
import au.com.billingbuddy.vo.objects.SubscriptionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormPlan extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
			HttpSession session = request.getSession();
			
			ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
			session.setAttribute("listPlans", listPlans);
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
	
	public void listCurrencies(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<CurrencyVO> listCurrencies = procesorFacade.listCurrencies();
			session.setAttribute("listCurrencies", listCurrencies);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/newPlan.jsp");
	}
	
	
	public void listCurrenciesEditPlan(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<PlanVO> resultsListPlans = (ArrayList<PlanVO>)session.getAttribute("results");
			PlanVO planVO = (PlanVO)resultsListPlans.get(Integer.parseInt(actionRequest.getParameter("indice")));
			session.setAttribute("planVO", planVO);
			
			ArrayList<CurrencyVO> listCurrencies = procesorFacade.listCurrencies();
			session.setAttribute("listCurrencies", listCurrencies);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("mvcPath", "/jsp/editPlan.jsp");
	}
	
	public void savePlan(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		PlanVO planVO = new PlanVO();
		planVO.setAmount(actionRequest.getParameter("amount"));
		planVO.setCurrency(actionRequest.getParameter("currency"));
		planVO.setInterval(actionRequest.getParameter("interval"));
		planVO.setIntervalCount(actionRequest.getParameter("intervalCount"));
		planVO.setName(actionRequest.getParameter("name"));
		if(Utilities.isNullOrEmpty(actionRequest.getParameter("trialPeriodDays"))){
			planVO.setTrialPeriodDays("0");
		} else {
			planVO.setTrialPeriodDays(actionRequest.getParameter("trialPeriodDays"));			
		}
		planVO.setStatementDescriptor(actionRequest.getParameter("statementDescriptor"));
		try {
			procesorFacade.savePlan(planVO);
			if(planVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
				session.setAttribute("listPlans", listPlans);
				SessionMessages.add(actionRequest, "planSavedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			}else{
				System.out.println("basicPaymentResponseModel.getMessage(): " + planVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("planVO.getMessage(): " + planVO.getMessage());
				SessionErrors.add(actionRequest,planVO.getMessage());
				session.setAttribute("planVO", planVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newPlan.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("planVO", planVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newPlan.jsp");
		}
	}
	
	public void editPlan(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		PlanVO planVO = (PlanVO)session.getAttribute("planVO");
		planVO.setAmount(actionRequest.getParameter("amount"));
		planVO.setCurrency(actionRequest.getParameter("currency"));
		planVO.setInterval(actionRequest.getParameter("interval"));
		planVO.setIntervalCount(actionRequest.getParameter("intervalCount"));
		planVO.setName(actionRequest.getParameter("name"));
		if(Utilities.isNullOrEmpty(actionRequest.getParameter("trialPeriodDays"))){
			planVO.setTrialPeriodDays("0");
		} else {
			planVO.setTrialPeriodDays(actionRequest.getParameter("trialPeriodDays"));			
		}
		planVO.setStatementDescriptor(actionRequest.getParameter("statementDescriptor"));
		try {
			procesorFacade.updatePlan(planVO);
			if(planVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
				session.setAttribute("listPlans", listPlans);
				SessionMessages.add(actionRequest, "planUpdatedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			}else{
				System.out.println("basicPaymentResponseModel.getMessage(): " + planVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("planVO.getMessage(): " + planVO.getMessage());
				SessionErrors.add(actionRequest,planVO.getMessage());
				session.setAttribute("planVO", planVO);
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
			
			session.setAttribute("planVO", planVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editPlan.jsp");
		}
	}
	
	public void deletePlan(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		String indice = actionRequest.getParameter("indice");
		ArrayList<PlanVO> resultsListCharge = (ArrayList<PlanVO>)session.getAttribute("results");
		PlanVO planVO = (PlanVO)resultsListCharge.get(Integer.parseInt(indice));
		try {
			procesorFacade.deletePlan(planVO);
			if(planVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<PlanVO> listPlans = procesorFacade.listPlans(new PlanVO());
				session.setAttribute("listPlans", listPlans);
				SessionMessages.add(actionRequest, "planDeletedSuccessfully");
			}else{
				System.out.println("basicPaymentResponseModel.getMessage(): " + planVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("planVO.getMessage(): " + planVO.getMessage());
				SessionErrors.add(actionRequest,planVO.getMessage());
				session.setAttribute("planVO", planVO);
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("planVO", planVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}
	
}

