package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletContext;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.BusinessTypeVO;
import au.com.billingbuddy.vo.objects.CountryVO;
import au.com.billingbuddy.vo.objects.IndustryVO;
import au.com.billingbuddy.vo.objects.MerchantVO;

import com.liferay.mail.service.MailServiceUtil;
import com.liferay.portal.kernel.mail.MailMessage;
import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.PortalSessionThreadLocal;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.model.User;
import com.liferay.portal.model.UserGroupRole;
import com.liferay.portal.service.UserGroupRoleLocalServiceUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.ContentUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormMerchant extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
//		String UserId = (String)PortalSessionThreadLocal.getHttpSession().getAttribute("UserId");
		try {
//			ThemeDisplay themeDisplay = (ThemeDisplay)renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
//			User user = themeDisplay.getRealUser();
			
			
			ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO(String.valueOf(PortalUtil.getUserId(request))));
			session.setAttribute("listMerchants", listMerchants);
			
			/**/
			ArrayList<CountryVO> listCountries = procesorFacade.listCountries();
			session.setAttribute("listCountries", listCountries);
			
			ArrayList<BusinessTypeVO> listBusinessTypes = procesorFacade.listBusinessTypes();
			session.setAttribute("listBusinessTypes", listBusinessTypes);
			
			ArrayList<IndustryVO> listIndustries = procesorFacade.listIndustries();
			session.setAttribute("listIndustries", listIndustries);
			/**/
			
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
	
//	public void saveMerchant2(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
//		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
//		HttpSession session = request.getSession();
//		
//		MerchantVO merchantVO = new MerchantVO();
//		merchantVO.setName(actionRequest.getParameter("name"));
//		merchantVO.setCountryNumericMerchant(actionRequest.getParameter("countryBusinessInformation"));
//		merchantVO.setTradingName(actionRequest.getParameter("tradingName"));
//		merchantVO.setLegalPhysicalAddress(actionRequest.getParameter("legalPhysicalAddress"));
//		merchantVO.setStatementAddress(actionRequest.getParameter("statementAddress"));
//		merchantVO.setTaxFileNumber(actionRequest.getParameter("taxFileNumber"));
//		merchantVO.setCityBusinessInformation(actionRequest.getParameter("cityBusinessInformation"));
//		merchantVO.setPostCodeBusinessInformation(actionRequest.getParameter("postCodeBusinessInformation"));
//		merchantVO.setCountryNumericMerchant(actionRequest.getParameter("countryBusinessInformation"));
//		merchantVO.setBusinessTypeId(actionRequest.getParameter("businessType"));
//		merchantVO.setIndustryId(actionRequest.getParameter("industry"));
//		merchantVO.setIssuedBusinessID(actionRequest.getParameter("issuedBusinessID"));
//		merchantVO.setIssuedPersonalID(actionRequest.getParameter("issuedPersonalID"));
//		merchantVO.setTypeAccountApplication(actionRequest.getParameter("typeAccountApplication"));
//		merchantVO.setEstimatedAnnualSales(actionRequest.getParameter("estimatedAnnualSales"));
//		
//		merchantVO.setFirstName(actionRequest.getParameter("firstName"));
//		merchantVO.setLastName(actionRequest.getParameter("lastName"));
//		merchantVO.setPhoneNumber(actionRequest.getParameter("phoneNumber"));
//		merchantVO.setFaxNumber(actionRequest.getParameter("faxNumber"));
//		merchantVO.setEmailAddress(actionRequest.getParameter("emailAddress"));
//		merchantVO.setAlternateEmailAddress(actionRequest.getParameter("alternateEmailAddress"));
//		merchantVO.setCityPersonalInformation(actionRequest.getParameter("cityPersonalInformation"));
//		merchantVO.setPostCodePersonalInformation(actionRequest.getParameter("postCodePersonalInformation"));
//		merchantVO.setCountryNumericPersonalInformation(actionRequest.getParameter("countryPersonalInformation"));
//
//		session.setAttribute("merchantVO", merchantVO);
//		try {
//			procesorFacade.saveMerchant(merchantVO);
//			if(merchantVO.getStatus().equalsIgnoreCase("success")) {
//				ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants();
//				session.setAttribute("listMerchants", listMerchants);
//				SessionMessages.add(actionRequest, "merchantSavedSuccessfully");
//				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
//			} else {
//				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//				SessionErrors.add(actionRequest, "error");
//				SessionErrors.add(actionRequest,merchantVO.getMessage());
//				session.setAttribute("merchantVO", merchantVO);
//				actionResponse.setRenderParameter("jspPage", "/jsp/newMerchant.jsp");
//			}
//		} catch (ProcesorFacadeException e) {
//			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//			SessionErrors.add(actionRequest,e.getErrorCode());
//			System.out.println("e.getMessage(): " + e.getMessage());
//			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
//			System.out.println("e.getErrorCode(): " + e.getErrorCode());
//			session.setAttribute("merchantVO", merchantVO);
//			actionResponse.setRenderParameter("jspPage", "/jsp/newMerchant.jsp");
//		}
//	}
	
	public void keepInformation(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
		if(merchantVO == null) merchantVO = new MerchantVO();
		if(actionRequest.getParameter("tabs").equalsIgnoreCase("Business")){
			merchantVO.setName(actionRequest.getParameter("name"));
			merchantVO.setCountryNumericMerchant(actionRequest.getParameter("countryBusinessInformation"));
			merchantVO.setTradingName(actionRequest.getParameter("tradingName"));
			merchantVO.setLegalPhysicalAddress(actionRequest.getParameter("legalPhysicalAddress"));
			merchantVO.setStatementAddress(actionRequest.getParameter("statementAddress"));
			merchantVO.setTaxFileNumber(actionRequest.getParameter("taxFileNumber"));
			merchantVO.setCityBusinessInformation(actionRequest.getParameter("cityBusinessInformation"));
			merchantVO.setPostCodeBusinessInformation(actionRequest.getParameter("postCodeBusinessInformation"));
			merchantVO.setCountryNumericMerchant(actionRequest.getParameter("countryBusinessInformation"));
			merchantVO.setBusinessTypeId(actionRequest.getParameter("businessType"));
			merchantVO.setIndustryId(actionRequest.getParameter("industry"));
			merchantVO.setIssuedBusinessID(actionRequest.getParameter("issuedBusinessID"));
			merchantVO.setIssuedPersonalID(actionRequest.getParameter("issuedPersonalID"));
			merchantVO.setTypeAccountApplication(actionRequest.getParameter("typeAccountApplication"));
			merchantVO.setEstimatedAnnualSales(actionRequest.getParameter("estimatedAnnualSales"));
			actionResponse.setRenderParameter("tabs", "Contact");
		} else {
			merchantVO.setFirstName(actionRequest.getParameter("firstName"));
			merchantVO.setLastName(actionRequest.getParameter("lastName"));
			merchantVO.setPhoneNumber(actionRequest.getParameter("phoneNumber"));
			merchantVO.setFaxNumber(actionRequest.getParameter("faxNumber"));
			merchantVO.setEmailAddress(actionRequest.getParameter("emailAddress"));
			merchantVO.setAlternateEmailAddress(actionRequest.getParameter("alternateEmailAddress"));
			merchantVO.setCityPersonalInformation(actionRequest.getParameter("cityPersonalInformation"));
			merchantVO.setPostCodePersonalInformation(actionRequest.getParameter("postCodePersonalInformation"));
			merchantVO.setCountryNumericPersonalInformation(actionRequest.getParameter("countryPersonalInformation"));
			actionResponse.setRenderParameter("tabs", "Business");
		}
		session.setAttribute("merchantVO", merchantVO);
		actionResponse.setRenderParameter("jspPage", actionRequest.getParameter("jspPage"));
	}
	
	public void saveMerchant(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
		if(merchantVO == null) merchantVO = new MerchantVO();
		merchantVO.setFirstName(actionRequest.getParameter("firstName"));
		merchantVO.setLastName(actionRequest.getParameter("lastName"));
		merchantVO.setPhoneNumber(actionRequest.getParameter("phoneNumber"));
		merchantVO.setFaxNumber(actionRequest.getParameter("faxNumber"));
		merchantVO.setEmailAddress(actionRequest.getParameter("emailAddress"));
		merchantVO.setAlternateEmailAddress(actionRequest.getParameter("alternateEmailAddress"));
		merchantVO.setCityPersonalInformation(actionRequest.getParameter("cityPersonalInformation"));
		merchantVO.setPostCodePersonalInformation(actionRequest.getParameter("postCodePersonalInformation"));
		merchantVO.setCountryNumericPersonalInformation(actionRequest.getParameter("countryPersonalInformation"));

		session.setAttribute("merchantVO", merchantVO);
		try {
			procesorFacade.saveMerchant(merchantVO);
			if(merchantVO.getStatus().equalsIgnoreCase("success")) {
				
				ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO(String.valueOf(PortalUtil.getUserId(request))));
				session.setAttribute("listMerchants", listMerchants);
				SessionMessages.add(actionRequest, "merchantSavedSuccessfully");
				
				 try {
					InternetAddress fromAddress = new InternetAddress("pepitoperez@billingbuddy.com"); // from address
					InternetAddress toAddress = new InternetAddress("edicson@billingbuddy.com");  // to address
		            
					// email body , here we are getting email structure creating the content folder in 
					//the src and create the file with the extension as tmpl.
					String body = ContentUtil.get("/templates/sample.tmpl", true);  
					String subject = "subject"; // email subject
					body = StringUtil.replace(body, new String []{"[$NAME$]","[$DESC$]"}, new String []{"Name","Description"}); // replacing the body with our content.
					MailMessage mailMessage = new MailMessage();
					mailMessage.setTo(toAddress);
					mailMessage.setFrom(fromAddress);
					mailMessage.setSubject(subject);
					mailMessage.setBody(body);
					mailMessage.setHTMLFormat(true);
					MailServiceUtil.sendEmail(mailMessage); // Sending message
					
				} catch (AddressException e1) {
					e1.printStackTrace();
				}
				
				actionResponse.setRenderParameter("jspPage", "/jsp/view_riginal.jsp");
			} else {
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
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
	
	public void newMerchant(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
			HttpSession session = request.getSession();
			
			ArrayList<CountryVO> listCountries = procesorFacade.listCountries();
			session.setAttribute("listCountries", listCountries);
			
			ArrayList<BusinessTypeVO> listBusinessTypes = procesorFacade.listBusinessTypes();
			session.setAttribute("listBusinessTypes", listBusinessTypes);
			
			ArrayList<IndustryVO> listIndustries = procesorFacade.listIndustries();
			session.setAttribute("listIndustries", listIndustries);
			
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
			
			ArrayList<CountryVO> listCountries = procesorFacade.listCountries();
			session.setAttribute("listCountries", listCountries);
			
			ArrayList<BusinessTypeVO> listBusinessTypes = procesorFacade.listBusinessTypes();
			session.setAttribute("listBusinessTypes", listBusinessTypes);
			
			ArrayList<IndustryVO> listIndustries = procesorFacade.listIndustries();
			session.setAttribute("listIndustries", listIndustries);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/editMerchant.jsp");
	}
	
	public void updateMerchant(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
		merchantVO.setFirstName(actionRequest.getParameter("firstName"));
		merchantVO.setLastName(actionRequest.getParameter("lastName"));
		merchantVO.setPhoneNumber(actionRequest.getParameter("phoneNumber"));
		merchantVO.setFaxNumber(actionRequest.getParameter("faxNumber"));
		merchantVO.setEmailAddress(actionRequest.getParameter("emailAddress"));
		merchantVO.setAlternateEmailAddress(actionRequest.getParameter("alternateEmailAddress"));
		merchantVO.setCityPersonalInformation(actionRequest.getParameter("cityPersonalInformation"));
		merchantVO.setPostCodePersonalInformation(actionRequest.getParameter("postCodePersonalInformation"));
		merchantVO.setCountryNumericPersonalInformation(actionRequest.getParameter("countryPersonalInformation"));
		
		session.setAttribute("merchantVO", merchantVO);
		try {
			procesorFacade.updateMerchant(merchantVO);
			if(merchantVO.getStatus().equalsIgnoreCase("success")) {
				
				ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO(String.valueOf(PortalUtil.getUserId(request))));
				session.setAttribute("listMerchants", listMerchants);
				SessionMessages.add(actionRequest, "merchantUpdatedSuccessfully");
				
				try {
					InternetAddress fromAddress = new InternetAddress("pepitoperexedfsfd@billingbuddy.com"); // from address
					InternetAddress toAddress = new InternetAddress("edicson@billingbuddy.com");  // to address
		            
					// email body , here we are getting email structure creating the content folder in 
					//the src and create the file with the extension as tmpl.
					String body = ContentUtil.get("/templates/sampleUpdate.tmpl", true);  
					String subject = "subject"; // email subject
					body = StringUtil.replace(body, new String []{"[$NAME$]","[$DESC$]"}, new String []{"Name","Description"}); // replacing the body with our content.
					MailMessage mailMessage = new MailMessage();
					mailMessage.setTo(toAddress);
					mailMessage.setFrom(fromAddress);
					mailMessage.setSubject(subject);
					mailMessage.setBody(body);
					mailMessage.setHTMLFormat(true);
					MailServiceUtil.sendEmail(mailMessage); // Sending message
					
				} catch (AddressException e1) {
					e1.printStackTrace();
				}
				
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
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
	
	public void editMerchant2(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		MerchantVO merchantVO = (MerchantVO)session.getAttribute("merchantVO");
		
		merchantVO.setName(actionRequest.getParameter("name"));
		merchantVO.setCountryNumericMerchant(actionRequest.getParameter("countryBusinessInformation"));
		merchantVO.setTradingName(actionRequest.getParameter("tradingName"));
		merchantVO.setLegalPhysicalAddress(actionRequest.getParameter("legalPhysicalAddress"));
		merchantVO.setStatementAddress(actionRequest.getParameter("statementAddress"));
		merchantVO.setTaxFileNumber(actionRequest.getParameter("taxFileNumber"));
		merchantVO.setCityBusinessInformation(actionRequest.getParameter("cityBusinessInformation"));
		merchantVO.setPostCodeBusinessInformation(actionRequest.getParameter("postCodeBusinessInformation"));
		merchantVO.setCountryNumericMerchant(actionRequest.getParameter("countryBusinessInformation"));
		merchantVO.setBusinessTypeId(actionRequest.getParameter("businessType"));
		merchantVO.setIndustryId(actionRequest.getParameter("industry"));
		merchantVO.setIssuedBusinessID(actionRequest.getParameter("issuedBusinessID"));
		merchantVO.setIssuedPersonalID(actionRequest.getParameter("issuedPersonalID"));
		merchantVO.setTypeAccountApplication(actionRequest.getParameter("typeAccountApplication"));
		merchantVO.setEstimatedAnnualSales(actionRequest.getParameter("estimatedAnnualSales"));
		
		merchantVO.setFirstName(actionRequest.getParameter("firstName"));
		merchantVO.setLastName(actionRequest.getParameter("lastName"));
		merchantVO.setPhoneNumber(actionRequest.getParameter("phoneNumber"));
		merchantVO.setFaxNumber(actionRequest.getParameter("faxNumber"));
		merchantVO.setEmailAddress(actionRequest.getParameter("emailAddress"));
		merchantVO.setAlternateEmailAddress(actionRequest.getParameter("alternateEmailAddress"));
		merchantVO.setCityPersonalInformation(actionRequest.getParameter("cityPersonalInformation"));
		merchantVO.setPostCodePersonalInformation(actionRequest.getParameter("postCodePersonalInformation"));
		merchantVO.setCountryNumericPersonalInformation(actionRequest.getParameter("countryPersonalInformation"));
		
		session.setAttribute("merchantVO", merchantVO);
		try {
			procesorFacade.updateMerchant(merchantVO);
			if(merchantVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO(String.valueOf(PortalUtil.getUserId(request))));
				session.setAttribute("listMerchants", listMerchants);
				SessionMessages.add(actionRequest, "merchantUpdatedSuccessfully");
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			} else {
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
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
				ArrayList<MerchantVO> listMerchants = procesorFacade.listMerchants(new MerchantVO(String.valueOf(PortalUtil.getUserId(request))));
				session.setAttribute("listMerchants", listMerchants);
				SessionMessages.add(actionRequest, "merchantDeletedSuccessfully");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
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

