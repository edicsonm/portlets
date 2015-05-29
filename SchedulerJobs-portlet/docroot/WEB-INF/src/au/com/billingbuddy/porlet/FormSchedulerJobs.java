package au.com.billingbuddy.porlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import au.com.billigbuddy.utils.BBUtils;
import au.com.billigbuddy.utils.VO.ScheduledJobVO;
import au.com.billingbuddy.business.objects.ProcesorFacade;
import au.com.billingbuddy.business.objects.ProcessSubscriptionFacade;
import au.com.billingbuddy.exceptions.objects.ProcesorFacadeException;
import au.com.billingbuddy.jobs.MessageListenerDemo;
import au.com.billingbuddy.jobs.SchedulerUtils;
import au.com.billingbuddy.porlet.utilities.Methods;
import au.com.billingbuddy.vo.objects.CardVO;
import au.com.billingbuddy.vo.objects.MerchantRestrictionVO;
import au.com.billingbuddy.vo.objects.MerchantVO;
import au.com.billingbuddy.vo.objects.PlanVO;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.messaging.Destination;
import com.liferay.portal.kernel.messaging.DestinationNames;
import com.liferay.portal.kernel.messaging.Message;
import com.liferay.portal.kernel.messaging.MessageBusUtil;
import com.liferay.portal.kernel.messaging.ParallelDestination;
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
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.service.ServiceContextThreadLocal;
import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FormSchedulerJobs extends MVCPortlet {
	
	private static Log log = LogFactoryUtil.getLog(FormSchedulerJobs.class);
	/*"Segundos" "Minutos" "Horas" "Día del mes" "Mes" "Día de la semana" "Año" 
    * : Selecciona todos los valores de un campo (por ejemplo cada hora, cada minuto)
    ? : Selecciona sin un valor específico cuando se puede utilizar (es similar a decir cualquiera)
    - : Selecciona rango de valores (por ejemplo 4-6 que es de 4 a 6)
    , : Selecciona valores específicos (por ejemplo MON,WED,FRI es decir los lunes, miárcoles y viernes )
    / : Selecciona incrementos a partir del primer valor (por ejemplo 0/15 que es cada 15 minutos comenzando desde el minuto 0 -> 15, 30 ,45)
    L (Día del mes) : Selecciona el último día del mes
    L (Día de la semana) : Selecciona el último día de la semana (7 / sabado / SAT)
    XL (Día de la semana) : Seleccona el último día de ese tipo del mes (por ejemplo 6L -> el último viernes del mes)
    W : Selecciona el día de la semana (de lunes a viernes) más cercano al día (weekday)
    LW : Selecciona el último weekday del mes
    # : Selecciona la posición de un día del mes (por ejemplo 6#3 -> el tercer viernes del mes) */
//	private static final String _CRON_PATTERN = "0/10 * * ? * *";
	private static final String _CRON_PATTERN = "0 1 0/8 1/1 * ? *";
//	private static final String _GROUP_NAME = "BBProcess";
	private static final String _JOB_NAME = "The Job Name";
 
	private static String portletId;
	private static SchedulerEntry _schedulerEntry;
	private ProcesorFacade procesorFacade = ProcesorFacade.getInstance();
	
	@Override
	public void init() throws PortletException {
		super.init();
		System.out.println("Ejecuta el init del portlet FormSchedulerJobs ... ");
		LiferayPortletConfig portletConfig = (LiferayPortletConfig)getPortletConfig();
		portletId = portletConfig.getPortletId();
		
		/*try {
			SchedulerUtils.triggerScheduledJobs();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}*/
		
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
		
		/*Message message = new Message();
		message.put(SchedulerEngine.MESSAGE_LISTENER_CLASS_NAME, MessageListenerDemo.class.getName());
		message.put(SchedulerEngine.PORTLET_ID, portletId);
		Trigger trigger = new CronTrigger(_JOB_NAME, SchedulerUtils.BBProcessGroupName, _CRON_PATTERN);
		try {
			SchedulerEngineHelperUtil.schedule(trigger, StorageType.PERSISTED, "Test Schedule",DestinationNames.SCHEDULER_DISPATCH, message, 0);
			log.info(_JOB_NAME + " scheduled for " + portletId);
		}catch (SchedulerException se) {
			log.error(se);
		}*/
	}

	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
		
		System.out.println("Obteniendo hilos ... ");
		ProcessSubscriptionFacade.getInstance().printThreads();
		System.out.println("Obtiene hilos ... ");
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		HttpSession session = request.getSession();
		try {
			List<SchedulerResponse> schedulerJobsList = SchedulerUtils.getSchedulerJobs();
			session.setAttribute("schedulerJobsList", schedulerJobsList);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		super.doView(renderRequest, renderResponse);
	}
	
	public void addScheduledJob(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		ScheduledJobVO scheduledJobVO = new ScheduledJobVO();
		scheduledJobVO.setName(actionRequest.getParameter("name"));
		scheduledJobVO.setDescription(actionRequest.getParameter("description"));
		scheduledJobVO.setCronPattern(actionRequest.getParameter("cronPattern"));
		scheduledJobVO.setStorageType(actionRequest.getParameter("storageType"));
		try {
			
			/*Message message = new Message();
			message.put(SchedulerEngine.MESSAGE_LISTENER_CLASS_NAME, MessageListenerDemo.class.getName());
			message.put(SchedulerEngine.PORTLET_ID, portletId);
			Trigger trigger = new CronTrigger(_JOB_NAME, SchedulerUtils.BBProcessGroupName, _CRON_PATTERN);
			try {
				SchedulerEngineHelperUtil.schedule(trigger, StorageType.PERSISTED, "Test Schedule",DestinationNames.SCHEDULER_DISPATCH, message, 0);
				log.info(_JOB_NAME + " scheduled for " + portletId);
			}catch (SchedulerException se) {
				log.error(se);
			}*/
			
			
			scheduledJobVO.setListener(Class.forName(actionRequest.getParameter("listener")));
			Message message = new Message();
			message.put(SchedulerEngine.MESSAGE_LISTENER_CLASS_NAME, scheduledJobVO.getListener().getName());
			message.put(SchedulerEngine.PORTLET_ID, portletId);
			Trigger trigger = new CronTrigger(scheduledJobVO.getName(), SchedulerUtils.BBProcessGroupName, scheduledJobVO.getCronPattern());
			
			SchedulerEngineHelperUtil.schedule(trigger, StorageType.valueOf(scheduledJobVO.getStorageType()), scheduledJobVO.getDescription(), DestinationNames.SCHEDULER_DISPATCH, message, 0);
			Methods.sendNotification("Has been created a new Job to execute the Subscriptions Process.");
			/*if(scheduledJobVO.getStorageType().equalsIgnoreCase("PERSISTED")){
				SchedulerEngineHelperUtil.schedule(trigger, StorageType.PERSISTED, scheduledJobVO.getDescription(), DestinationNames.SCHEDULER_DISPATCH, message, 0);
			}else if(scheduledJobVO.getStorageType().equalsIgnoreCase("MEMORY_CLUSTERED")){
				SchedulerEngineHelperUtil.schedule(trigger, StorageType.MEMORY_CLUSTERED, scheduledJobVO.getDescription(), DestinationNames.SCHEDULER_DISPATCH, message, 0);
			}else if(scheduledJobVO.getStorageType().equalsIgnoreCase("MEMORY")){
				SchedulerEngineHelperUtil.schedule(trigger, StorageType.MEMORY, scheduledJobVO.getDescription(), DestinationNames.SCHEDULER_DISPATCH, message, 0);
			}*/
			
//			SchedulerEngineHelperUtil.schedule(trigger, storageType, scheduledJobVO.getDescription(), DestinationNames.SCHEDULER_DISPATCH, message, 0);
			
			/*List<SchedulerResponse> schedulerJobsList = SchedulerUtils.getSchedulerJobs();
			session.setAttribute("schedulerJobsList", schedulerJobsList);*/
			SessionMessages.add(actionRequest, "jobCreatedSuccessfully");
			session.removeAttribute("scheduledJobVO");
			session.setAttribute("answerScheduledJob","true");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest, "error");
			SessionErrors.add(actionRequest,e.getMessage());
			session.setAttribute("scheduledJobVO", scheduledJobVO);
			session.setAttribute("answerScheduledJob","false");
		}catch (SchedulerException e) {
			log.error(e);
			e.printStackTrace();
			PortletConfig portletConfig = (PortletConfig)actionRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
			LiferayPortletConfig liferayPortletConfig = (LiferayPortletConfig) portletConfig;
			SessionMessages.add(actionRequest, liferayPortletConfig.getPortletId() + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			SessionErrors.add(actionRequest, "error");
			SessionErrors.add(actionRequest,e.getMessage());
			session.setAttribute("scheduledJobVO", scheduledJobVO);
			session.setAttribute("answerScheduledJob","false");
		}
		
		actionResponse.setRenderParameter("mvcPath", "/jsp/addScheduledJob.jsp");
	}
	
	public void jobAction(ActionRequest actionRequest, ActionResponse actionResponse) throws IOException, PortletException {
		
		HttpServletRequest request = PortalUtil.getHttpServletRequest(actionRequest);
		HttpSession session = request.getSession();
		
		List<SchedulerResponse> schedulerJobsList = (List<SchedulerResponse>)session.getAttribute("schedulerJobsList");
		for (SchedulerResponse schedulerResponse : schedulerJobsList) {
			boolean rowSelected = ParamUtil.getBoolean(request, String.valueOf(schedulerResponse.hashCode()), false);
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
						SchedulerEngineHelperUtil.pause(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());
						SchedulerEngineHelperUtil.unschedule(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());
						SessionMessages.add(actionRequest, "jobUnschedulesSuccessfully");
					} else if (actionRequest.getParameter("jobAction").equalsIgnoreCase("delete")) {
						/*SchedulerEngineHelperUtil.pause(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());
						SchedulerEngineHelperUtil.unschedule(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());*/
						SchedulerEngineHelperUtil.delete(
								schedulerResponse.getJobName(),
								schedulerResponse.getGroupName(),
								schedulerResponse.getStorageType());
						SessionMessages.add(actionRequest, "jobDeletedSuccessfully");
					} else if (actionRequest.getParameter("jobAction").equalsIgnoreCase("shutdown")) {
						SessionMessages.add(actionRequest, "jobShutDownedSuccessfully");
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
					schedulerJobsList = SchedulerUtils.getSchedulerJobs();
					session.setAttribute("schedulerJobsList", schedulerJobsList);
				} catch (SchedulerException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException, PortletException {
		HttpServletRequest request = PortalUtil.getHttpServletRequest(resourceRequest);
		HttpServletResponse response = PortalUtil.getHttpServletResponse(resourceResponse);
		
		HttpSession session = request.getSession();
		String action = resourceRequest.getParameter("action");
		if (action != null && action.equals("listScheduledJobs")) {
			include("/jsp/scheduledJobs.jsp", resourceRequest, resourceResponse, PortletRequest.RESOURCE_PHASE);
		}
	}
	
}

