package au.com.billingbuddy.jobs;

import java.util.ArrayList;
import java.util.List;

import com.liferay.portal.kernel.scheduler.SchedulerEngineHelperUtil;
import com.liferay.portal.kernel.scheduler.SchedulerException;
import com.liferay.portal.kernel.scheduler.StorageType;
import com.liferay.portal.kernel.scheduler.messaging.SchedulerResponse;

public class SchedulerUtils {
	
	public static final int NUMBER_OF_ROWS = 0;
	public static final String BBProcessGroupName = "BBScheduledProcess";
	
	public static List<SchedulerResponse> getSchedulerJobs() throws SchedulerException {
//        List<SchedulerResponse> schedulerJobsList = SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName,StorageType.MEMORY);
//        List<SchedulerResponse> schedulerJobsList = SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName,StorageType.MEMORY_CLUSTERED);
//        List<SchedulerResponse> schedulerJobsList = SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName,StorageType.PERSISTED);
//		  List<SchedulerResponse> schedulerJobsList.addAll(SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName,StorageType.MEMORY));
//        List<SchedulerResponse> schedulerJobsList = SchedulerEngineHelperUtil.getScheduledJobs();
       
		ArrayList<SchedulerResponse> schedulerJobsList = (ArrayList<SchedulerResponse>)SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName,StorageType.MEMORY);
		schedulerJobsList.addAll(SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName,StorageType.MEMORY_CLUSTERED));
		schedulerJobsList.addAll(SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName,StorageType.PERSISTED));
//        for (SchedulerResponse schedulerResponse : schedulerJobsList) {
//    	   System.out.println("schedulerResponse.getJobName(): " + schedulerResponse.getJobName());
//        	System.out.println(SchedulerEngineHelperUtil.getStartTime(schedulerResponse).toString());
//        	System.out.println(SchedulerEngineHelperUtil.getEndTime(schedulerResponse));
//        	System.out.println(SchedulerEngineHelperUtil.getPreviousFireTime(schedulerResponse));
//        	System.out.println(SchedulerEngineHelperUtil.getNextFireTime(schedulerResponse));
//		}
        return schedulerJobsList;
    }
}
