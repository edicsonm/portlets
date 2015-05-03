package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.jobs.MessageListenerDemo;
import au.com.billingbuddy.jobs.SchedulerUtils;
import au.com.billingbuddy.vo.objects.MerchantRestrictionVO;
import au.com.billingbuddy.vo.objects.MerchantVO;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.messaging.DestinationNames;
import com.liferay.portal.kernel.messaging.Message;
import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.scheduler.CronTrigger;
import com.liferay.portal.kernel.scheduler.SchedulerEngine;
import com.liferay.portal.kernel.scheduler.SchedulerEngineHelperUtil;
import com.liferay.portal.kernel.scheduler.SchedulerEngineUtil;
import com.liferay.portal.kernel.scheduler.SchedulerEntry;
import com.liferay.portal.kernel.scheduler.SchedulerEntryImpl;
import com.liferay.portal.kernel.scheduler.SchedulerException;
import com.liferay.portal.kernel.scheduler.StorageType;
import com.liferay.portal.kernel.scheduler.Trigger;
import com.liferay.portal.kernel.scheduler.TriggerState;
import com.liferay.portal.kernel.scheduler.TriggerType;
import com.liferay.portal.kernel.scheduler.messaging.SchedulerResponse;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormSchedulerJobs extends MVCPortlet {
	
	private static Log _log = LogFactoryUtil.getLog(FormSchedulerJobs.class);
	 
	private static final String _CRON_PATTERN = "0/10 * * ? * *";
	private static final String _GROUP_NAME = "The Group Name";
	private static final String _JOB_NAME = "The Job Name";
 
	private static String _portletId;
	private static SchedulerEntry _schedulerEntry;
	
	@Override
	public void init() throws PortletException {
		super.init();
		System.out.println("Ejecuta el metodo init() ... ");
		LiferayPortletConfig portletConfig = (LiferayPortletConfig)getPortletConfig();
		_portletId = portletConfig.getPortletId();
		
		/*		
		// Scheduler #1
		_schedulerEntry = new SchedulerEntryImpl();
		_schedulerEntry.setEventListenerClass(MessageListenerDemo.class.getName());
		_schedulerEntry.setTriggerType(TriggerType.CRON);
		_schedulerEntry.setTriggerValue(_CRON_PATTERN);
		try {
			SchedulerEngineUtil.schedule(_schedulerEntry, StorageType.PERSISTED, _portletId, 0);
			_log.info(_schedulerEntry + " scheduled for " + _portletId);
		}
		catch (SchedulerException se) {
			_log.error(se);
		}*/
		
		Message message = new Message();
		message.put(SchedulerEngine.MESSAGE_LISTENER_CLASS_NAME, MessageListenerDemo.class.getName());
		message.put(SchedulerEngine.PORTLET_ID, _portletId);
		Trigger trigger = new CronTrigger(_JOB_NAME, _GROUP_NAME, _CRON_PATTERN);
		try {
			SchedulerEngineHelperUtil.schedule(trigger, StorageType.PERSISTED, "Test Schedule",DestinationNames.SCHEDULER_DISPATCH, message, 0);
			_log.info(_JOB_NAME + " scheduled for " + _portletId);
		}catch (SchedulerException se) {
			_log.error(se);
		}
	}

	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			List<SchedulerResponse> schedulerJobsList = SchedulerUtils.getSchedulerJobs(renderRequest);
			session.setAttribute("schedulerJobsList", schedulerJobsList);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		super.doView(renderRequest, renderResponse);
	}

	public void jobAction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		System.out.println("Ejecutando el action ... " + actionRequest.getParameter("jobAction"));
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		/*Enumeration<String> enume = actionRequest.getParameterNames();
		while (enume.hasMoreElements()){
			String valor = enume.nextElement();
			System.out.println("Parametro: " + valor + "-->"+ actionRequest.getParameter(valor));
		}*/
		
		List<SchedulerResponse> schedulerJobsList = (List<SchedulerResponse>)session.getAttribute("schedulerJobsList");
		for (SchedulerResponse schedulerResponse : schedulerJobsList) {
			boolean rowSelected = ParamUtil.getBoolean(request, schedulerResponse.getJobName().toString(), false);
			if(rowSelected){
				try {
					if (actionRequest.getParameter("jobAction").equalsIgnoreCase("pause")) {
						SchedulerEngineHelperUtil.pause(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());
						SessionMessages.add(actionRequest, "jobPausedSuccessfully");
					} else if (actionRequest.getParameter("jobAction").equalsIgnoreCase("resume")) {
						SchedulerEngineHelperUtil.resume(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());
						SessionMessages.add(actionRequest, "jobResumedSuccessfully");
					} else if (actionRequest.getParameter("jobAction").equalsIgnoreCase("unschedule")) {
						SchedulerEngineHelperUtil.unschedule(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());
					} else if (actionRequest.getParameter("jobAction").equalsIgnoreCase("delete")) {
						SchedulerEngineHelperUtil.delete(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());
					} else if (actionRequest.getParameter("jobAction").equalsIgnoreCase("shutdown")) {
						SchedulerEngineHelperUtil.shutdown();
					}
					
					/*
					if(action.equals(PAUSE)) {
						SchedulerEngineHelperUtil.pause(jobName, groupName, storageType);
					} else if(action.equals(RESUME)) {
						SchedulerEngineHelperUtil.resume(jobName, groupName, storageType);
					} else if (action.equals(UNSCHEDULE)) {
						SchedulerEngineHelperUtil.unschedule(jobName, groupName, storageType);
					} else if (action.equals(DELETE)) {
						SchedulerEngineHelperUtil.delete(jobName, groupName, storageType);
					} else if (action.equals(UPDATE)) {
						String startDate = (String) uploadRequest.getParameter(START_DATE);
						String endDate = (String) uploadRequest.getParameter(END_DATE);
						String cronExpression = (String) uploadRequest.getParameter(CRON_EXPRESSION);
						Trigger trigger = new CronTrigger(jobName, groupName, FORMAT_DATE.parse(startDate), FORMAT_DATE.parse(endDate), cronExpression);
						SchedulerEngineHelperUtil.update(trigger, storageType);
					}
					*/
					
				} catch (SchedulerException e) {
					e.printStackTrace();
				}
				
				try {
					schedulerJobsList = SchedulerUtils.getSchedulerJobs(actionRequest);
					session.setAttribute("schedulerJobsList", schedulerJobsList);
				} catch (SchedulerException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
}

