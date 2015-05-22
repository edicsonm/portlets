package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.AdministrationFacade;
import au.com.billingbuddy.exceptions.objects.AdministrationFacadeException;
import au.com.billingbuddy.vo.objects.SubmittedProcessLogVO;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormSubscriptions extends MVCPortlet {
	
	private AdministrationFacade administrationFacade = AdministrationFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			ArrayList<SubmittedProcessLogVO> listSubmittedProcessLogs = administrationFacade.listSubmittedProcessLogs(new SubmittedProcessLogVO());
			session.setAttribute("listSubmittedProcessLogs", listSubmittedProcessLogs);
		} catch (AdministrationFacadeException e) {
			PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(renderRequest,e.getErrorCode());
		}
		super.doView(renderRequest, renderResponse);
	}
	
	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(resourceResponse);
		HttpSession session = request.getSession();
		
		/*System.out.println("Llamando para ejecutar Ajax ... " + resourceRequest.getParameter("errorFileLocation"));
		System.out.println("Llamando para ejecutar Ajax ... " + resourceRequest.getParameter("idSubmittedProcessLog"));*/
		
		SubmittedProcessLogVO submittedProcessLogVO = new SubmittedProcessLogVO();
		submittedProcessLogVO.setId(resourceRequest.getParameter("idSubmittedProcessLog"));
		
		ArrayList<SubmittedProcessLogVO> listSubmittedProcessLogs = (ArrayList<SubmittedProcessLogVO>)session.getAttribute("listSubmittedProcessLogs");
		int indiceSubmittedProcessLog = listSubmittedProcessLogs.indexOf(submittedProcessLogVO);
		submittedProcessLogVO = (SubmittedProcessLogVO)listSubmittedProcessLogs.get(indiceSubmittedProcessLog);
		submittedProcessLogVO.setFile(resourceRequest.getParameter("errorFileLocation"));
		
		resourceResponse.setContentType("application/json");
		PrintWriter writer = resourceResponse.getWriter();
		org.json.simple.JSONObject jSONObjectParameters = new org.json.simple.JSONObject();
		try {
			jSONObjectParameters.put("fileName", resourceRequest.getParameter("errorFileLocation"));
			jSONObjectParameters.put("idSubmittedProcessLog", resourceRequest.getParameter("idSubmittedProcessLog"));
			jSONObjectParameters = administrationFacade.reprocessErrorFile(jSONObjectParameters);
			System.out.println("answer --->"+ jSONObjectParameters.get("answer"));
			boolean answer = (jSONObjectParameters.get("answer") != null && jSONObjectParameters.get("answer").toString().equalsIgnoreCase("true") ? true : false );
			System.out.println("answer en la clase " + answer);
			if(answer){
				jSONObjectParameters.put("answer", true);
			}else{
				jSONObjectParameters.put("answer", false);
			}
		} catch (AdministrationFacadeException e) {
			jSONObjectParameters.put("answer", false);
			jSONObjectParameters.put("detail", e.getMessage());
		}
		writer.write(jSONObjectParameters.toString());
		writer.flush();
        writer.close();
	}
	
}

