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
        System.assertEquals(System.today(), oppy.CloseDate, 'Close Date of opportunity was not as Expected');
    }
    
    /**
     * Test method to check the opportunities closed date when StageName changes from Another value(other than Closed Won and Closed Lost) 
     * to Closed Lost.
     */ 
    @isTest 
    static void testWhenStageChangesFromAnotherValueToClosedLost() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 2', StageName = 'Need Analysis', closeDate = Date.newInstance(2020, 2, 5));
        insert opp;
        opp.StageName = 'Closed Lost';
        Database.saveResult result = Database.UPDATE(opp, false);
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(System.today(), oppy.CloseDate, 'Close Date of opportunity was not as Expected');
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
        System.assertEquals(Date.newInstance(2019, 1, 5), oppy.CloseDate, 'Close Date of opportunity was not as Expected');
    }
    
    /**
     * Test method to check the opportunities closed date when StageName changes from Closed Won To Closed Lost.
     */ 
    @isTest 
    static void testWhenStageChangesFromClosedWonToClosedLost() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 3', StageName = 'Closed Won', closeDate = Date.newInstance(2019, 1, 5));
        insert opp;
        opp.StageName = 'Closed Lost';
        Database.saveResult result = Database.UPDATE(opp, false);
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(System.today(), oppy.CloseDate, 'Close Date of opportunity was not as Expected');
    }
    
    /**
     * Test method to check the opportunities closed date when StageName changes from Closed Lost To Closed Won.
     */ 
    @isTest 
    static void testWhenStageChangesFromClosedLostToClosedWon() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 3', StageName = 'Closed Lost', closeDate = Date.newInstance(2019, 1, 5));
        insert opp;
        opp.StageName = 'Closed Won';
        Database.saveResult result = Database.UPDATE(opp, false);
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(System.today(), oppy.CloseDate, 'Close Date of opportunity was not as Expected');
    }
    
    /**
     * Test method to check the opportunities closed date when StageName is not changed.
     */ 
    @isTest 
    static void testWhenStageChangeIsNotChanged() 
    {
        Opportunity opp = new Opportunity(Name = 'Opportunity 3', StageName = 'Closed Lost', closeDate = Date.newInstance(2019, 1, 5));
        insert opp;
        opp.StageName = 'Closed Lost';
        Database.saveResult result = Database.UPDATE(opp, false);
        Opportunity oppy = [Select closeDate from Opportunity where id = :opp.Id];
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals(Date.newInstance(2019, 1, 5), oppy.CloseDate, 'Close Date of opportunity was not as Expected');
    }
}