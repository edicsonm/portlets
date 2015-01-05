package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.ChargeVO;
import au.com.billingbuddy.vo.objects.RefundVO;

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
	
	public static void orderRefunds(String campo, ArrayList<RefundVO> lista) {
		BeanComparator<RefundVO> comparator= new BeanComparator<RefundVO>(campo);
		Collections.sort(lista, comparator);
	}
	
	public static ArrayList<RefundVO> orderRefunds(ArrayList<RefundVO> listaRefunds, String orderByCol, String orderByType ) {
		BeanComparator<RefundVO> comparator= new BeanComparator<RefundVO>(orderByCol);
		if(listaRefunds != null){
			if(orderByType.equals("asc")){
				Collections.sort(listaRefunds, comparator);
			}else{
				Collections.sort(listaRefunds, comparator);
				Collections.reverse(listaRefunds);
			}
		}
		return listaRefunds;		
	}
	
}
