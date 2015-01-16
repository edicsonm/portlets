package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.MerchantVO;

public class Methods {
	
	public static void orderMerchant(String campo, ArrayList<MerchantVO> list) {
		BeanComparator<MerchantVO> comparator= new BeanComparator<MerchantVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<MerchantVO> orderMerchant(ArrayList<MerchantVO> list, String orderByCol, String orderByType ) {
		BeanComparator<MerchantVO> comparator= new BeanComparator<MerchantVO>(orderByCol);
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
