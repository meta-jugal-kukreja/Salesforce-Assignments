public class TaskScheduler {   
    public static void scheduleTask()
    {
        scheduledBatchable sb = new scheduledBatchable();
        String CRON = '0 0 1 * * ?';
        String jobID = System.schedule('Send Emails', CRON, sb);
    }
}
