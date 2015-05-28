package au.com.billingbuddy.jobs;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import au.com.billingbuddy.business.objects.ProcessSubscriptionFacade;
import au.com.billingbuddy.porlet.utilities.Methods;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.messaging.Message;
import com.liferay.portal.kernel.messaging.MessageListener;
import com.liferay.portal.kernel.messaging.MessageListenerException;
import com.liferay.portal.kernel.notifications.BaseUserNotificationHandler;
import com.liferay.portal.model.Company;
import com.liferay.portal.model.Role;
import com.liferay.portal.model.User;
import com.liferay.portal.service.CompanyLocalServiceUtil;
import com.liferay.portal.service.RoleLocalServiceUtil;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.service.UserNotificationEventLocalServiceUtil;

public class ProcessSubscriptions extends BaseUserNotificationHandler implements MessageListener {

public static final String PORTLET_ID = "SchedulerJobs_WAR_SchedulerJobsportlet";
	
	private static ProcessSubscriptionFacade instance = ProcessSubscriptionFacade.getInstance();
	
	public ProcessSubscriptions() {
		setPortletId(MessageListenerDemo.PORTLET_ID);
	}

	@Override
	public void receive(Message message) throws MessageListenerException {
		/*Aca debe hacer el llamado a los metodos para la ejecucion de las subscriptiones*/
//		sendNotification(message.get("Has been created a new Job to execute the Subscriptions Process.").toString());
		Methods.sendNotification("Starting the Subscriptions Process execution at " + Calendar.getInstance().getTime());
		instance.executeSubscriptionsToProcess();
		Methods.sendNotification("Finishing the Subscriptions Process execution at " + Calendar.getInstance().getTime());
//		Methods.sendNotification(message.get("Starting the Subscriptions Process execution.").toString());
//		Methods.sendNotification(message.get("Finishing the Subscriptions Process execution.").toString());
	} 
	
}
