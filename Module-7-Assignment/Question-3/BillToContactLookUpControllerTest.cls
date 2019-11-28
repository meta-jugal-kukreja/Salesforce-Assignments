/**
 * Test class to test BillToContactLookUpController.
 */ 
@isTest
public class BillToContactLookUpControllerTest 
{
    /**
     * Test method to test the saving action of BillToContactLookUpController.
     */ 
	@isTest
    private static void testSave()
    {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert con;
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', Manager__c = acc.Id,
                                          BillToContact__c = null,
                                          StageName = 'Prospecting', CloseDate = System.today());
        insert opp;
        PageReference pref = Page.BillToContactLookUp;
        pref.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pref);
        BillToContactLookUpController controller = new BillToContactLookUpController();
        Test.startTest();
        controller.currentOpportunityId = opp.Id;
        controller.lookUpBillToContact = con.Id;
        pref = controller.save();
        Id resultantBillToContact = [SELECT BillToContact__c FROM Opportunity WHERE Id =: opp.Id].BillToContact__c;
        System.assertEquals(pref.getUrl(), '/' + opp.Id, 'Page was not redirected as expected.');
        System.assertEquals(con.Id, resultantBillToContact, 'BillToContact__c field was not populated as Expected.');
        Test.stopTest();
    }
    
    /**
     * Test method to test the clearing action of BillToContactLookUpController.
     */ 
    @isTest
    private static void testClear()
    {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert con;
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', Manager__c = acc.Id,
                                          BillToContact__c = null,
                                          StageName = 'Prospecting', CloseDate = System.today());
        insert opp;
        PageReference pref = Page.BillToContactLookUp;
        pref.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pref);
        BillToContactLookUpController controller = new BillToContactLookUpController();
        Test.startTest();
        controller.currentOpportunityId = opp.Id;
        controller.lookUpBillToContact = con.Id;
        pref = controller.clear();
        Id resultantBillToContact = [SELECT BillToContact__c FROM Opportunity WHERE Id =: opp.Id].BillToContact__c;
        System.assertEquals(pref.getUrl(), '/' + opp.Id, 'Page was not redirected as expected.');
        System.assertEquals(null, resultantBillToContact, 'BillToContact__c field was not populated as Expected.');
        Test.stopTest();
    }
    
    /**
     * Test method to test the cancelling action of BillToContactLookUpController.
     */ 
    @isTest
    private static void testCancel()
    {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert con;
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', Manager__c = acc.Id,
                                          BillToContact__c = null,
                                          StageName = 'Prospecting', CloseDate = System.today());
        insert opp;
        PageReference pref = Page.BillToContactLookUp;
        pref.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pref);
        BillToContactLookUpController controller = new BillToContactLookUpController();
        Test.startTest();
        controller.currentOpportunityId = opp.Id;
        pref = controller.cancel();
        Id resultantBillToContact = [SELECT BillToContact__c FROM Opportunity WHERE Id =: opp.Id].BillToContact__c;
        System.assertEquals(pref.getUrl(), '/' + opp.Id, 'Page was not redirected as expected.');
        System.assertEquals(null, resultantBillToContact, 'BillToContact__c field was not populated as Expected.');
        Test.stopTest();
    }
}