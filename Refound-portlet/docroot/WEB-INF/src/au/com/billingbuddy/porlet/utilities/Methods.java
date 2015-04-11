package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;

import javax.portlet.ActionRequest;
import javax.portlet.RenderRequest;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.ChargeVO;
import au.com.billingbuddy.vo.objects.RefundVO;
import au.com.billingbuddy.vo.objects.TransactionVO;

public class Methods {
	
	public static void orderTransactions(String campo, ArrayList<ChargeVO> lista) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(lista, comparator);
	}
	
	public static ArrayList<ChargeVO> orderCharges(ArrayList<ChargeVO> list, String orderByCol, String orderByType ) {
		if(orderByCol.equalsIgnoreCase("amount")){
			if(list != null){
				if(orderByType.equals("asc")){
					Collections.sort(list, new SortListByAmount());
				}else{
					Collections.sort(list, new SortListByAmount());
					Collections.reverse(list);
				}
			}
		}else if(orderByCol.equalsIgnoreCase("cardVO.brand")){
			if(list != null){
				if(orderByType.equals("asc")){
					Collections.sort(list, new SortListByBrand());
					
				}else{
					Collections.sort(list, new SortListByBrand());
					Collections.reverse(list);
				}
			}
		}else{
			BeanComparator beanComparator= new BeanComparator(orderByCol);
			if(list != null){
				if(orderByType.equals("asc")){
					Collections.sort(list, beanComparator);
				}else{
					Collections.sort(list, beanComparator);
					Collections.reverse(list);
				}
			}
		}
		return list;		
	}
	
	public static void orderRefunds(String campo, ArrayList<RefundVO> lista) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(lista, comparator);
	}
	
	public static ArrayList<RefundVO> orderRefunds(ArrayList<RefundVO> listaRefunds, String orderByCol, String orderByType ) {
		BeanComparator comparator= new BeanComparator(orderByCol);
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
	
	public static void printParameters(ActionRequest actionRequest) {
		Enumeration<String> enume = actionRequest.getParameterNames();
		while (enume.hasMoreElements()){
			String valor = enume.nextElement();
			System.out.println("Parametro: " + valor + "-->"+ actionRequest.getParameter(valor));
		}
	}
	
	public static void printParameters(RenderRequest renderRequest) {
		Enumeration<String> enume = renderRequest.getParameterNames();
		while (enume.hasMoreElements()){
			String valor = enume.nextElement();
			System.out.println("Parametro: " + valor + "-->"+ renderRequest.getParameter(valor));
		}
	}
	
	static class  SortListByAmount implements Comparator<ChargeVO>{
		public int compare(ChargeVO chargeVOA, ChargeVO chargeVOB) {
			return Double.parseDouble(chargeVOA.getAmount()) < Double.parseDouble(chargeVOB.getAmount()) ? -1 : Double.parseDouble(chargeVOA.getAmount()) == Double.parseDouble(chargeVOB.getAmount()) ? 0 : 1;
		}
	}
	
	static class SortListByBrand implements Comparator<ChargeVO>{
		public int compare(ChargeVO chargeVOA, ChargeVO chargeVOB) {
			if(chargeVOA.getCardVO().getBrand() == null){
				chargeVOA.getCardVO().setBrand("");
			}
			if(chargeVOB.getCardVO().getBrand() == null){
				chargeVOB.getCardVO().setBrand("");
			}
			return chargeVOA.getCardVO().getBrand().compareTo(chargeVOB.getCardVO().getBrand());
		}
	}
	
}
