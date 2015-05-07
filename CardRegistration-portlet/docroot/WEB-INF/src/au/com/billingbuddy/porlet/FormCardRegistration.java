package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.vo.TimeVO;
import au.com.billingbuddy.vo.objects.CertificateVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormCardRegistration extends MVCPortlet {
	
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();

	/*@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		ArrayList<String> listaHoras = (ArrayList<String>)session.getAttribute("listaHoras");
		session.setAttribute("listaHoras", listaHoras);
	}*/

	public void saveCard(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		System.out.println("name: " + actionRequest.getParameter("name"));
		if(actionRequest.getParameter("name").equalsIgnoreCase("si")){
			SessionMessages.add(actionRequest, "CardCreatedSuccessfully");
			session.setAttribute("answer","true");
		}else{
			SessionErrors.add(actionRequest,"ErrorCreatingCard");
			session.setAttribute("answer","false");
			SessionMessages.add(actionRequest, PortalUtil.getPortletId(actionRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
		}
		
		actionResponse.setRenderParameter("mvcPath", "/jsp/newCard.jsp");
		actionResponse.setRenderParameter("message", "Hi you have performed ACTION REQUEST in iframe dialog.. thenk you..");
		
//		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
		/*super.processAction(actionRequest, actionResponse);*/
	}
	
	public void getActionMessage( ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		System.out.println("====getActionMessage===");
		actionResponse.setRenderParameter("mvcPath", "/jsp/newCard.jsp");
		actionResponse.setRenderParameter("message", "Hi you have performed ACTION REQUEST in iframe dialog.. thenk you..");
	}

	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpSession session = request.getSession();
		ArrayList<TimeVO> listaHoras = (ArrayList<TimeVO>)session.getAttribute("listaHoras");
		
		if(listaHoras == null){
			listaHoras = new ArrayList<TimeVO>();
		}
		TimeVO timeVO = new TimeVO();
		timeVO.setTime(Calendar.getInstance().getTime().toString());
		listaHoras.add(timeVO);
		session.setAttribute("listaHoras", listaHoras);
		
		System.out.println("====serveResource===");
		include("/jsp/time.jsp", resourceRequest, resourceResponse, PortletRequest.RESOURCE_PHASE);
		/*super.serveResource(resourceRequest, resourceResponse);*/
	}
	
}

