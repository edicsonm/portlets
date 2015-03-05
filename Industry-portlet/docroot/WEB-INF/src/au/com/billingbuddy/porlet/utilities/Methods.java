package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.IndustryVO;

public class Methods {
	
	public static void orderIndustry(String campo, ArrayList<IndustryVO> list) {
		BeanComparator<IndustryVO> comparator= new BeanComparator<IndustryVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<IndustryVO> orderIndustry(ArrayList<IndustryVO> list, String orderByCol, String orderByType ) {
		BeanComparator<IndustryVO> comparator= new BeanComparator<IndustryVO>(orderByCol);
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
