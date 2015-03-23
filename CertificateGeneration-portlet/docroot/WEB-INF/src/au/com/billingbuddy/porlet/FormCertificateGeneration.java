package au.com.billingbuddy.porlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.business.objects.SecurityFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.exceptions.objects.SecurityFacadeException;
import au.com.billingbuddy.vo.objects.CertificateVO;
import au.com.billingbuddy.vo.objects.CountryVO;
import au.com.billingbuddy.vo.objects.MerchantConfigurationVO;
import au.com.billingbuddy.vo.objects.MerchantVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.HttpHeaders;
import com.liferay.portal.kernel.servlet.ServletResponseUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;
import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;

public class FormCertificateGeneration extends MVCPortlet {
	
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	private SecurityFacade securityFacade  = SecurityFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
//			session.removeAttribute("certificateVO");
			ArrayList<CertificateVO> listCertificates = securityFacade.listCertificates(new CertificateVO(String.valueOf(PortalUtil.getUserId(request))));
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
				ArrayList<CertificateVO> listCertificates = securityFacade.listCertificates(new CertificateVO(String.valueOf(PortalUtil.getUserId(request))));
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
			
			ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO(String.valueOf(PortalUtil.getUserId(request))));
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
		CertificateVO certificateVO = resultsListCertificates.get(Integer.parseInt(actionRequest.getParameter("indice")));
		try {
			if(certificateVO.getStatus().equalsIgnoreCase("1")) {
				certificateVO.setStatus("0");
			}else{ 
				certificateVO.setStatus("1");
			}
			session.setAttribute("certificateVO", certificateVO);
			certificateVO = securityFacade.updateStatusCertificate(certificateVO);
			if(certificateVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<CertificateVO> listCertificates = securityFacade.listCertificates(new CertificateVO(String.valueOf(PortalUtil.getUserId(request))));
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
	
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws PortletException, IOException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(resourceResponse);
		HttpSession session = request.getSession();
		CertificateVO certificateVO = new CertificateVO();
		
		String action = resourceRequest.getParameter("action");
		System.out.println("action: " + action);
		if(action.equalsIgnoreCase("chargeMerchantInformation")){
			ArrayList<MerchantVO> listMerchants = (ArrayList<MerchantVO>)session.getAttribute("listMerchants");
			String idMerchantCertificateGeneration = resourceRequest.getParameter("idMerchantCertificateGeneration");
			System.out.println("idMerchant: " + idMerchantCertificateGeneration);
			
			String otrovalor = resourceRequest.getParameter("otrovalor");
			System.out.println("otrovalor: " + otrovalor);
			
			response.setContentType("application/json");
				
			for (Iterator iterator = listMerchants.iterator(); iterator.hasNext();) {
			MerchantVO merchantVO = (MerchantVO) iterator.next();
				if(merchantVO.getId().equalsIgnoreCase(idMerchantCertificateGeneration)){
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("commonName", merchantVO.getName());
					jsonObject.put("organization", merchantVO.getName());
					jsonObject.put("organizationUnit", "IT-Security");
					PrintWriter writer = resourceResponse.getWriter();
					writer.write(jsonObject.toString());
				}
				
			}
		}else if(action.equalsIgnoreCase("downloadCertificate")){
			try {
				certificateVO.setId(resourceRequest.getParameter("idCertificate"));
				certificateVO = securityFacade.downloadCertificate(certificateVO);
				
				response.setContentType("application/html");
				response.setHeader("Content-Disposition", "attachment; filename=\"Merchant.jks\"");
				
				BufferedInputStream input = null;
				BufferedOutputStream output = null;
				
				try {
					input = new BufferedInputStream(certificateVO.getMerchantKeyStore().getBinaryStream());
					output = new BufferedOutputStream(response.getOutputStream());
			
					byte[] buffer = new byte[8192];
					for (int length = 0; (length = input.read(buffer)) > 0;) {
						output.write(buffer, 0, length);
					}
				}catch(Exception e){
					e.printStackTrace();
				}finally {
					if (output != null) try { output.close(); } catch (IOException ignore) {}
					if (input != null) try { input.close(); } catch (IOException ignore) {}
				}
			
			} catch (SecurityFacadeException e1) {
				e1.printStackTrace();
			}
		}

	}
	
}

