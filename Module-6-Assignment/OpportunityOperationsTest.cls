/**
 * Test class to test OpportunityOperations class methods.
 **/
@isTest(SeeAllData = true)
public class OpportunityOperationsTest 
{
    @isTest
    private static void testUpdationOfOneRecord()
    {
        List<Opportunity> opportunityList = new List<Opportunity>();
        opportunityList = [SELECT BillToContact__c, Manager__c, BillToContact__r.AccountId FROM Opportunity 
                                                  WHERE BillToContact__c =: '0032v000039HoIUAA0'];
        Test.startTest();
        OpportunityOperations.updateOpportunities(opportunityList);
        Test.stopTest();
        System.assertEquals('0012v00002bxoJKAAY', [SELECT Manager__c FROM Opportunity 
                                                  WHERE BillToContact__c =: '0032v000039HoIUAA0'][0].Manager__c);
    }
}