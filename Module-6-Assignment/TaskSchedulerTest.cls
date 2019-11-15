/**
 *  Test class to test scheduling.
 */
@IsTest(SeeAllData=true)
public class TaskSchedulerTest {
   @IsTest
   public static void mailTest(){
       Test.startTest();
       ScheduledBatchable ts = new ScheduledBatchable();
       String jobId = System.Schedule('Mail Test' , '0 0 * * * ?',ts);
       Test.stopTest();
   }
}