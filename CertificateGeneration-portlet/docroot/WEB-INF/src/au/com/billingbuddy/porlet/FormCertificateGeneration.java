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
//			session.removeAttribute("certificateVO");
			ArrayList<CertificateVO> listCertificates = securityFacade.listCertificates();
			session.setAttribute("listCertificates", listCertificates);
		} catch (SecurityFacadeException e) {
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
		certificateVO.setPasswordkey(actionRequest.getParameter("passwordkey"));
		certificateVO.setKeyName(actionRequest.getParameter("keyName"));
		session.setAttribute("certificateVO", certificateVO);
		try {
			securityFacade.certificateGeneration(certificateVO);
			if(certificateVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CertificateVO> listCertificates = securityFacade.listCertificates();
				session.setAttribute("listCertificates", listCertificates);
				SessionMessages.add(actionRequest, "certificateGenerationSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				System.out.println("merchantConfigurationVO.getMessage(): " + certificateVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("certificateVO.getMessage(): " + certificateVO.getMessage());
				SessionErrors.add(actionRequest,certificateVO.getMessage());
				session.setAttribute("certificateVO", certificateVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newCertificateGeneration.jsp");
			}
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
	
	public void changeStatus(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		ArrayList<CertificateVO> resultsListCertificates = (ArrayList<CertificateVO>)session.getAttribute("results");
		CertificateVO certificateVO = (CertificateVO)resultsListCertificates.get(Integer.parseInt(actionRequest.getParameter("indice")));
		try {
			if(certificateVO.getStatus().equalsIgnoreCase("1")) {
				certificateVO.setStatus("0");
			}else{ 
				certificateVO.setStatus("1");
			}
			session.setAttribute("certificateVO", certificateVO);
			securityFacade.updateStatusCertificate(certificateVO);
			if(certificateVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CertificateVO> listCertificates = securityFacade.listCertificates();
				session.setAttribute("listCertificates", listCertificates);
				SessionMessages.add(actionRequest, "certificateChangeSuccessfully");
			} else {
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("certificateVO.getMessage(): " + certificateVO.getMessage());
				SessionErrors.add(actionRequest,certificateVO.getMessage());
				session.setAttribute("certificateVO", certificateVO);
			}
			
		} catch (SecurityFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			if(certificateVO.getStatus().equalsIgnoreCase("1")) {
				certificateVO.setStatus("0");
			}else{ 
				certificateVO.setStatus("1");
			}
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}
	
}

