package au.com.billingbuddy.porlet;

import java.io.IOException;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.PortletRequest;
import javax.portlet.PortletURL;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.TransactionFacade;
import au.com.billingbuddy.common.objects.SecurityMethods;
import au.com.billingbuddy.exceptions.objects.DataSanitizeException;
import au.com.billingbuddy.jsonprocessor.JsonProcessor;
import au.com.billingbuddy.vo.objects.CardVO;
import au.com.billingbuddy.vo.objects.CustomerVO;
import au.com.billingbuddy.vo.objects.ShippingAddressVO;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.PortletURLFactoryUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormBasicPayment extends MVCPortlet {
	
	private JsonProcessor jsonProcessor = JsonProcessor.getInstance();
	private TransactionFacade transactionFacade  = TransactionFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		try {
			HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
			HttpSession session = request.getSession();
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
			
			if(merchantID != null && orderNumber != null && currency != null && transactionAmount != null && sha1Value != null){
				/* Verify signature in message received*/
				String sha1ValueCalculated = SecurityMethods.sha1Calculator(orderNumber+currency+merchantID+transactionAmount+"");
				boolean answer = transactionFacade.validateSignature(sha1ValueCalculated,signSha1);
				if(answer) {
					
					TransactionVO transactionVO = new TransactionVO();
					transactionVO.setMerchantId((String)request.getParameter("merchantID"));
					transactionVO.setOrderNumber((String)request.getParameter("orderNumber"));
					transactionVO.setOrderCurrency((String)request.getParameter("currency"));
					transactionVO.setOrderAmount((String)request.getParameter("transactionAmount"));
					
					transactionVO.setIp(request.getRemoteAddr());
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
					include("/jsp/unauthorizedAccess.jsp", renderRequest, renderResponse);
				}
			}else{
				include("/jsp/unauthorizedAccess.jsp", renderRequest, renderResponse);
			}
		} catch (Exception ex){
			include("/jsp/unauthorizedAccess.jsp", renderRequest, renderResponse);
		}
		
	}
	
	public void savePayment(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(actionResponse);
		HttpSession session = request.getSession();
		TransactionVO transactionVO = (TransactionVO)session.getAttribute("transactionVO");
		
		String orderNumber= (String)request.getParameter("orderNumber");
		System.out.println("OrderNumber in savePayment: " + orderNumber);
		
		transactionVO.setId("1202182387");
//		session.setAttribute("transactionVO", transactionVO);
		actionResponse.setRenderParameter("jspPage", "/jsp/sumaryPayment.jsp");
		
	}
	
	public void savePayment_bk(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		try {
			
			TransactionVO transactionVO = new TransactionVO();
			CardVO cardVO = new CardVO();
			ShippingAddressVO shippingAddressVO = new ShippingAddressVO();
			CustomerVO customerVO = new CustomerVO();
			
			/****** Table Card ******/
			cardVO.setName(request.getParameter("name"));
			cardVO.setCardNumber(request.getParameter("cardNumber"));
			cardVO.setBin(cardVO.getCardNumber().substring(0, 6));
			cardVO.setExpYear(request.getParameter("expirationYear"));
			String expirationMonth = "0"+ request.getParameter("expirationMonth");
			cardVO.setExpMonth(expirationMonth.substring(expirationMonth.length()-2));
			cardVO.setCvv(request.getParameter("securityCode"));
			
			
			/****** Table TransactionInformation ******/
			transactionVO.setCompanyName(request.getParameter("companyName"));
			transactionVO.setProduct("Toothbrush");
			transactionVO.setQuantity("2");
			transactionVO.setRate("100.0");
			transactionVO.setOrderAmount("100");

			transactionVO.setOrderCurrency("USD");
			transactionVO.setMerchantId("2");
			transactionVO.setTxnType("creditcard");
			
			transactionVO.setIp(request.getRemoteAddr());
			transactionVO.setBillingAddressCity("New York");
			transactionVO.setBillingAddressRegion("NY");
			transactionVO.setBillingAddressPostal("11434");
			transactionVO.setBillingAddressCountry("US");
//			transactionVO.setId(jSONObject.get("txnID").toString());
			transactionVO.setSessionId(request.getRequestedSessionId());
			transactionVO.setUserAgent(request.getHeader("User-Agent"));
			transactionVO.setAcceptLanguage(request.getHeader("Accept-Language"));
			transactionVO.setDomain("yahoo.com");

			/****** Table ShippingAddress ******/
			shippingAddressVO.setAddress("145-50 157TH STREET");
			shippingAddressVO.setCity("Jamaica");
			shippingAddressVO.setRegion("NY");
			shippingAddressVO.setPostal("11434");
			shippingAddressVO.setCountry("US");
			
			/****** Table Customer ******/
			customerVO.setEmail(request.getParameter("email"));
			customerVO.setUsername("1234");
			customerVO.setPassword("test_carder_password");
			
			transactionVO.setCardVO(cardVO);
			transactionVO.setShippingAddressVO(shippingAddressVO);
			transactionVO.setCustomerVO(customerVO);
			
			transactionVO = transactionFacade.proccesPayment(transactionVO);
			if(transactionVO.getStatus().equalsIgnoreCase("success")){
				SessionMessages.add(actionRequest, "paymentSuccessful");
				session.setAttribute("transactionId", transactionVO.getId());
				actionResponse.setRenderParameter("jspPage", "/jsp/sumaryPayment.jsp");
			}else{
				
				System.out.println("basicPaymentResponseModel.getMessage(): " + transactionVO.getMessage());
				
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,transactionVO.getMessage());
				session.setAttribute("transactionVO", transactionVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
			}
			
/*Aca comienza el anterior proceso definido para trabajar con JSON*/			
			
//			BasicPaymentModel basicPaymentModel = new BasicPaymentModel();
//			basicPaymentModel.setName(request.getParameter("name"));
//			basicPaymentModel.setEmail(request.getParameter("email"));
//			basicPaymentModel.setCompanyName(request.getParameter("companyName"));
//			basicPaymentModel.setCardNumber(request.getParameter("cardNumber"));
//			basicPaymentModel.setExpirationYear(request.getParameter("expirationYear"));
//			String expirationMonth = "0"+ request.getParameter("expirationMonth");
//			basicPaymentModel.setExpirationMonth(expirationMonth.substring(expirationMonth.length()-2));
//			basicPaymentModel.setCvv(request.getParameter("securityCode"));
//			
//			basicPaymentModel.setIp(request.getRemoteAddr());
//			basicPaymentModel.setSessionId(request.getRequestedSessionId());
//			basicPaymentModel.setUserAgent(request.getHeader("User-Agent"));
//			basicPaymentModel.setAcceptLanguage(request.getHeader("Accept-Language"));
			
//			JSONObject jSONObject = jsonProcessor.encodeJSONBasicPayment(basicPaymentModel);
//			System.out.println("Mensaje construido: " + jSONObject.toJSONString());
//			String respuesta = transactionFacade.proccesMessage(jSONObject.toJSONString());
//			System.out.println("respuesta: " + respuesta);
//			basicPaymentModel = jsonProcessor.decodeJSONBasicPayment(respuesta);
			
//			if(basicPaymentModel.getStatus().equalsIgnoreCase("success")){
//				SessionMessages.add(actionRequest, "paymentSuccessful");
//				session.setAttribute("basicPaymentModel", basicPaymentModel);
//				actionResponse.setRenderParameter("jspPage", "/jsp/sumaryPayment.jsp");
//			} else {
//				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//				System.out.println("basicPaymentResponseModel.getMessage(): " + basicPaymentModel.getMessage());
//				
//				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//				SessionErrors.add(actionRequest, "error");
//				SessionErrors.add(actionRequest,basicPaymentModel.getMessage());
//				session.setAttribute("basicPaymentModel", basicPaymentModel);
//				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
//			}
/*Aca termina el anterior proceso definido para trabajar con JSON*/
			
		} catch (DataSanitizeException e) {
			e.printStackTrace();
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
	
//	@Override
//	protected void addSuccessMessage(ActionRequest actionRequest, ActionResponse actionResponse) {
//		System.out.println("Ejecuta addSuccessMessage ...");
//		if (!addProcessActionSuccessMessage) {
//			addProcessActionSuccessMessage = true;
//			return;
//		}
//		SessionMessages.add(actionRequest, "success");
//	}
	
}
