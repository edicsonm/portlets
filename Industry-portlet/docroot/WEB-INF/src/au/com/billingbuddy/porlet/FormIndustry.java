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
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.IndustryVO;
import au.com.billingbuddy.vo.objects.PlanVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormIndustry extends MVCPortlet {
	
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			ArrayList<IndustryVO> listIndustries = procesorFacade.listIndustries();
			session.setAttribute("listIndustries", listIndustries);
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

	public void saveIndustry(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		IndustryVO industryVO = new IndustryVO();
		industryVO.setDescription(actionRequest.getParameter("description"));
		try {
			procesorFacade.saveIndustry(industryVO);
			if(industryVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<IndustryVO> listIndustries = procesorFacade.listIndustries();
				session.setAttribute("listIndustries", listIndustries);
				SessionMessages.add(actionRequest, "industrySavedSuccessfully");
				session.removeAttribute("industryVO");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				System.out.println("planVO.getMessage(): " + industryVO.getMessage());
				SessionErrors.add(actionRequest,industryVO.getMessage());
				session.setAttribute("industryVO", industryVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newIndustry.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("industryVO", industryVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newIndustry.jsp");
		}
	}
	
	public void editIndustry(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		IndustryVO industryVO = (IndustryVO)session.getAttribute("industryVO");
		industryVO.setDescription(actionRequest.getParameter("description"));
		try {
			procesorFacade.updateIndustry(industryVO);
			if(industryVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<IndustryVO> listIndustries = procesorFacade.listIndustries();
				session.setAttribute("listIndustries", listIndustries);
				SessionMessages.add(actionRequest, "industryUpdatedSuccessfully");
				session.removeAttribute("industryVO");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,industryVO.getMessage());
				session.setAttribute("industryVO", industryVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editIndustry.jsp");
				actionResponse.setRenderParameter("indiceIndustry", (String)session.getAttribute("indiceIndustry"));
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("industryVO", industryVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editIndustry.jsp");
			actionResponse.setRenderParameter("indiceIndustry", (String)session.getAttribute("indiceIndustry"));
		}
	}
	
	public void inactivateIndustry(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		String indice = actionRequest.getParameter("indiceIndustry");
		ArrayList<IndustryVO> resultsListCharge = (ArrayList<IndustryVO>)session.getAttribute("results");
		IndustryVO industryVO = (IndustryVO)resultsListCharge.get(Integer.parseInt(indice));
		industryVO.setStatus(industryVO.getStatus().equalsIgnoreCase("0")?"1":"0");
		String status = industryVO.getStatus();
		try {
			procesorFacade.updateIndustry(industryVO);
			if(industryVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<IndustryVO> listIndustries = procesorFacade.listIndustries();
				session.setAttribute("listIndustries", listIndustries);
				if(status.equalsIgnoreCase("0")){
					SessionMessages.add(actionRequest, "industryActivateSuccessfully");
				}else{
					SessionMessages.add(actionRequest, "industryInactivateSuccessfully");
				}
				session.removeAttribute("industryVO");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,industryVO.getMessage());
				session.setAttribute("industryVO", industryVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/viewIndustry.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("industryVO", industryVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/viewIndustry.jsp");
		}
	}
	
}

