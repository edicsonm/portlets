package au.com.billingbuddy.jobs;

import java.util.ArrayList;
import java.util.List;

import com.liferay.portal.kernel.messaging.DestinationNames;
import com.liferay.portal.kernel.scheduler.SchedulerEngineHelperUtil;
import com.liferay.portal.kernel.scheduler.SchedulerEngineUtil;
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
	
	public static void triggerScheduledJobs() throws SchedulerException {
		ArrayList<SchedulerResponse> schedulerJobsList = (ArrayList<SchedulerResponse>) SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName, StorageType.MEMORY);
		schedulerJobsList.addAll(SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName, StorageType.MEMORY_CLUSTERED));
		schedulerJobsList.addAll(SchedulerEngineHelperUtil.getScheduledJobs(BBProcessGroupName, StorageType.PERSISTED));
		for (SchedulerResponse schedulerResponse : schedulerJobsList) {
			System.out.println("State: "+SchedulerEngineHelperUtil.getJobState(schedulerResponse).toString());
			if(!SchedulerEngineHelperUtil.getJobState(schedulerResponse).toString().equalsIgnoreCase("UNSCHEDULED")){
				System.out.println("Proxima ejecucion"+SchedulerEngineHelperUtil.getNextFireTime(schedulerResponse));
				SchedulerEngineHelperUtil.delete(
						schedulerResponse.getJobName(),
						schedulerResponse.getGroupName(),
						schedulerResponse.getStorageType());
				
				SchedulerEngineHelperUtil.schedule(schedulerResponse.getTrigger(),
						schedulerResponse.getStorageType(),
						schedulerResponse.getDescription(),
						DestinationNames.SCHEDULER_DISPATCH,
						schedulerResponse.getMessage(), 0);
			}
		}
  }
	
}
