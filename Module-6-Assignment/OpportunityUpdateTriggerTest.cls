/**
 * Test class to test OpportunityOperations class methods.
 */
@isTest
public class OpportunityUpdateTriggerTest 
{
    /**
     * Test method to check the opportunities closed date when StageName changes from Another value(other than Closed Won and Closed Lost) 
     * to Closed Won.
     */ 
    @isTest 
    static void testWhenStageChangesFromAnotherValueToClosedWon() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 1', StageName = 'Prospecting', closeDate = Date.newInstance(2019, 12, 5));
        insert opp;
        opp.StageName = 'Closed Won';
        Database.saveResult result = Database.UPDATE(opp, false);
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(System.today(), oppy.CloseDate, 'CloseDate is not equal to today's Date');
    }
    
    /**
     * Test method to check the opportunities closed date when StageName changes from Another value(other than Closed Won and Closed Lost) 
     * to Closed Lost.
     */ 
    @isTest 
    static void testWhenStageChangesFromAnotherValueToClosedLost() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 2', StageName = 'Need Analusis', closeDate = Date.newInstance(2020, 2, 5));
        insert opp;
        opp.StageName = 'Closed Lost';
        Database.saveResult result = Database.UPDATE(opp, false);
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(System.today(), oppy.CloseDate, 'CloseDate is not equal to today's Date');
    }
    
    /**
     * Test method to check the opportunities closed date when StageName changes from Another value(other than Closed Won and Closed Lost) 
     * to some Another value(other than Closed Won and Closed Lost).
     */ 
    @isTest 
    static void testWhenStageChangesFromAnotherValueToSomeOtherValue() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 3', StageName = 'Qualification', closeDate = Date.newInstance(2019, 1, 5));
        insert opp;
        opp.StageName = 'Prospecting';
        Database.saveResult result = Database.UPDATE(opp, false);
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(Date.newInstance(2019, 1, 5), oppy.CloseDate, 'CloseDate is changed');
    }
}