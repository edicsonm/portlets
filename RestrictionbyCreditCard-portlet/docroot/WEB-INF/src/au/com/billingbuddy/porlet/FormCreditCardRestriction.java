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
import au.com.billingbuddy.vo.objects.CreditCardRestrictionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormCreditCardRestriction extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			session.removeAttribute("creditCardRestrictionVO");
			ArrayList<CreditCardRestrictionVO> listCreditCardRestrictions = procesorFacade.listCreditCardRestrictions();
			session.setAttribute("listCreditCardRestrictions", listCreditCardRestrictions);
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
	
	public void saveCreditCardRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		CreditCardRestrictionVO creditCardRestrictionVO = new CreditCardRestrictionVO();
		creditCardRestrictionVO.setValue(actionRequest.getParameter("value"));
		creditCardRestrictionVO.setConcept(actionRequest.getParameter("concept"));
		creditCardRestrictionVO.setTimeUnit(actionRequest.getParameter("timeUnit"));
		
		session.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
		try {
			procesorFacade.saveCreditCardRestriction(creditCardRestrictionVO);
			if(creditCardRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CreditCardRestrictionVO> listCreditCardRestrictions = procesorFacade.listCreditCardRestrictions();
				session.setAttribute("listCreditCardRestrictions", listCreditCardRestrictions);
				SessionMessages.add(actionRequest, "creditCardRestrictionSavedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("creditCardRestrictionVO.getMessage(): " + creditCardRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("creditCardRestrictionVO.getMessage(): " + creditCardRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,creditCardRestrictionVO.getMessage());
				session.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newCreditCardRestriction.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newCreditCardRestriction.jsp");
		}
	}
	
	public void editCreditCardRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		CreditCardRestrictionVO creditCardRestrictionVO = (CreditCardRestrictionVO)session.getAttribute("creditCardRestrictionVO");
		creditCardRestrictionVO.setValue(actionRequest.getParameter("value"));
		creditCardRestrictionVO.setConcept(actionRequest.getParameter("concept"));
		creditCardRestrictionVO.setTimeUnit(actionRequest.getParameter("timeUnit"));
		
		session.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
		try {
			procesorFacade.updateCreditCardRestriction(creditCardRestrictionVO);
			if(creditCardRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CreditCardRestrictionVO> listCreditCardRestrictions = procesorFacade.listCreditCardRestrictions();
				session.setAttribute("listCreditCardRestrictions", listCreditCardRestrictions);
				SessionMessages.add(actionRequest, "creditCardRestrictionUpdatedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("creditCardRestrictionVO.getMessage(): " + creditCardRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("merchantRestrictionVO.getMessage(): " + creditCardRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,creditCardRestrictionVO.getMessage());
				session.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editCreditCardRestriction.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editCreditCardRestriction.jsp");
		}
	}
	
	public void deleteCreditCardRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		ArrayList<CreditCardRestrictionVO> resultsListSubscriptions = (ArrayList<CreditCardRestrictionVO>)session.getAttribute("results");
		CreditCardRestrictionVO creditCardRestrictionVO = (CreditCardRestrictionVO)resultsListSubscriptions.get(Integer.parseInt(actionRequest.getParameter("indice")));
//		String indice = actionRequest.getParameter("indice");
//		ArrayList<SubscriptionVO> resultsListCharge = (ArrayList<SubscriptionVO>)session.getAttribute("results");
//		SubscriptionVO subscriptionVO = (SubscriptionVO)resultsListCharge.get(Integer.parseInt(indice));
		try {
			procesorFacade.deleteCreditCardRestriction(creditCardRestrictionVO);
			if(creditCardRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CreditCardRestrictionVO> listCreditCardRestrictions = procesorFacade.listCreditCardRestrictions();
				session.setAttribute("listCreditCardRestrictions", listCreditCardRestrictions);
				SessionMessages.add(actionRequest, "creditCardRestrictionDeletedSuccessfully");
			}else{
				System.out.println("creditCardRestrictionVO.getMessage(): " + creditCardRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("creditCardRestrictionVO.getMessage(): " + creditCardRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,creditCardRestrictionVO.getMessage());
				session.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("creditCardRestrictionVO", creditCardRestrictionVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}
	
}

