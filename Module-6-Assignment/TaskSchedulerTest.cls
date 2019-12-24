/**
*  Test class to test scheduling.
*/
@IsTest
public class TaskSchedulerTest 
{
    /**
	  * Test method to schedule the mail sending if the opportunity is not modified in last 30 days.
	 */
    @IsTest
    public static void mailTest()
    {
        List<Opportunity> opportunitiesList = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for (Integer i=0; i<10; i++) {
            Opportunity o = new Opportunity(
                Name = 'Opportunity ' + i,
                CloseDate = closeDate,
                StageName = 'Prospecting'
            );
            opportunitiesList.add(o);
        }
        insert opportunitiesList;
        Map<Id, Opportunity> opptyMap = new Map<Id, Opportunity>(opportunitiesList);
        List<Id> opptyIds = new List<Id>(opptyMap.keySet());
        Test.startTest();
        ScheduledBatchable ts = new ScheduledBatchable();
        String jobId = System.Schedule('Mail Test' , '0 0 * * * ?',ts);
        List<Task> taskList = [SELECT Id FROM Task WHERE WhatId IN :opptyIds];
        System.assert(jobId != null, 'Job was not scheduled');
        Test.stopTest();    
    }
}