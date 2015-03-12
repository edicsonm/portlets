package au.com.billigbuddy.porlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.TransactionFacade;
import au.com.billingbuddy.vo.objects.TransactionVO;

import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormListTransaction extends MVCPortlet {
	private TransactionFacade transactionFacade  = TransactionFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(renderResponse);
		HttpSession session = request.getSession();
		ArrayList<TransactionVO> listTransaction = transactionFacade.listTransaction(new TransactionVO());
		String accion = renderRequest.getParameter("accion");
		session.setAttribute("listTransaction", listTransaction);
		super.doView(renderRequest, renderResponse);
	}
}
