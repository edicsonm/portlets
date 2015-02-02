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
import au.com.billingbuddy.vo.objects.MerchantConfigurationVO;
import au.com.billingbuddy.vo.objects.MerchantVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormMerchantConfiguration extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			session.removeAttribute("merchantConfigurationVO");
			ArrayList<MerchantConfigurationVO> listMerchantConfigurations = procesorFacade.listMerchantConfigurations();
			session.setAttribute("listMerchantConfigurations", listMerchantConfigurations);
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
	
	public void saveMerchantConfiguration(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		MerchantConfigurationVO merchantConfigurationVO = new MerchantConfigurationVO();
		merchantConfigurationVO.setMerchantId(actionRequest.getParameter("merchant"));
		merchantConfigurationVO.setUrlApproved(actionRequest.getParameter("urlApproved"));
		merchantConfigurationVO.setUrlDeny(actionRequest.getParameter("urlDeny"));
		session.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
		
		try {
			procesorFacade.saveMerchantConfiguration(merchantConfigurationVO);
			if(merchantConfigurationVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantConfigurationVO> listMerchantConfigurations = procesorFacade.listMerchantConfigurations();
				session.setAttribute("listMerchantConfigurations", listMerchantConfigurations);
				SessionMessages.add(actionRequest, "merchantConfigurationSavedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("merchantConfigurationVO.getMessage(): " + merchantConfigurationVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("merchantConfigurationVO.getMessage(): " + merchantConfigurationVO.getMessage());
				SessionErrors.add(actionRequest,merchantConfigurationVO.getMessage());
				session.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newMerchantConfiguration.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newMerchantConfiguration.jsp");
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
		actionResponse.setRenderParameter("jspPage", "/jsp/newMerchantConfiguration.jsp");
	}
	
	public void listMerchantsEditMerchant(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<MerchantConfigurationVO> resultsListMerchantConfigurations = (ArrayList<MerchantConfigurationVO>)session.getAttribute("results");
			MerchantConfigurationVO merchantConfigurationVO = (MerchantConfigurationVO)resultsListMerchantConfigurations.get(Integer.parseInt(actionRequest.getParameter("indice")));
			session.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
			
			ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants();
			session.setAttribute("listMerchants", listMerchants);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/editMerchantConfiguration.jsp");
	}	
	
	public void editMerchantConfiguration(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		MerchantConfigurationVO merchantConfigurationVO = (MerchantConfigurationVO)session.getAttribute("merchantConfigurationVO");
		merchantConfigurationVO.setMerchantId(actionRequest.getParameter("merchant"));
		merchantConfigurationVO.setUrlApproved(actionRequest.getParameter("urlApproved"));
		merchantConfigurationVO.setUrlDeny(actionRequest.getParameter("urlDeny"));
		
		session.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
		try {
			procesorFacade.updateMerchantConfiguration(merchantConfigurationVO);
			if(merchantConfigurationVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantConfigurationVO> listMerchantConfigurations = procesorFacade.listMerchantConfigurations();
				session.setAttribute("listMerchantConfigurations", listMerchantConfigurations);
				SessionMessages.add(actionRequest, "merchantConfigurationUpdatedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("merchantConfigurationVO.getMessage(): " + merchantConfigurationVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("merchantConfigurationVO.getMessage(): " + merchantConfigurationVO.getMessage());
				SessionErrors.add(actionRequest,merchantConfigurationVO.getMessage());
				session.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editMerchantConfiguration.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editMerchantConfiguration.jsp");
		}
	}
	
}

