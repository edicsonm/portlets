package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.MerchantConfigurationVO;

public class Methods {
	
	public static void orderMerchantConfiguration(String campo, ArrayList<MerchantConfigurationVO> list) {
		BeanComparator<MerchantConfigurationVO> comparator= new BeanComparator<MerchantConfigurationVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<MerchantConfigurationVO> orderMerchantConfiguration(ArrayList<MerchantConfigurationVO> list, String orderByCol, String orderByType ) {
		BeanComparator<MerchantConfigurationVO> comparator= new BeanComparator<MerchantConfigurationVO>(orderByCol);
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
