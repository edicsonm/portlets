package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

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
