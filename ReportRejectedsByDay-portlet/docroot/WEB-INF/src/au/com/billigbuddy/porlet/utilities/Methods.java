package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.TransactionVO;

public class Methods {
	
	public static void orderReportAmountByDay(String campo, ArrayList<TransactionVO> list) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<TransactionVO> orderReportAmountByDay(ArrayList<TransactionVO> list, String orderByCol, String orderByType ) {
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
