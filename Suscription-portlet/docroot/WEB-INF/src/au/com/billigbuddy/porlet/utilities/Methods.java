package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.SubscriptionVO;;

public class Methods {
	
	public static void orderSubscriptions(String campo, ArrayList<SubscriptionVO> list) {
		BeanComparator<SubscriptionVO> comparator= new BeanComparator<SubscriptionVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<SubscriptionVO> orderSubscriptions(ArrayList<SubscriptionVO> list, String orderByCol, String orderByType ) {
		BeanComparator<SubscriptionVO> comparator= new BeanComparator<SubscriptionVO>(orderByCol);
		if(list != null){
			if(orderByType.equals("asc")){
				Collections.sort(list, comparator);
			}else{
				Collections.sort(list, comparator);
				Collections.reverse(list);
			}
		}
		return list;		
	}
}
