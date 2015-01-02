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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.business.objects.TransactionFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.ChargeVO;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormRefund extends MVCPortlet {
	private TransactionFacade transactionFacade  = TransactionFacade.getInstance();
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		System.out.println("Ejecuta doView");
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(renderResponse);
		HttpSession session = request.getSession();
		ArrayList<ChargeVO> listCharge = transactionFacade.listCharge(new ChargeVO());
		String accion = renderRequest.getParameter("accion");
		session.setAttribute("listCharge", listCharge);
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
	
	public void processRefund(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		ChargeVO chargeVO = (ChargeVO)session.getAttribute("chargeVO");
		try {
			procesorFacade.processRefund(chargeVO);
			if(chargeVO.getStatus().equalsIgnoreCase("success")){
//				SessionMessages.add(actionRequest, "paymentSuccessful", new Object[] { transactionVO.getId() });
				SessionMessages.add(actionRequest, "paymentSuccessful");
				session.setAttribute("transactionId", chargeVO.getId());
				actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
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
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);

			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			
			session.setAttribute("chargeVO", chargeVO);
			actionResponse.setRenderParameter("indice", (String)session.getAttribute("indice"));
			actionResponse.setRenderParameter("jspPage", "/jsp/refund.jsp");
			
		}
	}
	
	
}
