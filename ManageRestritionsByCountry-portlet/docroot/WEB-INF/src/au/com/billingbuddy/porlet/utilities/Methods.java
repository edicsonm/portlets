package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.CountryBlockListVO;

public class Methods {
	
	public static void orderCountryBlockList(String campo, ArrayList<CountryBlockListVO> list) {
		BeanComparator<CountryBlockListVO> comparator= new BeanComparator<CountryBlockListVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<CountryBlockListVO> orderCountryBlockList(ArrayList<CountryBlockListVO> list, String orderByCol, String orderByType ) {
		BeanComparator<CountryBlockListVO> comparator= new BeanComparator<CountryBlockListVO>(orderByCol);
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
