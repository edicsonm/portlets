package au.com.billingbuddy.jobs;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.messaging.Message;
import com.liferay.portal.kernel.messaging.MessageListener;
import com.liferay.portal.kernel.messaging.MessageListenerException;
import com.liferay.portal.kernel.notifications.BaseUserNotificationHandler;
import com.liferay.portal.kernel.notifications.ChannelHubManagerUtil;
import com.liferay.portal.kernel.notifications.NotificationEvent;
import com.liferay.portal.kernel.notifications.NotificationEventFactoryUtil;
import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PropsKeys;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.StringBundler;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.model.Company;
import com.liferay.portal.model.Group;
import com.liferay.portal.model.Role;
import com.liferay.portal.model.User;
import com.liferay.portal.model.UserGroupGroupRole;
import com.liferay.portal.model.UserNotificationEvent;
import com.liferay.portal.service.CompanyLocalServiceUtil;
import com.liferay.portal.service.GroupLocalServiceUtil;
import com.liferay.portal.service.RoleLocalServiceUtil;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.service.ServiceContextFactory;
import com.liferay.portal.service.ServiceContextThreadLocal;
import com.liferay.portal.service.UserGroupGroupRoleLocalServiceUtil;
import com.liferay.portal.service.UserGroupLocalService;
import com.liferay.portal.service.UserGroupLocalServiceUtil;
import com.liferay.portal.service.UserGroupService;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.service.UserNotificationEventLocalServiceUtil;
import com.liferay.portal.service.persistence.UserGroupGroupRoleUtil;
import com.liferay.portal.theme.ThemeDisplay;

public class MessageListenerDemo extends BaseUserNotificationHandler implements MessageListener {
	
	public static final String PORTLET_ID = "SchedulerJobs_WAR_SchedulerJobsportlet";

	public MessageListenerDemo() {
		setPortletId(MessageListenerDemo.PORTLET_ID);
	}
	
	@Override
	public void receive(Message message) throws MessageListenerException {
//		System.out.println("This is a simple scheduler class");
//		setPortletId(message.get("PORTLET_ID").toString());
//		System.out.println(message.get("PORTLET_ID").toString());
//		Map<String, Object> map = message.getValues();
//		for (Map.Entry<String, Object> entry : map.entrySet()){
//		    System.out.println(entry.getKey() + " / " + entry.getValue()+ " / " + entry.getClass());
//		}
		try {
			Company company = CompanyLocalServiceUtil.getCompanyByMx("billingbuddy.com");
			Role role = RoleLocalServiceUtil.getRole(company.getCompanyId(), "BillingBuddyAdministrator");
			List<User> users = UserLocalServiceUtil.getRoleUsers(role.getRoleId());
			
//			ServiceContext serviceContext = ServiceContextFactory.getInstance(actionRequest);
//			String notificationText = ParamUtil.getString(actionRequest, "notifciationText");
//			ServiceContext serviceContext = ServiceContextThreadLocal.getServiceContext();
//			System.out.println("serviceContext: " + serviceContext);
			String notificationText = "Aca voy yo ...";
			for (User user : users) {
				JSONObject payloadJSON = JSONFactoryUtil.createJSONObject();
				
				payloadJSON.put("userId", user.getUserId());
				payloadJSON.put("notificationText", notificationText);
//				
//				 NotificationEvent notificationEvent = NotificationEventFactoryUtil.createNotificationEvent(System.currentTimeMillis(),
//                                      "6_WAR_soportlet",                         
//                                      payloadJSON);
//
//				 notificationEvent.setDeliveryRequired(0);
//
//				 ChannelHubManagerUtil.sendNotificationEvent(user.getCompanyId(),  user.getUserId(), notificationEvent);
				
				ServiceContext serviceContext = new ServiceContext();
				serviceContext.setScopeGroupId(user.getGroupId());
				System.out.println("user.getGroupId(): " + user.getGroupId());
				UserNotificationEventLocalServiceUtil.addUserNotificationEvent(
						user.getUserId(),
						MessageListenerDemo.PORTLET_ID,
						(new Date()).getTime(), user.getUserId(),
						payloadJSON.toString(), false, serviceContext);
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		
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
