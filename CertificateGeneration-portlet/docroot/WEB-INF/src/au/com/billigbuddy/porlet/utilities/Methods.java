package au.com.billigbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;

import org.apache.commons.beanutils.BeanComparator;

import au.com.billingbuddy.vo.objects.CertificateVO;

public class Methods {
	
	public static void orderCertificates(String campo, ArrayList<CertificateVO> list) {
		BeanComparator<CertificateVO> comparator= new BeanComparator<CertificateVO>(campo);
		Collections.sort(list, comparator);
	}
	
	public static ArrayList<CertificateVO> orderCertificates(ArrayList<CertificateVO> list, String orderByCol, String orderByType ) {
		BeanComparator<CertificateVO> comparator= new BeanComparator<CertificateVO>(orderByCol);
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
