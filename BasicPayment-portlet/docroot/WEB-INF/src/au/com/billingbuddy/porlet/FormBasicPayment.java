package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
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

import au.com.billigbuddy.utils.BBUtils;
import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.business.objects.TransactionFacade;
import au.com.billingbuddy.business.objects.SecurityFacade;
import au.com.billingbuddy.common.objects.SecurityMethods;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.exceptions.objects.SecurityFacadeException;
import au.com.billingbuddy.exceptions.objects.TransactionFacadeException;
import au.com.billingbuddy.vo.objects.CustomerVO;
import au.com.billingbuddy.vo.objects.MerchantVO;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.mail.service.MailServiceUtil;
import com.liferay.portal.kernel.mail.MailMessage;
import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.ContentUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormBasicPayment extends MVCPortlet {
	
	private ProcesorFacade procesorFacade  = ProcesorFacade.getInstance();
	private TransactionFacade transactionFacade  = TransactionFacade.getInstance();
	private SecurityFacade securityFacade  = SecurityFacade.getInstance();
	private long initialTime;
	private long finalTime;
	
//	@Override
//	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
//		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
//		HttpSession session = request.getSession();
//		TransactionVO transactionVO = new TransactionVO();
//		session.setAttribute("transactionVO", transactionVO);
//		super.doView(renderRequest, renderResponse);
//	}
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
		HttpSession session = request.getSession();
		MerchantVO merchantVO = null;
		try {
	//		System.out.println("originalRequest.getRemoteAddr(): " + originalRequest.getRemoteAddr());
	//		System.out.println("originalRequest.getRemotePort(): " + originalRequest.getRemotePort());
	//		System.out.println("originalRequest.getRequestURI(): " + originalRequest.getRequestURI());
	//		System.out.println("originalRequest.getLocalPort(): " + originalRequest.getLocalPort());
	//		System.out.println("originalRequest.getLocalAddr(): " + originalRequest.getLocalAddr());
	//		System.out.println("originalRequest.getPathInfo(): " + originalRequest.getPathInfo());
	//		System.out.println("originalRequest.getQueryString(): " + originalRequest.getQueryString());
	//		System.out.println("originalRequest.getServerPort(): " + originalRequest.getServerPort());
	//		System.out.println("originalRequest.getRequestURL(): " + originalRequest.getRequestURL());
			
			String merchantID = (String)request.getParameter("merchantID"); 
			String orderNumber= (String)request.getParameter("orderNumber");
			String currency= (String)request.getParameter("currency");
			String transactionAmount= (String)request.getParameter("transactionAmount");
			String signSha1= (String)request.getParameter("signSha1");
			String sha1Value= (String)request.getParameter("sha1Value");
			
			if(!merchantID.isEmpty()){
				merchantVO = new MerchantVO();
				merchantVO.setId(merchantID);
				merchantVO = procesorFacade.validateMerchant(merchantVO);
				if(merchantVO != null && merchantVO.getMerchantConfigurationVO() != null) {
					session.setAttribute("merchantVO", merchantVO);
					
					/*Merchant exists
					 * Validate restrictions by number of transactions
					 * */ 
					if(merchantVO.getCertificateVO() != null && merchantVO.getCertificateVO().getId()!= null){
						if(merchantID != null && orderNumber != null && currency != null && transactionAmount != null && sha1Value != null){
							/* Verify signature in message received*/
							String sha1ValueCalculated = SecurityMethods.sha1Calculator(orderNumber+currency+merchantID+transactionAmount+"");
							boolean answer = securityFacade.validateSignature(merchantVO.getCertificateVO(), sha1ValueCalculated,signSha1);
							if(answer) {
								
								TransactionVO transactionVO = new TransactionVO();
								transactionVO.setMerchantId((String)request.getParameter("merchantID"));
								transactionVO.setOrderNumber((String)request.getParameter("orderNumber"));
								transactionVO.setOrderCurrency((String)request.getParameter("currency"));
								transactionVO.setOrderAmount((String)request.getParameter("transactionAmount"));
								
								transactionVO.setIp(request.getRemoteAddr());
//								transactionVO.setIp("27.32.44.176");
//								transactionVO.setIp("188.138.9.49");
//								transactionVO.setIp("77.247.181.165");
								
								transactionVO.setSessionId(request.getRequestedSessionId());
								transactionVO.setUserAgent(request.getHeader("User-Agent"));
								transactionVO.setAcceptLanguage(request.getHeader("Accept-Language"));
								
								renderRequest.setAttribute("merchantID", (String)request.getParameter("merchantID"));
								renderRequest.setAttribute("orderNumber", (String)request.getParameter("orderNumber"));
								renderRequest.setAttribute("currency", (String)request.getParameter("currency"));
								renderRequest.setAttribute("transactionAmount", (String)request.getParameter("transactionAmount"));
								
								session.setAttribute("transactionVO", transactionVO);
								
								super.doView(renderRequest, renderResponse);
							}else{
								System.out.println("sale por 1");
								include("/jsp/unauthorizedAccess.jsp", renderRequest, renderResponse);
							}
						}else{
							System.out.println("sale por 2");
							include("/jsp/unauthorizedAccess.jsp", renderRequest, renderResponse);
						}
					}else{
						/*No tiene un certificado configurado*/
						
						PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
						LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
						SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
						SessionErrors.add(renderRequest,"SecurityMDTR.validateSignature.FileNotFoundException");
						
						try {
							InternetAddress fromAddress = new InternetAddress("noreply@billingbuddy.com"); // from address
							InternetAddress toAddress = new InternetAddress(merchantVO.getEmailAddress());  // to address
							String body = ContentUtil.get("/templates/MisconfiguredCertificate.tmpl", true);  
							String subject = "subject"; // email subject
							body = StringUtil.replace(body, new String []{"[$NAME$]","[$MERCHANT$]"}, new String []{merchantVO.getFirstName(), merchantVO.getName()}); // replacing the body with our content.
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
						include("/jsp/error.jsp", renderRequest, renderResponse);
					}
				} else if(merchantVO.getMerchantConfigurationVO() == null){
					/*MisconfiguredMerchant Error*/
					PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
					LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
					SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
					SessionErrors.add(renderRequest,merchantVO.getMessage());
					
					try {
						InternetAddress fromAddress = new InternetAddress("noreply@billingbuddy.com"); // from address
						InternetAddress toAddress = new InternetAddress(merchantVO.getEmailAddress());  // to address
						String body = ContentUtil.get("/templates/sample.tmpl", true);  
						String subject = "subject"; // email subject
						body = StringUtil.replace(body, new String []{"[$NAME$]","[$MERCHANT$]"}, new String []{merchantVO.getFirstName(), merchantVO.getName()}); // replacing the body with our content.
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
					include("/jsp/errorMisconfiguredMerchant.jsp", renderRequest, renderResponse);
					
				}else{
					System.out.println("El merchant no existe ....");
					include("/jsp/unauthorizedAccess.jsp", renderRequest, renderResponse);
				}
			}
		} catch (SecurityFacadeException ex) {
			System.out.println("Esta saliendo por SecurityFacadeException ..." + ex.getErrorCode());
			PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(renderRequest,ex.getErrorCode());
			
			TransactionVO transactionVO = new TransactionVO();
			transactionVO.setMerchantId((String)request.getParameter("merchantID"));
			transactionVO.setOrderNumber((String)request.getParameter("orderNumber"));
			transactionVO.setStatus("error");
			transactionVO.setMessage(ex.getErrorCode());
			transactionVO.setData(ex.getErrorMenssage());
			session.setAttribute("transactionVO", transactionVO);
			
			if(ex.getErrorCode().equalsIgnoreCase("SecurityMDTR.validateSignature.FileNotFoundException")){
				try {
					InternetAddress fromAddress = new InternetAddress("noreply@billingbuddy.com"); // from address
					InternetAddress toAddress = new InternetAddress(merchantVO.getEmailAddress());  // to address
					String body = ContentUtil.get("/templates/MisconfiguredCertificate.tmpl", true);  
					String subject = "subject"; // email subject
					body = StringUtil.replace(body, new String []{"[$NAME$]","[$MERCHANT$]"}, new String []{merchantVO.getFirstName(), merchantVO.getName()}); // replacing the body with our content.
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
			}else if(ex.getErrorCode().equalsIgnoreCase("SecurityMDTR.validateSignature.DecoderException")) {
				try {
					InternetAddress fromAddress = new InternetAddress("noreply@billingbuddy.com"); // from address
					InternetAddress toAddress = new InternetAddress(merchantVO.getEmailAddress());  // to address
					String body = ContentUtil.get("/templates/UnreadableMessage.tmpl", true);  
					String subject = "subject"; // email subject
					body = StringUtil.replace(body, new String []{"[$NAME$]","[$MERCHANT$]"}, new String []{merchantVO.getFirstName(), merchantVO.getName()}); // replacing the body with our content.
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
			}
			
			include("/jsp/error.jsp", renderRequest, renderResponse);
			
		} catch (ProcesorFacadeException ex){
			PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(renderRequest,ex.getErrorCode());
			
			TransactionVO transactionVO = new TransactionVO();
			transactionVO.setMerchantId((String)request.getParameter("merchantID"));
			transactionVO.setOrderNumber((String)request.getParameter("orderNumber"));
			transactionVO.setStatus("error");
			transactionVO.setMessage(ex.getErrorCode());
			transactionVO.setData(ex.getErrorMenssage());
			session.setAttribute("transactionVO", transactionVO);
			
			if(ex.getErrorCode().equalsIgnoreCase("ProcessorMDTR.validateMerchant.MerchantRestrictionDAOException.MisconfigureMerchant")){
				/*Enviar email al adm de merchant*/
				
				try {
					InternetAddress fromAddress = new InternetAddress("noreply@billingbuddy.com"); // from address
					InternetAddress toAddress = new InternetAddress(merchantVO.getEmailAddress());  // to address
					
					String body = ContentUtil.get("/templates/sample.tmpl", true);  
					String subject = "subject";
					body = StringUtil.replace(body, new String []{"[$NAME$]","[$MERCHANT$]"}, new String []{merchantVO.getFirstName(), merchantVO.getName()}); // replacing the body with our content.
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
				
				include("/jsp/errorMisconfiguredMerchant.jsp", renderRequest, renderResponse);
			}else{
				include("/jsp/error.jsp", renderRequest, renderResponse);
			}
		} catch (Exception ex){
			ex.printStackTrace();
			include("/jsp/unauthorizedAccess.jsp", renderRequest, renderResponse);
		}
	}
	
	public void savePayment(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(actionResponse);
		HttpSession session = request.getSession();
		TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
		try {
			transactionVO.getCardVO().setBin(transactionVO.getCardVO().getNumber().substring(0, 6));
			/****** Table Card ******/
			transactionVO.getCardVO().setName(request.getParameter("name"));
			transactionVO.getCardVO().setNumber(request.getParameter("cardNumber"));
			transactionVO.getCardVO().setBin(transactionVO.getCardVO().getNumber().substring(0, 6));
			transactionVO.getCardVO().setExpYear(request.getParameter("expirationYear"));
			String expirationMonth = new DecimalFormat("00").format(Double.parseDouble(request.getParameter("expirationMonth")));
			transactionVO.getCardVO().setExpMonth(expirationMonth.substring(expirationMonth.length()-2));
			transactionVO.getCardVO().setCvv(request.getParameter("securityCode"));
			
			transactionVO.setBillingAddressCountry(request.getParameter("country"));
			transactionVO.setBillingAddressRegion(request.getParameter("region"));
			transactionVO.setBillingAddressCity(request.getParameter("city"));
			transactionVO.setBillingAddressPostal(request.getParameter("postalCode"));
			
			transactionVO.getCardVO().setCustomerVO(new CustomerVO());
			transactionVO.getCardVO().getCustomerVO().setEmail(request.getParameter("email"));
			transactionVO.getCardVO().getCustomerVO().setPhoneNumber(request.getParameter("phoneNumber"));
			
			initialTime = Calendar.getInstance().getTimeInMillis();
			transactionVO = transactionFacade.proccesPayment(transactionVO);
			finalTime = Calendar.getInstance().getTimeInMillis();
			System.out.println("Tiempo total de procesamiento de la solicitud: " + (finalTime-initialTime) + " ms.");
			if(transactionVO.getStatus().equalsIgnoreCase("success")){
				try {
					InternetAddress fromAddress = new InternetAddress("noreply@billingbuddy.com"); // from address
					InternetAddress toAddress = new InternetAddress(transactionVO.getCardVO().getCustomerVO().getEmail());  // to address
					String body = ContentUtil.get("/templates/paymentProcessed.tmpl", true);  
					String subject = "subject";
					body = StringUtil.replace(body, new String []{"[$NAME$]","[$AMOUNT$]","[$DATE$]","[$CARDNUMBER$]","[$NUMBER$]"}, 
							new String []{transactionVO.getCardVO().getName(), BBUtils.stripeToCurrency(transactionVO.getChargeVO().getAmount(), transactionVO.getChargeVO().getCurrency()),
							BBUtils.getCurrentDate(3) ,BBUtils.printCardNumber(transactionVO.getCardVO().getNumber()), 
							transactionVO.getId()}); // replacing the body with our content.
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
//				SessionMessages.add(actionRequest, "paymentSuccessful", new Object[] { transactionVO.getId() });
				SessionMessages.add(actionRequest, "paymentSuccessful");
				session.setAttribute("transactionId", transactionVO.getId());
				actionResponse.setRenderParameter("jspPage", "/jsp/sumaryPayment.jsp");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,transactionVO.getErrorCode());
				session.setAttribute("transactionVO", transactionVO);
//				actionResponse.setRenderParameter("jspPage", "/jsp/errorProcessor.jsp");
				actionResponse.setRenderParameter("jspPage", "/jsp/error.jsp");
			}
		} catch (TransactionFacadeException e) {
			
			transactionVO.setStatus("error");
			transactionVO.setMessage(e.getErrorCode());
			transactionVO.setData(e.getErrorMenssage());
			
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest, e.getErrorCode());
			SessionErrors.add(actionRequest,e.getErrorMenssage());
			
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			
			session.setAttribute("transactionVO", transactionVO);
//			actionResponse.setRenderParameter("jspPage", "/jsp/errorProcessor.jsp");
			actionResponse.setRenderParameter("jspPage", "/jsp/error.jsp");
		}
	}
	

	public void acceptPayment(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		addProcessActionSuccessMessage = false;
		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
	}

	@Override
	public void doAbout(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("doAbout");
		super.doAbout(renderRequest, renderResponse);
	}

	@Override
	public void doConfig(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("doConfig");
		super.doConfig(renderRequest, renderResponse);
	}

	@Override
	public void doEdit(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("doEdit");
		super.doEdit(renderRequest, renderResponse);
	}

	@Override
	public void doEditDefaults(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("doEditDefaults");
		super.doEditDefaults(renderRequest, renderResponse);
	}

	@Override
	public void doEditGuest(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("doEditGuest");
		super.doEditGuest(renderRequest, renderResponse);
	}

	@Override
	public void doHelp(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("doHelp");
		super.doHelp(renderRequest, renderResponse);
	}

	@Override
	public void doPreview(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("doPreview");
		super.doPreview(renderRequest, renderResponse);
	}

	@Override
	public void doPrint(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("doPrint");
		super.doPrint(renderRequest, renderResponse);
	}


	@Override
	public void init() throws PortletException {
		// TODO Auto-generated method stub
		System.out.println("init");
		super.init();
	}

	@Override
	public void invokeTaglibDiscussion(ActionRequest actionRequest,
			ActionResponse actionResponse) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("invokeTaglibDiscussion");
		super.invokeTaglibDiscussion(actionRequest, actionResponse);
	}

	@Override
	public void processAction(ActionRequest actionRequest,
			ActionResponse actionResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("processAction");
		super.processAction(actionRequest, actionResponse);
	}

	@Override
	public void serveResource(ResourceRequest resourceRequest,
			ResourceResponse resourceResponse) throws IOException,
			PortletException {
		System.out.println("serveResource");
		super.serveResource(resourceRequest, resourceResponse);
	}
	
}
