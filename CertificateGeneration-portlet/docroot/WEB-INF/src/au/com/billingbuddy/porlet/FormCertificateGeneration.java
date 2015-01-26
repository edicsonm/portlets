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
import au.com.billingbuddy.business.objects.SecurityFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.exceptions.objects.SecurityFacadeException;
import au.com.billingbuddy.vo.objects.CertificateVO;
import au.com.billingbuddy.vo.objects.CountryVO;
import au.com.billingbuddy.vo.objects.MerchantConfigurationVO;
import au.com.billingbuddy.vo.objects.MerchantVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormCertificateGeneration extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	private SecurityFacade securityFacade  = SecurityFacade.getInstance();
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
	
	public void saveCertificateGeneration(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		CertificateVO certificateVO = new CertificateVO();
		
		certificateVO.setMerchantId(actionRequest.getParameter("merchant"));
		certificateVO.setCommonName(actionRequest.getParameter("commonName"));
		certificateVO.setOrganization(actionRequest.getParameter("organization"));
		certificateVO.setOrganizationUnit(actionRequest.getParameter("organizationUnit"));
		certificateVO.setCountry(actionRequest.getParameter("country"));
		certificateVO.setPasswordKeyStore(actionRequest.getParameter("passwordKeyStore"));
		certificateVO.setPrivacyKeyStore(actionRequest.getParameter("privacyKeyStore"));
		certificateVO.setPasswordkey(actionRequest.getParameter("passwordkey"));
		certificateVO.setKeyName(actionRequest.getParameter("keyName"));
		
		session.setAttribute("certificateVO", certificateVO);
		try {
			securityFacade.certificateGeneration(certificateVO);
			SessionMessages.add(actionRequest, "certificateGenerationSuccessfully");
			actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			
//			if(merchantConfigurationVO.getStatus().equalsIgnoreCase("success")) {
//				ArrayList<MerchantConfigurationVO> listMerchantConfigurations = procesorFacade.listMerchantConfigurations();
//				session.setAttribute("listMerchantConfigurations", listMerchantConfigurations);
//				SessionMessages.add(actionRequest, "merchantConfigurationSavedSuccessfully");
//				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
//			} else {
//				System.out.println("merchantConfigurationVO.getMessage(): " + merchantConfigurationVO.getMessage());
//				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//				SessionErrors.add(actionRequest, "error");
//				System.out.println("merchantConfigurationVO.getMessage(): " + merchantConfigurationVO.getMessage());
//				SessionErrors.add(actionRequest,merchantConfigurationVO.getMessage());
//				session.setAttribute("merchantConfigurationVO", merchantConfigurationVO);
//				actionResponse.setRenderParameter("jspPage", "/jsp/newMerchantConfiguration.jsp");
//			}
		} catch (SecurityFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("certificateVO", certificateVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newCertificateGeneration.jsp");
		}
	}
	
	public void listMerchantsAndCountries(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants();
			session.setAttribute("listMerchants", listMerchants);
			
			ArrayList<CountryVO> listCountries = procesorFacade.listCountries();
			session.setAttribute("listCountries", listCountries);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/newCertificateGeneration.jsp");
	}
	
}

