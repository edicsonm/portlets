package au.com.billingbuddy.porlet.utilities;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.RenderRequest;

import org.apache.commons.beanutils.BeanComparator;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.model.Company;
import com.liferay.portal.model.Role;
import com.liferay.portal.model.User;
import com.liferay.portal.service.CompanyLocalServiceUtil;
import com.liferay.portal.service.RoleLocalServiceUtil;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.service.UserNotificationEventLocalServiceUtil;

import au.com.billingbuddy.jobs.MessageListenerDemo;
import au.com.billingbuddy.jobs.ProcessSubscriptions;
import au.com.billingbuddy.vo.objects.ChargeVO;
import au.com.billingbuddy.vo.objects.MerchantCustomerVO;
import au.com.billingbuddy.vo.objects.RefundVO;
import au.com.billingbuddy.vo.objects.TransactionVO;

public class Methods {
	
	public static void orderTransactions(String campo, ArrayList<ChargeVO> lista) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(lista, comparator);
	}
	
	public static ArrayList<MerchantCustomerVO> orderCustomers(ArrayList<MerchantCustomerVO> list, String orderByCol, String orderByType ) {
		if(orderByCol.equalsIgnoreCase("email")){
			if(list != null){
				if(orderByType.equals("asc")){
					Collections.sort(list, new SortListByEmail());
				}else{
					Collections.sort(list, new SortListByEmail());
					Collections.reverse(list);
				}
			}
//		}else if(orderByCol.equalsIgnoreCase("cardVO.brand")){
//			if(list != null){
//				if(orderByType.equals("asc")){
//					Collections.sort(list, new SortListByBrand());
//					
//				}else{
//					Collections.sort(list, new SortListByBrand());
//					Collections.reverse(list);
//				}
//			}
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
	
	public static void orderRefunds(String campo, ArrayList<MerchantCustomerVO> lista) {
		BeanComparator comparator= new BeanComparator(campo);
		Collections.sort(lista, comparator);
	}
	
	public static ArrayList<MerchantCustomerVO> orderRefunds(ArrayList<MerchantCustomerVO> listCustomersMerchant, String orderByCol, String orderByType ) {
		BeanComparator comparator= new BeanComparator(orderByCol);
		if(listCustomersMerchant != null){
			if(orderByType.equals("asc")){
				Collections.sort(listCustomersMerchant, comparator);
			}else{
				Collections.sort(listCustomersMerchant, comparator);
				Collections.reverse(listCustomersMerchant);
			}
		}
		return listCustomersMerchant;		
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
	
	static class  SortListByEmail implements Comparator<MerchantCustomerVO>{
		public int compare(MerchantCustomerVO merchantCustomerVOA, MerchantCustomerVO merchantCustomerVOB) {
			return Double.parseDouble(merchantCustomerVOA.getCustomerVO().getEmail()) < Double.parseDouble(merchantCustomerVOB.getCustomerVO().getEmail()) ? -1 : Double.parseDouble(merchantCustomerVOA.getCustomerVO().getEmail()) == Double.parseDouble(merchantCustomerVOB.getCustomerVO().getEmail()) ? 0 : 1;
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
	
	public static void sendNotification(String notificationText){
		try {
			Company company = CompanyLocalServiceUtil.getCompanyByMx("billingbuddy.com");
			Role role = RoleLocalServiceUtil.getRole(company.getCompanyId(), "BillingBuddyAdministrator");
			List<User> users = UserLocalServiceUtil.getRoleUsers(role.getRoleId());
			for (User user : users) {
				JSONObject payloadJSON = JSONFactoryUtil.createJSONObject();
				payloadJSON.put("userId", user.getUserId());
				payloadJSON.put("notificationText", notificationText);
				ServiceContext serviceContext = new ServiceContext();
				serviceContext.setScopeGroupId(user.getGroupId());
				UserNotificationEventLocalServiceUtil.addUserNotificationEvent(
						user.getUserId(),
						ProcessSubscriptions.PORTLET_ID,
						(new Date()).getTime(), user.getUserId(),
						payloadJSON.toString(), false, serviceContext);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
