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
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.CountryRestrictionVO;
import au.com.billingbuddy.vo.objects.CountryVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormCountryRestriction extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
			HttpSession session = request.getSession();
			ArrayList<CountryRestrictionVO> listCountryRestrictions = procesorFacade.listCountryRestrictions(new CountryRestrictionVO());
			session.setAttribute("listCountryRestrictions", listCountryRestrictions);
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
	
	public void saveCountryRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		CountryRestrictionVO countryRestrictionVO = new CountryRestrictionVO();
		countryRestrictionVO.setCountryNumeric(actionRequest.getParameter("country"));
		countryRestrictionVO.setValue(actionRequest.getParameter("value"));
		countryRestrictionVO.setConcept(actionRequest.getParameter("concept"));
		countryRestrictionVO.setTimeUnit(actionRequest.getParameter("timeUnit"));
		
//		if(Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent"))){
//			subscriptionVO.setTaxPercent("0");
//		} else {
//			subscriptionVO.setTaxPercent(actionRequest.getParameter("taxPercent"));
//		}
		session.setAttribute("countryRestrictionVO", countryRestrictionVO);
		try {
			procesorFacade.saveCountryRestriction(countryRestrictionVO);
			if(countryRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CountryRestrictionVO> listCountryRestrictions = procesorFacade.listCountryRestrictions(new CountryRestrictionVO());
				session.setAttribute("listCountryRestrictions", listCountryRestrictions);
				SessionMessages.add(actionRequest, "countryRestrictionSavedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("basicPaymentResponseModel.getMessage(): " + countryRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("countryRestrictionVO.getMessage(): " + countryRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,countryRestrictionVO.getMessage());
				session.setAttribute("countryRestrictionVO", countryRestrictionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newCountryRestriction.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("countryRestrictionVO", countryRestrictionVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newCountryRestriction.jsp");
		}
	}
	
	public void listCountries(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			ArrayList<CountryVO> listCountries = procesorFacade.listCountries();
			session.setAttribute("listCountries", listCountries);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/newCountryRestriction.jsp");
	}
	
	public void listCountriesEditCountryRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<CountryRestrictionVO> resultsListCountryRestriction = (ArrayList<CountryRestrictionVO>)session.getAttribute("results");
			CountryRestrictionVO countryRestrictionVO = (CountryRestrictionVO)resultsListCountryRestriction.get(Integer.parseInt(actionRequest.getParameter("indice")));
			session.setAttribute("countryRestrictionVO", countryRestrictionVO);
			
			ArrayList<CountryVO> listCountries = procesorFacade.listCountries();
			session.setAttribute("listCountries", listCountries);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/editCountryRestriction.jsp");
	}	
	
	public void editCountryRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		CountryRestrictionVO countryRestrictionVO = (CountryRestrictionVO)session.getAttribute("countryRestrictionVO");
		countryRestrictionVO.setCountryNumeric(actionRequest.getParameter("country"));
		countryRestrictionVO.setValue(actionRequest.getParameter("value"));
		countryRestrictionVO.setConcept(actionRequest.getParameter("concept"));
		countryRestrictionVO.setTimeUnit(actionRequest.getParameter("timeUnit"));
		
//		if(Utilities.isNullOrEmpty(actionRequest.getParameter("taxPercent"))){
//			subscriptionVO.setTaxPercent("0");
//		} else {
//			subscriptionVO.setTaxPercent(actionRequest.getParameter("taxPercent"));
//		}
		
		session.setAttribute("countryRestrictionVO", countryRestrictionVO);
		try {
			procesorFacade.updateCountryRestriction(countryRestrictionVO);
			if(countryRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CountryRestrictionVO> listCountryRestrictions = procesorFacade.listCountryRestrictions(new CountryRestrictionVO());
				session.setAttribute("listCountryRestrictions", listCountryRestrictions);
				SessionMessages.add(actionRequest, "countryRestrictionUpdatedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("countryRestrictionVO.getMessage(): " + countryRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("countryRestrictionVO.getMessage(): " + countryRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,countryRestrictionVO.getMessage());
				session.setAttribute("countryRestrictionVO", countryRestrictionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editCountryRestriction.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("countryRestrictionVO", countryRestrictionVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editCountryRestriction.jsp");
		}
	}
	
	public void deleteCountryRestriction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		ArrayList<CountryRestrictionVO> resultsListSubscriptions = (ArrayList<CountryRestrictionVO>)session.getAttribute("results");
		CountryRestrictionVO countryRestrictionVO = (CountryRestrictionVO)resultsListSubscriptions.get(Integer.parseInt(actionRequest.getParameter("indice")));
//		String indice = actionRequest.getParameter("indice");
//		ArrayList<SubscriptionVO> resultsListCharge = (ArrayList<SubscriptionVO>)session.getAttribute("results");
//		SubscriptionVO subscriptionVO = (SubscriptionVO)resultsListCharge.get(Integer.parseInt(indice));
		try {
			procesorFacade.deleteCountryRestriction(countryRestrictionVO);
			if(countryRestrictionVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CountryRestrictionVO> listCountryRestrictions = procesorFacade.listCountryRestrictions(new CountryRestrictionVO());
				session.setAttribute("listCountryRestrictions", listCountryRestrictions);
				SessionMessages.add(actionRequest, "countryRestrictionDeletedSuccessfully");
			}else{
				System.out.println("countryRestrictionVO.getMessage(): " + countryRestrictionVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("countryRestrictionVO.getMessage(): " + countryRestrictionVO.getMessage());
				SessionErrors.add(actionRequest,countryRestrictionVO.getMessage());
				session.setAttribute("countryRestrictionVO", countryRestrictionVO);
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("subscriptionVO", countryRestrictionVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}
	
}

