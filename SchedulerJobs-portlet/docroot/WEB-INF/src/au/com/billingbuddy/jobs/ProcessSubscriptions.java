package au.com.billingbuddy.jobs;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Set;

import au.com.billingbuddy.business.objects.ProcessSubscriptionFacade;
import au.com.billingbuddy.porlet.utilities.Methods;

import com.liferay.portal.kernel.messaging.Message;
import com.liferay.portal.kernel.messaging.MessageListener;
import com.liferay.portal.kernel.messaging.MessageListenerException;
import com.liferay.portal.kernel.notifications.BaseUserNotificationHandler;

public class ProcessSubscriptions extends BaseUserNotificationHandler implements MessageListener {

public static final String PORTLET_ID = "SchedulerJobs_WAR_SchedulerJobsportlet";
	
	private static ProcessSubscriptionFacade instance = ProcessSubscriptionFacade.getInstance();
	
	public ProcessSubscriptions() {
		setPortletId(MessageListenerDemo.PORTLET_ID);
	}

	@Override
	public void receive(Message message) throws MessageListenerException {
		System.out.println("1 Firing call ...." +Calendar.getInstance().getTime());
		/*Aca debe hacer el llamado a los metodos para la ejecucion de las subscriptiones*/
//		sendNotification(message.get("Has been created a new Job to execute the Subscriptions Process.").toString());
		Methods.sendNotification("Starting the Subscriptions Process execution at " + Calendar.getInstance().getTime());
		HashMap<String,String> resp = instance.executeSubscriptionsToProcess();
		if(resp != null){
			Set<String> set = resp.keySet();
			for (String key : set) {
				System.out.println(key+" --> "+resp.get(key));
			}
		}
		System.out.println("2 Firing call ...." +Calendar.getInstance().getTime());
		Methods.sendNotification("Finishing the Subscriptions Process execution at " + Calendar.getInstance().getTime());
//		Methods.sendNotification(message.get("Starting the Subscriptions Process execution.").toString());
//		Methods.sendNotification(message.get("Finishing the Subscriptions Process execution.").toString());
	} 
	
}
