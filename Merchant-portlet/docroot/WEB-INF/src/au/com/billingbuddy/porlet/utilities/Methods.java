package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.MerchantVO;

public class Methods {
	
	public static void orderMerchant(String campo, ArrayList list) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList orderMerchant(ArrayList list, String orderByCol, String orderByType ) {
		BeanComparator comparator= new BeanComparator(orderByCol);
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
