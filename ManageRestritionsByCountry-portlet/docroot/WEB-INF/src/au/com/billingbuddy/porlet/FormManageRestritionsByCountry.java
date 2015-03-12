package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import au.com.billigbuddy.utils.BBUtils;
import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.vo.objects.CountryBlockListVO;

import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormManageRestritionsByCountry extends MVCPortlet {
	
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		System.out.println("Ejecuta doView en FormReportTransactionsByDay ");
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		
		ArrayList<CountryBlockListVO> listCountryBlockList = (ArrayList<CountryBlockListVO>)session.getAttribute("listCountryBlockList");
		
		/*if(listCountryBlockList == null){*/
			try {
				listCountryBlockList = procesorFacade.listCountryBlockList();
				session.setAttribute("listCountryBlockListOriginal", listCountryBlockList);
				session.setAttribute("listCountryBlockList", listCountryBlockList);
			} catch (ProcesorFacadeException e) {
				e.printStackTrace();
				PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
				LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
				SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
				SessionErrors.add(renderRequest,e.getErrorCode());
				System.out.println("e.getMessage(): " + e.getMessage());
				System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
				System.out.println("e.getErrorCode(): " + e.getErrorCode());
			}
		/*}else{
			
			Enumeration<String> enume = request.getParameterNames();
			while (enume.hasMoreElements()){
				String variable = enume.nextElement();
				System.out.println(variable + "-->" + request.getParameter(variable));
			}*/
			
			/*int delta = Integer.parseInt(request.getParameter("delta"));
			int cur = Integer.parseInt(request.getParameter("cur"));
			for (int i = (delta*(cur-1)); i <= ((delta*cur)-1); i++) {
				CountryBlockListVO countryBlockListVO = (CountryBlockListVO)listCountryBlockList.get(i);
				String transaction = request.getParameter("transaction_"+countryBlockListVO.getCountryVO().getNumeric());
				String merchantServerLocation = request.getParameter("merchantServerLocation_"+countryBlockListVO.getCountryVO().getNumeric());
				System.out.println("position: " + i + ":" +transaction + ":" + merchantServerLocation);
				countryBlockListVO.setTransaction(transaction);
				countryBlockListVO.setMerchantServerLocation(merchantServerLocation);
				listCountryBlockList.set(i, countryBlockListVO);
			}*/
		/*}*/
		super.doView(renderRequest, renderResponse);
	}
	
	
	public void savePlan(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		ArrayList<CountryBlockListVO> listCountryBlockList = (ArrayList<CountryBlockListVO>)session.getAttribute("listCountryBlockList");
		try {
			/*int delta = Integer.parseInt(request.getParameter("delta"));
			int cur = Integer.parseInt(request.getParameter("cur"));
			for (int i = (delta*(cur-1)); i <= ((delta*cur)-1); i++) {*/
			
			for (int i = 0; i < listCountryBlockList.size(); i++) {
				
				CountryBlockListVO countryBlockListVO = (CountryBlockListVO)listCountryBlockList.get(i);
				/*CountryBlockListVO countryBlockListVO = (CountryBlockListVO) iterator.next();*/
				String transaction = request.getParameter("transaction_"+countryBlockListVO.getCountryVO().getNumeric());
				String merchantServerLocation = request.getParameter("merchantServerLocation_"+countryBlockListVO.getCountryVO().getNumeric());
				String merchantRegistrationLocation = request.getParameter("merchantRegistrationLocation_"+countryBlockListVO.getCountryVO().getNumeric());
				String creditCardIssueLocation = request.getParameter("creditCardIssueLocation_"+countryBlockListVO.getCountryVO().getNumeric());
				String creditCardHolderLocation = request.getParameter("creditCardHolderLocation_"+countryBlockListVO.getCountryVO().getNumeric());
				
				/*System.out.println("position: " + i + ":" +transaction + ":" + merchantServerLocation);*/
				countryBlockListVO.setTransaction(transaction!= null?"1":"0");
				countryBlockListVO.setMerchantServerLocation(merchantServerLocation!= null?"1":"0");
				countryBlockListVO.setMerchantRegistrationLocation(merchantRegistrationLocation!= null?"1":"0");
				countryBlockListVO.setCreditCardIssueLocation(creditCardIssueLocation!= null?"1":"0");
				countryBlockListVO.setCreditCardHolderLocation(creditCardHolderLocation!= null?"1":"0");
				listCountryBlockList.set(i, countryBlockListVO);
			}
			
			procesorFacade.updateCountryBlockList((ArrayList<CountryBlockListVO>)session.getAttribute("listCountryBlockListOriginal"),listCountryBlockList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*Enumeration<String> enume = request.getParameterNames();
		while (enume.hasMoreElements()){
			String variable = enume.nextElement();
			System.out.println(variable + "<-->" + request.getParameter(variable));
		}*/
		
		/*String idCountries = (String)request.getParameter("containerCountriesPrimaryKeys");
		for (String idCountry: idCountries.split(",")){
			String transaction = request.getParameter("transaction_"+idCountry);
			String merchantServerLocation = request.getParameter("merchantServerLocation_"+idCountry);
			int position = listCountryBlockList.indexOf(new CountryBlockListVO(idCountry));
			System.out.println("position: " + position + ":" +transaction + ":" + merchantServerLocation);
			CountryBlockListVO countryBlockListVO = (CountryBlockListVO)listCountryBlockList.get(position);
			countryBlockListVO.setTransaction(transaction);
			countryBlockListVO.setMerchantServerLocation(merchantServerLocation);
			listCountryBlockList.set(position, countryBlockListVO);
			if(!BBUtils.isNullOrEmpty(transaction)){
				System.out.println("attribute: " + transaction);
				int position = listCountryBlockList.indexOf(new CountryBlockListVO(transaction));
				if(position != -1){
					System.out.println("position: " + position);
					CountryBlockListVO countryBlockListVO = (CountryBlockListVO)listCountryBlockList.get(position);
					countryBlockListVO.setTransaction("0");
					System.out.println("Valor anterior:" + countryBlockListVO.getCountryVO().getName());
				}
			}else{
				
			}
//			System.out.println("idCountry: " + idCountry + "-->" +listCountryBlockList.indexOf(new CountryBlockListVO(idCountry)));
		}*/
		session.setAttribute("listCountryBlockList", listCountryBlockList);
	}
	
//	public void searchTransactionsByDay(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException{
//		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
//		HttpSession session = request.getSession();
//		TransactionVO transactionVO = new TransactionVO();
//		try {
//			Date date;
//			try {
//				date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("fromDateTransactions"));
//				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
//				date = Utilities.getDateFormat(6).parse(actionRequest.getParameter("toDateTransactions"));
//				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
//				
//				System.out.println("transactionVO.getInitialDateReport(): " + transactionVO.getInitialDateReport());
//				System.out.println("transactionVO.getFinalDateReport(): " + transactionVO.getFinalDateReport());
//				
//			} catch (NumberFormatException e) {
//				e.printStackTrace();
//			} catch (ParseException e) {
//				e.printStackTrace();
//			}
//			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(transactionVO);
//			System.out.println("listTransactionsByDay.size(): " + listTransactionsByDay.size());
//			session.setAttribute("transactionVO", transactionVO);
//			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
//		} catch (ReportFacadeException e) {
//			e.printStackTrace();
//			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
//			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//			SessionErrors.add(actionRequest, "error");
//			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
//			SessionErrors.add(actionRequest,transactionVO.getMessage());
//			session.setAttribute("chargeVO", transactionVO);
//		}
//		actionResponse.setRenderParameter("jspPage", "/jsp/view.jsp");
//	}
//
//	@Override
//	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
//		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
//		HttpSession session = request.getSession();
//		TransactionVO transactionVO = new TransactionVO();
//		System.out.println("Ejecuta searchTransactionsByDay en FormReportTransactionsByDay");
//		try {
//			Date date;
//			try {
//				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("fromDateTransactions"));
//				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
//				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("toDateTransactions"));
//				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
//				
//				System.out.println("transactionVO.getInitialDateReport(): " + transactionVO.getInitialDateReport());
//				System.out.println("transactionVO.getFinalDateReport(): " + transactionVO.getFinalDateReport());
//				
//			} catch (NumberFormatException e) {
//				e.printStackTrace();
//			} catch (ParseException e) {
//				e.printStackTrace();
//			}
//			
//			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(transactionVO);
//			System.out.println("listTransactionsByDay.size(): " + listTransactionsByDay.size());
//			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
//		} catch (ReportFacadeException e) {
//			e.printStackTrace();
//			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
//			PortletConfig portletConfig = (PortletConfig)resourceRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
//			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
//			SessionMessages.add(resourceRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
//			SessionErrors.add(resourceRequest, "error");
//			System.out.println("transactionVO.getMessage(): " + transactionVO.getMessage());
//			SessionErrors.add(resourceRequest,transactionVO.getMessage());
//			session.setAttribute("chargeVO", transactionVO);
//		}
//		resourceResponse.setContentType("text/html");
//		PrintWriter writer = resourceResponse.getWriter();
//		writer.print("procesado....");
//        writer.flush();
//        writer.close();
//	}
//	
	
//	
//	@Override
//	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
//		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
//		HttpSession session = request.getSession();
//        try {
//			session.removeAttribute("transactionVOTransactions");
//			
//			TransactionVO transactionVO = new TransactionVO();
//			Date date;
//			try {
//				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("fromDateTransactions"));
//				transactionVO.setInitialDateReport(Utilities.getDateFormat(2).format(date));
//				date = Utilities.getDateFormat(6).parse(resourceRequest.getParameter("toDateTransactions"));
//				transactionVO.setFinalDateReport(Utilities.getDateFormat(2).format(date));
//			} catch (NumberFormatException e) {
//				e.printStackTrace();
//			} catch (ParseException e) {
//				e.printStackTrace();
//			}
//			
//			ArrayList<TransactionVO> listTransactionsByDay = reportFacade.searchTransactionsByDay(new TransactionVO());
//			session.setAttribute("listTransactionsByDay", listTransactionsByDay);
//			session.setAttribute("transactionVOTransactions", transactionVO);
//		} catch (ReportFacadeException e) {
//			e.printStackTrace();
////			PortletConfig portletConfig = (PortletConfig)renderRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
////			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
////			SessionMessages.add(renderRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
////			SessionErrors.add(renderRequest,e.getErrorCode());
//			System.out.println("e.getMessage(): " + e.getMessage());
//			System.out.println("e.getErrorMenssage(): " + e.getErrorMenssage());
//			System.out.println("e.getErrorCode(): " + e.getErrorCode());
//		}
//		
//	}
	
}

