@isTest
public class OpportunityUpdateTriggerTest 
{
    @isTest 
    static void oppCloseDateFieldTest1() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 1', StageName = 'Prospecting', closeDate = Date.newInstance(2019, 12, 5));
        insert opp;
        opp.StageName = 'Closed Won';
        Test.startTest();
        Database.saveResult result = Database.UPDATE(opp, false);
        Test.stopTest();
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(System.today(), oppy.CloseDate);
    }
    
    @isTest 
    static void oppCloseDateFieldTest2() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 2', StageName = 'Need Analusis', closeDate = Date.newInstance(2020, 2, 5));
        insert opp;
        opp.StageName = 'Closed Lost';
        Test.startTest();
        Database.saveResult result = Database.UPDATE(opp, false);
        Test.stopTest();
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(System.today(), oppy.CloseDate);
    }
    
    @isTest 
    static void oppCloseDateFieldTest3() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 3', StageName = 'Qualification', closeDate = Date.newInstance(2019, 1, 5));
        insert opp;
        opp.StageName = 'Prospecting';
        Test.startTest();
        Database.saveResult result = Database.UPDATE(opp, false);
        Test.stopTest();
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(Date.newInstance(2019, 1, 5), oppy.CloseDate);
    }
}