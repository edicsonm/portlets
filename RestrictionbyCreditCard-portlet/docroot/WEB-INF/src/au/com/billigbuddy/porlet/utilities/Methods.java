package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.CreditCardRestrictionVO;

public class Methods {
	
	public static void orderCreditCardRestriction(String campo, ArrayList<CreditCardRestrictionVO> list) {
		BeanComparator<CreditCardRestrictionVO> comparator= new BeanComparator<CreditCardRestrictionVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<CreditCardRestrictionVO> orderCreditCardRestriction(ArrayList<CreditCardRestrictionVO> list, String orderByCol, String orderByType ) {
		BeanComparator<CreditCardRestrictionVO> comparator= new BeanComparator<CreditCardRestrictionVO>(orderByCol);
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
