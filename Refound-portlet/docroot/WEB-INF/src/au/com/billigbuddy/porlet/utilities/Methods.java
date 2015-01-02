package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.ChargeVO;

public class Methods {
	
	public static void orderTransactions(String campo, ArrayList<ChargeVO> lista) {
		BeanComparator<ChargeVO> comparator= new BeanComparator<ChargeVO>(campo);
		Collections.sort(lista, comparator);
	}
	
	public static ArrayList<ChargeVO> orderCharges(ArrayList<ChargeVO> lista, String orderByCol, String orderByType ) {
		BeanComparator<ChargeVO> comparator= new BeanComparator<ChargeVO>(orderByCol);
		if(lista != null){
			if(orderByType.equals("asc")){
				Collections.sort(lista, comparator);
			}else{
				Collections.sort(lista, comparator);
				Collections.reverse(lista);
			}
		}
		return lista;		
	}
	
}
