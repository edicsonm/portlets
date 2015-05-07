package com.meera.alloyui.dialog;

import java.io.IOException;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;

import com.liferay.util.bridges.mvc.MVCPortlet;

/**
 * Portlet implementation class AlloyuiDialogAction
 */
public class AlloyuiDialogAction extends MVCPortlet {
	
	public void getActionMessage( ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		System.out.println("====getActionMessage===");
		actionResponse.setRenderParameter("mvcPath", "/html/alloyuidialog/iframe_alloyui_dialog_example.jsp");
		actionResponse.setRenderParameter("message", "Hi you have performed ACTION REQUEST in iframe dialog.. thenk you..");
	}
	
	public void getActionMessageForSimpleDialog(
			ActionRequest actionRequest, ActionResponse actionResponse)
		throws IOException, PortletException {
		System.out.println("====getActionMessageForSimpleDialog===");
		actionResponse.setRenderParameter("mvcPath", "/html/alloyuidialog/simple_alloyui_dialog_example.jsp");
		actionResponse.setRenderParameter("message", "Hi you have performed ACTION REQUEST in simple dialog.but you lost dialog..");
	}

}
