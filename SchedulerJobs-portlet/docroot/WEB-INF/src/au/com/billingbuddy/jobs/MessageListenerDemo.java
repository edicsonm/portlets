package au.com.billingbuddy.jobs;

import java.util.Map;

import com.liferay.portal.kernel.messaging.Message;
import com.liferay.portal.kernel.messaging.MessageListener;
import com.liferay.portal.kernel.messaging.MessageListenerException;

public class MessageListenerDemo implements MessageListener {

	@Override
	public void receive(Message message) throws MessageListenerException {
		System.out.println("This is a simple scheduler class");
//		Map<String, Object> map = message.getValues();
//		for (Map.Entry<String, Object> entry : map.entrySet()){
//		
//		    System.out.println(entry.getKey() + " / " + entry.getValue()+ " / " + entry.getClass());
//		 
//		}
	}

}
