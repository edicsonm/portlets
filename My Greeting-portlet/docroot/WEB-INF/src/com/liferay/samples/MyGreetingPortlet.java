package com.liferay.samples;

import java.io.IOException;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;

import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.util.bridges.mvc.MVCPortlet;


public class MyGreetingPortlet extends MVCPortlet {

	@Override
	public void processAction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		PortletPreferences prefs = actionRequest.getPreferences();
		String greeting = actionRequest.getParameter("greeting");
		if (greeting != null) {
			prefs.setValue("greeting", greeting);
			prefs.store();
		}
		SessionMessages.add(actionRequest, "success");
		actionResponse.setRenderParameter("jspPage", "/view.jsp");
//		super.processAction(actionRequest, actionResponse);
	}

}