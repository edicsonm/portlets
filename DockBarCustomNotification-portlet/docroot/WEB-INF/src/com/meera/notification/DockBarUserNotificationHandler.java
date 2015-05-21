package com.meera.notification;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.notifications.BaseUserNotificationHandler;
import com.liferay.portal.kernel.util.StringBundler;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.model.UserNotificationEvent;
import com.liferay.portal.service.ServiceContext;

public class DockBarUserNotificationHandler extends BaseUserNotificationHandler {
	
	public static final String PORTLET_ID = "dockbarnotificationaction_WAR_DockBarCustomNotificationportlet";

	public DockBarUserNotificationHandler() {
		setPortletId(DockBarUserNotificationHandler.PORTLET_ID);
	}
	
	@Override
	protected String getBody(UserNotificationEvent userNotificationEvent, ServiceContext serviceContext) throws Exception {
		JSONObject jsonObject = JSONFactoryUtil.createJSONObject(userNotificationEvent.getPayload());
		//long userId = jsonObject.getLong("userId");
		String notificationText=jsonObject.getString("notificationText");
		String title = "<strong>Dockbar Custom User Notification for You</strong>";
		String body = StringUtil.replace(getBodyTemplate(), new String[] {
				"[$TITLE$]", "[$BODY_TEXT$]" },
				new String[] { title, notificationText });
		System.out.println("=========1111111==========");
		return body;
	}
	
	protected String getBodyTemplate() throws Exception {
		StringBundler sb = new StringBundler(5);
		sb.append("<div class=\"title\">[$TITLE$]</div><div ");
		sb.append("class=\"body\">[$BODY_TEXT$]</div>");
		return sb.toString();
	}
}