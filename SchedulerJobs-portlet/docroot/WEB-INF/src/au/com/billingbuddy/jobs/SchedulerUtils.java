package au.com.billingbuddy.jobs;

import java.util.List;

import javax.portlet.PortletRequest;

import com.liferay.portal.kernel.scheduler.SchedulerEngineHelperUtil;
import com.liferay.portal.kernel.scheduler.SchedulerException;
import com.liferay.portal.kernel.scheduler.messaging.SchedulerResponse;

public class SchedulerUtils {
	
	public static final int NUMBER_OF_ROWS = 0;
	
	public static List<SchedulerResponse> getSchedulerJobs(PortletRequest request) throws SchedulerException {
        List<SchedulerResponse> schedulerJobsList = SchedulerEngineHelperUtil.getScheduledJobs();
        for (SchedulerResponse schedulerResponse : schedulerJobsList) {
//        	System.out.println(SchedulerEngineHelperUtil.getStartTime(schedulerResponse).toString());
//        	System.out.println(SchedulerEngineHelperUtil.getEndTime(schedulerResponse));
//        	System.out.println(SchedulerEngineHelperUtil.getPreviousFireTime(schedulerResponse));
//        	System.out.println(SchedulerEngineHelperUtil.getNextFireTime(schedulerResponse));
		}
        return schedulerJobsList;
    }
}
