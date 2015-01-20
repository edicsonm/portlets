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
import au.com.billingbuddy.vo.objects.CountryVO;
import au.com.billingbuddy.vo.objects.MerchantVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormMerchant extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
			HttpSession session = request.getSession();
			ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO());
			session.setAttribute("listMerchants", listMerchants);
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
	
	public void saveMerchant(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		MerchantVO merchantVO = new MerchantVO();
		merchantVO.setName(actionRequest.getParameter("name"));
		merchantVO.setCountryNumeric(actionRequest.getParameter("country"));
		
		session.setAttribute("merchantVO", merchantVO);
		try {
			procesorFacade.saveMerchant(merchantVO);
			if(merchantVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO());
				session.setAttribute("listMerchants", listMerchants);
				SessionMessages.add(actionRequest, "merchantSavedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("merchantVO.getMessage(): " + merchantVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("merchantVO.getMessage(): " + merchantVO.getMessage());
				SessionErrors.add(actionRequest,merchantVO.getMessage());
				session.setAttribute("merchantVO", merchantVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newMerchant.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("merchantVO", merchantVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newMerchant.jsp");
		}
	}
	
	public void listCountries(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			ArrayList<CountryVO> listCountries = procesorFacade.listCountries(new CountryVO());
			session.setAttribute("listCountries", listCountries);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/newMerchant.jsp");
	}
	
	public void listCountriesEditMerchant(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<MerchantVO> resultsListMerchants = (ArrayList<MerchantVO>)session.getAttribute("results");
			MerchantVO merchantVO = (MerchantVO)resultsListMerchants.get(Integer.parseInt(actionRequest.getParameter("indice")));
			session.setAttribute("merchantVO", merchantVO);
			
			ArrayList<CountryVO> listCountries = procesorFacade.listCountries(new CountryVO());
			session.setAttribute("listCountries", listCountries);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/editMerchant.jsp");
	}	
	
	public void editMerchant(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
		merchantVO.setName(actionRequest.getParameter("name"));
		merchantVO.setCountryNumeric(actionRequest.getParameter("country"));
		
		session.setAttribute("merchantVO", merchantVO);
		try {
			procesorFacade.updateMerchant(merchantVO);
			if(merchantVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO());
				session.setAttribute("listMerchants", listMerchants);
				SessionMessages.add(actionRequest, "merchantUpdatedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("merchantVO.getMessage(): " + merchantVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("merchantVO.getMessage(): " + merchantVO.getMessage());
				SessionErrors.add(actionRequest,merchantVO.getMessage());
				session.setAttribute("merchantVO", merchantVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editMerchant.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("merchantVO", merchantVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editMerchant.jsp");
		}
	}
	
	public void deleteMerchant(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		ArrayList<MerchantVO> resultsListMerchants = (ArrayList<MerchantVO>)session.getAttribute("results");
		MerchantVO merchantVO = (MerchantVO)resultsListMerchants.get(Integer.parseInt(actionRequest.getParameter("indice")));
		try {
			procesorFacade.deleteMerchant(merchantVO);
			if(merchantVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO());
				session.setAttribute("listMerchants", listMerchants);
				SessionMessages.add(actionRequest, "merchantDeletedSuccessfully");
			}else{
				System.out.println("merchantVO.getMessage(): " + merchantVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("merchantVO.getMessage(): " + merchantVO.getMessage());
				SessionErrors.add(actionRequest,merchantVO.getMessage());
				session.setAttribute("merchantVO", merchantVO);
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("merchantVO", merchantVO);
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}
	
}

