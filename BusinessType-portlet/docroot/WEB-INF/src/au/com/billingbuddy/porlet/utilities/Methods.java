package au.com.billingbuddy.porlet.utilities;

import au.com.billingbuddy.porlet.services.model.BusinessType;
import au.com.billingbuddy.porlet.services.service.BusinessTypeLocalServiceUtil;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.commons.beanutils.BeanComparator;

import com.liferay.portal.kernel.exception.SystemException;

import au.com.billingbuddy.vo.objects.BusinessTypeVO;

public class Methods {
	
	public static void orderBusinessType(String campo, ArrayList<BusinessTypeVO> list) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<BusinessTypeVO> searchBusiness(ArrayList<BusinessTypeVO> list, String orderByCol, String orderByType ) {
		return list;
	}
	
//	public static ArrayList<BusinessTypeVO> searchBusiness(ArrayList<BusinessTypeVO> list, String orderByCol, String orderByType ) {
//		 try {
//			List<BusinessType> BusinessTypesList= BusinessTypeLocalServiceUtil.getBusinessTypes(0, BusinessTypeLocalServiceUtil.getBusinessTypesCount());
//			System.out.println("BusinessTypesList.size(): " + BusinessTypesList.size());
//		} catch (SystemException e) {
//			e.printStackTrace();
//		}
//		
//		return list;
//	}
	
	public static ArrayList<BusinessTypeVO> orderBusinessType(ArrayList<BusinessTypeVO> list, String orderByCol, String orderByType ) {
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
