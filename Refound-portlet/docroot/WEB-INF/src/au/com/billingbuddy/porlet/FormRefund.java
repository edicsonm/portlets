package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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
import au.com.billingbuddy.business.objects.TransactionFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.ChargeVO;
import au.com.billingbuddy.vo.objects.RefundVO;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.Http.Response;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;
import com.liferay.util.json.JSONFactoryUtil;

public class FormRefund extends MVCPortlet {
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		try {
			System.out.println("Ejecuta doView");
			HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
			HttpServletResponse response = PortalUtil.getHttpServletResponse(renderResponse);
			
			HttpSession session = request.getSession();
			ArrayList<ChargeVO> listCharge;
		
			listCharge = procesorFacade.listCharge(new ChargeVO());
		
			session.setAttribute("listCharge", listCharge);
			
	//		String page = (String)session.getAttribute("page");
	//		System.out.println("page: " + page);
	//		session.removeAttribute("page");
	//		if(page == null || page.equalsIgnoreCase("view.jsp")){
	//			ArrayList<ChargeVO> listCharge = transactionFacade.listCharge(new ChargeVO());
	//			session.setAttribute("listCharge", listCharge);
	//			include("/jsp/view.jsp", renderRequest, renderResponse);
	//		} else {
	//			PortletPreferences prefs = renderRequest.getPreferences();
	//			prefs.setValue("greeting", "indiceindiceindice");
	//	        prefs.store();
	//			include("/jsp/refund.jsp", renderRequest, renderResponse);
	//		}
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(renderRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
//			renderRequest.setRenderParameter("jspPage", "/jsp/view.jsp");
		}
		super.doView(renderRequest, renderResponse);
	}
	
	public void showDetails(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		System.out.println("Ejecuta showDetails");
//		System.out.println("Ejecuta showDetails ...");
//		String id = actionRequest.getParameter("id");
//		String jspPage = actionRequest.getParameter("jspPage");
//		System.out.println("id: " + id);
//		System.out.println("jspPage: " + jspPage);
//		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
//		HttpSession session = request.getSession();
//		actionResponse.setRenderParameter("jspPage", jspPage);
//		super.processAction(actionRequest, actionResponse);
	}
	
	public void listRefund(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		String indice = actionRequest.getParameter("indice");
		ArrayList<ChargeVO> resultsListCharge = (ArrayList<ChargeVO>)session.getAttribute("results");
		ChargeVO chargeVO = (ChargeVO)resultsListCharge.get(Integer.parseInt(indice));
		session.setAttribute("chargeVO", chargeVO);
		
		RefundVO refundVO = new RefundVO();
		refundVO.setId(chargeVO.getId());
		ArrayList<RefundVO> listRefunds = null;
		try {
			listRefunds = procesorFacade.listRefunds(refundVO);
			session.setAttribute("listRefunds", listRefunds);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
			
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
		}
		actionResponse.setRenderParameter("jspPage", "/jsp/refund.jsp");
	}
	
	public void processRefund(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		ChargeVO chargeVO = (ChargeVO)session.getAttribute("chargeVO");
		chargeVO.setRefundVO(new RefundVO());
		chargeVO.getRefundVO().setReason(actionRequest.getParameter("reason"));
		chargeVO.getRefundVO().setAmount(actionRequest.getParameter("refundAmount"));
		chargeVO.getRefundVO().setTransactionId(chargeVO.getTransactionId());
		try {
			procesorFacade.processRefund(chargeVO);
			if(chargeVO.getStatus().equalsIgnoreCase("success")) {
				RefundVO refundVO = new RefundVO();
				refundVO.setId(chargeVO.getId());
				ArrayList<RefundVO> listRefunds = null;
				try {
					listRefunds = procesorFacade.listRefunds(refundVO);
					session.setAttribute("listRefunds", listRefunds);
				} catch (ProcesorFacadeException e) {
					e.printStackTrace();
				}
				
//				SessionMessages.add(actionRequest, "paymentSuccessful", new Object[] { transactionVO.getId() });
				SessionMessages.add(actionRequest, "refundSuccessful");
				session.setAttribute("transactionId", chargeVO.getId());
//				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
				actionResponse.setRenderParameter("jspPage", "/jsp/refund.jsp");
			}else{
				System.out.println("basicPaymentResponseModel.getMessage(): " + chargeVO.getMessage());
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("chargeVO.getMessage(): " + chargeVO.getMessage());
				SessionErrors.add(actionRequest,chargeVO.getMessage());
				session.setAttribute("chargeVO", chargeVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/refund.jsp");
			}
		} catch (ProcesorFacadeException e) {
			
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);

			SessionErrors.add(actionRequest,e.getErrorCode());
			
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			
			session.setAttribute("chargeVO", chargeVO);
//			actionResponse.setRenderParameter("indice", (String)session.getAttribute("indice"));
			actionResponse.setRenderParameter("jspPage", "/jsp/refund.jsp");
		}
	}

	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpSession session = request.getSession();
		String salida1 = "<label class='aui-field-label'><fmt:message key='label.refunded'/></label>";
		String salida2 = "<span class='red'>Hello <b>Again 222 </b></span>";
		String salida3 = "<%@ include file='refunds.jsp'%>";
		System.out.println("Executing serveResource ....");
		String orderNumber = resourceRequest.getParameter("orderNumber");
		System.out.println("orderNumber: " + resourceRequest.getParameter("orderNumber"));
		System.out.println("orderNumber: " + resourceRequest.getAttribute("orderNumber"));
		RefundVO refundVO = new RefundVO();
		orderNumber = "40";
		refundVO.setId(orderNumber);
		ArrayList<RefundVO> listRefunds;
		try {
			listRefunds = procesorFacade.listRefunds(refundVO);
			resourceResponse.setContentType("text/html");
			PrintWriter writer = resourceResponse.getWriter();
			JSONObject jsonObject = new JSONObject();
	        jsonObject.put("listRefundsSize", listRefunds.size());
//			writer.print(jsonObject.toString());
			writer.print("Finish");
	        writer.flush();
	        writer.close();
			session.setAttribute("listRefunds", listRefunds);
			
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
		}
		
//		resourceResponse.setContentType("text/html");
//		PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/jsp/refunds.jsp");
//		dispatcher.include(resourceRequest, resourceResponse);
//		
//		getPortletContext().getRequestDispatcher("myMainJSP.jsp").include(request, resourceResponse);
//		resourceResponse.setContentType("application/json");
		
//		resourceResponse.setContentType("text/html");
//		PrintWriter writer = resourceResponse.getWriter();
//		JSONObject jsonObject = new JSONObject();
//		jsonObject.put("key", "value");
//		resourceResponse.getWriter().write(jsonObject.toString());
		
//		String countryId= ParamUtil.getString(resourceRequest, "orderNumber");
//		JSONObject jsonObject = new JSONObject();
//		String statesStr = "1213";
//		jsonObject.put("statesStr ", statesStr );
//		PrintWriter writer = resourceResponse.getWriter();
//		writer.write(jsonObject.toString());
		
//		resourceResponse.setContentType("text/html");
//        PrintWriter writer = resourceResponse.getWriter();
//        JSONObject jsonObject = new JSONObject();
//        jsonObject.put("fullName", "Matches email id. The full name of the user: Edicson");
//        writer.print(jsonObject.toString());
//        writer.flush();
//        writer.close();
//		super.serveResource(resourceRequest, resourceResponse);
	}

	@Override
	public void doEdit(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("Ejecuta doEdit");
		super.doEdit(renderRequest, renderResponse);
	}

	@Override
	public void doHelp(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("Ejecuta doHelp");
		super.doHelp(renderRequest, renderResponse);
	}

	@Override
	public void doPreview(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("Ejecuta doPreview");
		super.doPreview(renderRequest, renderResponse);
	}

	@Override
	public void doPrint(RenderRequest renderRequest,
			RenderResponse renderResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		System.out.println("Ejecuta doPrint");
		super.doPrint(renderRequest, renderResponse);
	}

	@Override
	public void processAction(ActionRequest actionRequest,
			ActionResponse actionResponse) throws IOException, PortletException {
		// TODO Auto-generated method stub
		super.processAction(actionRequest, actionResponse);
	}

	public void renderqwqwe(RenderRequest request, RenderResponse response) throws PortletException, IOException {
		System.out.println("Ejecuta render");
		HttpServletRequest httpServletRequest = PortalUtil.getHttpServletRequest(request);
		HttpSession session = httpServletRequest.getSession();
//		if(httpServletRequest.getParameter("indice") != null){
//			PortletPreferences prefs = request.getPreferences();
//			prefs.setValue("indice", httpServletRequest.getParameter("indice"));
//	        prefs.store();
//		}
//		System.out.println("1 - " + httpServletRequest.getParameter("orderNumber"));
//		System.out.println("2 - " + httpServletRequest.getAttribute("orderNumber"));
//		
//		System.out.println("3 - " + request.getParameter("orderNumber"));
//		System.out.println("4 - " + request.getAttribute("orderNumber"));
		
		String orderNumber = httpServletRequest.getParameter("orderNumber");
		if(orderNumber != null){
			RefundVO refundVO = new RefundVO();
			refundVO.setId(orderNumber!= null ? orderNumber :  (String)session.getAttribute("orderNumber"));
			System.out.println("refundVO.getId(): " + refundVO.getId());
			ArrayList<RefundVO> listRefunds;
			try {
				listRefunds = procesorFacade.listRefunds(refundVO);
				session.setAttribute("listRefunds", listRefunds);
			} catch (ProcesorFacadeException e) {
				e.printStackTrace();
			}
		}else{
			
		}
			
		super.render(request, response);
	}
	
}

