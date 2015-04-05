package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import com.liferay.portal.util.PortalUtil;

import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.MerchantVO;

public class Methods {
	private static ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	public static void orderMerchant(String campo, ArrayList<MerchantVO> list) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<MerchantVO> listAllMerchantsFilter(MerchantVO merchantVO) {
		ArrayList<MerchantVO> listMerchants = null;
		try {
			listMerchants = procesorFacade.listAllMerchantsFilter(merchantVO);
		} catch (ProcesorFacadeException e) {
			e.printStackTrace();
		}
		return listMerchants;
	}
	
	public static ArrayList<MerchantVO> orderMerchant(ArrayList<MerchantVO> list, String orderByCol, String orderByType ) {
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
