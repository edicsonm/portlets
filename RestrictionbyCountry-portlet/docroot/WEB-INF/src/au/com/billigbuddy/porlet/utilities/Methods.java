package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.CountryRestrictionVO;;

public class Methods {
	
	public static void orderCountryRestriction(String campo, ArrayList<CountryRestrictionVO> list) {
		BeanComparator<CountryRestrictionVO> comparator= new BeanComparator<CountryRestrictionVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<CountryRestrictionVO> orderCountryRestriction(ArrayList<CountryRestrictionVO> list, String orderByCol, String orderByType ) {
		BeanComparator<CountryRestrictionVO> comparator= new BeanComparator<CountryRestrictionVO>(orderByCol);
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
