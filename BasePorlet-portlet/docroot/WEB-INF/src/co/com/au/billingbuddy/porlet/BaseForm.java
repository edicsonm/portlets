package co.com.au.billingbuddy.porlet;

import java.io.IOException;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class BaseForm extends MVCPortlet {
	
	public void addInformation(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		addProcessActionSuccessMessage = false;
		actionResponse.setRenderParameter("jspPage", "/jsp/add.jsp");
	}
	
public void saveInformation(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		try{
			int status = 1;
//			RazaVO razaVO = new RazaVO();
//			razaVO.setNombre(request.getParameter("nombre"));
//			razaVO.setDescripcion(request.getParameter("descripcion"));
//			RazaMDTR razaMDTR = new RazaMDTR();
//			razaMDTR.Registrar(razaVO);
			if(status == 1){
				SessionMessages.add(actionRequest, "successAgregar");
				actionResponse.setRenderParameter("jspPage", "/jsp/add.jsp");
			}else{
				PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(actionRequest, "error");
				SessionErrors.add(actionRequest,"Aca te envio un mensaje de error");
//				session.setAttribute("razaVO", razaVO);
				actionResponse.setRenderParameter("jspPage", "/jsp/agregar.jsp");
			}
		}catch(Exception e){
			e.printStackTrace();
			SessionErrors.add(actionRequest, "error");
		}
	}
	
	
}
