package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;

import javax.portlet.ActionRequest;
import javax.portlet.RenderRequest;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.business.objects.ReportFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.exceptions.objects.ReportFacadeException;
import au.com.billingbuddy.vo.objects.MerchantVO;
import au.com.billingbuddy.vo.objects.TransactionVO;

public class Methods {
	private static ReportFacade reportFacade = ReportFacade.getInstance();
	
	public static void orderReportTransactionsByDay(String campo, ArrayList<TransactionVO> list) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<TransactionVO> searchTransactionsByDayFilter(TransactionVO transactionVO) {
		ArrayList<TransactionVO> listTransactionsByDayFilter = null;
		try {
			listTransactionsByDayFilter = reportFacade.searchTransactionsByDayFilter(transactionVO);
		} catch (ReportFacadeException e) {
			e.printStackTrace();
		}
		return listTransactionsByDayFilter;
	}
	
	public static ArrayList<TransactionVO> orderReportTransactionsByDay(ArrayList<TransactionVO> list, String orderByCol, String orderByType ) {
		
		if(orderByCol.equalsIgnoreCase("chargeVO.amount")){
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
	
	static class  SortListByAmount implements Comparator<TransactionVO>{
		public int compare(TransactionVO transactionVOA, TransactionVO transactionVOB) {
			return Double.parseDouble(transactionVOA.getChargeVO().getAmount()) < Double.parseDouble(transactionVOB.getChargeVO().getAmount()) ? -1 : Double.parseDouble(transactionVOA.getChargeVO().getAmount()) == Double.parseDouble(transactionVOB.getChargeVO().getAmount()) ? 0 : 1;
		}
	}
	
//	static class SortListByAmountDesc implements Comparator<TransactionVO>{
//		public int compare(TransactionVO transactionVOA, TransactionVO transactionVOB) {
//			return Double.parseDouble(transactionVOA.getChargeVO().getAmount()) < Double.parseDouble(transactionVOB.getChargeVO().getAmount()) ? 1 : Double.parseDouble(transactionVOA.getChargeVO().getAmount()) == Double.parseDouble(transactionVOB.getChargeVO().getAmount()) ? 0 : -1;
//		}
//	}
	
	static class SortListByBrand implements Comparator<TransactionVO>{
		public int compare(TransactionVO transactionVOA, TransactionVO transactionVOB) {
			if(transactionVOA.getCardVO().getBrand() == null){
				transactionVOA.getCardVO().setBrand("");
			}
			if(transactionVOB.getCardVO().getBrand() == null){
				transactionVOB.getCardVO().setBrand("");
			}
			return transactionVOA.getCardVO().getBrand().compareTo(transactionVOB.getCardVO().getBrand());
		}
	}
}
