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
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.BusinessTypeVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormBusinessType extends MVCPortlet {
	
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			ArrayList<BusinessTypeVO> listBusinessTypes = procesorFacade.listBusinessTypes();
			session.setAttribute("listBusinessTypes", listBusinessTypes);
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

	public void saveBusinessType(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		BusinessTypeVO businessTypeVO = new BusinessTypeVO();
		businessTypeVO.setDescription(actionRequest.getParameter("description"));
		try {
			procesorFacade.saveBusinessType(businessTypeVO);
			if(businessTypeVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<BusinessTypeVO> listBusinessTypes = procesorFacade.listBusinessTypes();
				session.setAttribute("listBusinessTypes", listBusinessTypes);
				SessionMessages.add(actionRequest, "businessTypeSavedSuccessfully");
				session.removeAttribute("businessTypeVO");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,businessTypeVO.getMessage());
				session.setAttribute("businessTypeVO", businessTypeVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/newBusinessType.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("businessTypeVO", businessTypeVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/newBusinessType.jsp");
		}
	}
	
	public void editBusinessType(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		BusinessTypeVO businessTypeVO = (BusinessTypeVO)session.getAttribute("businessTypeVO");
		businessTypeVO.setDescription(actionRequest.getParameter("description"));
		try {
			procesorFacade.updateBusinessType(businessTypeVO);
			if(businessTypeVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<BusinessTypeVO> listBusinessTypes = procesorFacade.listBusinessTypes();
				session.setAttribute("listBusinessTypes", listBusinessTypes);
				SessionMessages.add(actionRequest, "businessTypeUpdatedSuccessfully");
				session.removeAttribute("businessTypeVO");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,businessTypeVO.getMessage());
				session.setAttribute("businessTypeVO", businessTypeVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/editBusinessType.jsp");
				actionResponse.setRenderParameter("indiceBusinessType", (String)session.getAttribute("indiceBusinessType"));
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("businessTypeVO", businessTypeVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/editBusinessType.jsp");
			actionResponse.setRenderParameter("indiceBusinessType", (String)session.getAttribute("indiceBusinessType"));
		}
	}
	
	public void inactivateBusinessType(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		String indice = actionRequest.getParameter("indiceBusinessType");
		ArrayList<BusinessTypeVO> resultsListCharge = (ArrayList<BusinessTypeVO>)session.getAttribute("results");
		BusinessTypeVO businessTypeVO = (BusinessTypeVO)resultsListCharge.get(Integer.parseInt(indice));
		businessTypeVO.setStatus(businessTypeVO.getStatus().equalsIgnoreCase("0")?"1":"0");
		String status = businessTypeVO.getStatus();
		try {
			procesorFacade.updateBusinessType(businessTypeVO);
			if(businessTypeVO.getStatus().equalsIgnoreCase("success")) {
				ArrayList<BusinessTypeVO> listBusinessTypes = procesorFacade.listBusinessTypes();
				session.setAttribute("listBusinessTypes", listBusinessTypes);
				if(status.equalsIgnoreCase("0")){
					SessionMessages.add(actionRequest, "businessTypeActivateSuccessfully");
				}else{
					SessionMessages.add(actionRequest, "businessTypeInactivateSuccessfully");
				}
				session.removeAttribute("businessTypeVO");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,businessTypeVO.getMessage());
				session.setAttribute("businessTypeVO", businessTypeVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/viewBusinessType.jsp");
			}
		} catch (ProcesorFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest,e.getErrorCode());
			System.out.println("e.getMessage(): " + e.getMessage());
			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
			System.out.println("e.getErrorCode(): " + e.getErrorCode());
			session.setAttribute("businessTypeVO", businessTypeVO);
			actionResponse.setRenderParameter("jspPage", "/jsp/viewBusinessType.jsp");
		}
	}
	
}

