package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.BusinessTypeVO;;

public class Methods {
	
	public static void orderBusinessType(String campo, ArrayList<BusinessTypeVO> list) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<BusinessTypeVO> orderBusinessType(ArrayList<BusinessTypeVO> list, String orderByCol, String orderByType ) {
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
