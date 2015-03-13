package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.TransactionVO;

public class Methods {
	
	public static void orderTransactions(String campo, ArrayList<TransactionVO> lista) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(lista, comparator);
	}
	
	public static ArrayList<TransactionVO> orderTransactions(ArrayList<TransactionVO> lista, String orderByCol, String orderByType ) {
		BeanComparator comparator= new BeanComparator(orderByCol);
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
