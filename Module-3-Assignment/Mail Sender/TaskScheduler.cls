/**
 * Class to schedule the ScheduledBatchable class.
 */ 
public class TaskScheduler 
{   
    public static void scheduleTask()
    {
        ScheduledBatchable sb = new ScheduledBatchable();
    	String CRON = '0 12 11 * * ?';
    	String jobID = System.schedule('Send Emails', CRON, sb);
    }
}