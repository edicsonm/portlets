package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.MerchantRestrictionVO;

public class Methods {
	
	public static void orderMerchantRestriction(String campo, ArrayList<MerchantRestrictionVO> list) {
		BeanComparator<MerchantRestrictionVO> comparator= new BeanComparator<MerchantRestrictionVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<MerchantRestrictionVO> orderMerchantRestriction(ArrayList<MerchantRestrictionVO> list, String orderByCol, String orderByType ) {
		BeanComparator<MerchantRestrictionVO> comparator= new BeanComparator<MerchantRestrictionVO>(orderByCol);
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
