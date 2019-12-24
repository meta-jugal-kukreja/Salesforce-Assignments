/**
 * Test class to test OpportunityOperations class methods.
 **/
@isTest
public class OpportunityOperationsTest 
{
    /**
     * Test method to check updation of Manager__c field.
     */ 
    @isTest
    private static void testUpdationOfOneRecord()
    {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(LastName = 'Test Contact', AccountId = acc.Id, Subject__c = 'English');
        insert con;
        System.debug(con);
        List<Opportunity> opportunityList = new List<Opportunity>();
        for(Integer i = 0; i < 101; i++)
        {
            opportunityList.add(new Opportunity(Name = 'Test Opportunity ' + i,
                                               BillToContact__c = con.Id,
                                               Manager__c = null,
                                               CloseDate = System.today(),
                                               StageName = 'Prospecting'));
        }
        insert opportunityList;
        opportunityList = [SELECT BillToContact__c, BillToContact__r.AccountId, Manager__c FROM Opportunity WHERE Id in :opportunityList]; 
        System.debug(opportunityList);
        OpportunityOperations.updateOpportunities(opportunityList);
        List<Opportunity> oppList = [SELECT Manager__c FROM Opportunity WHERE BillToContact__c =: con.id];
        System.assertEquals(acc.Id, oppList.get(0).Manager__c, 'Manager__c field didn\'t formed as expected');
    }
}