/**
 * Test class for testing ControllerForAccount Controller
 */ 
@isTest
public class ControllerForAccountTest 
{
    /**
     * Test method to test the controller function
     */
    @isTest
    private static void testController()
    { 
        List<Account> accountList = new List<Account>();
        Account testAccount1 = new Account(Name = 'Test Account 1', BillingState = 'Rajasthan', BillingCity = 'Jaipur', BillingCountry = 'India');
        accountList.add(testAccount1);
        Account testAccount2 = new Account(Name = 'Test Account 2', BillingState = 'Rajasthan', BillingCity = 'Jaipur', BillingCountry = 'India');
        accountList.add(testAccount2);
        insert accountList;
        String query = 'SELECT Name, BillingState, BillingCity, BillingCountry FROM Account WHERE BillingState=\'Rajasthan\'' + 
            'AND BillingCity = \'Jaipur\' AND BillingCountry = \'India\'';
        Test.startTest();
        Test.setCurrentPage(Page.AccountsPage);
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        stdSetController.setSelected(accountList);
        ControllerForAccount controller = new ControllerForAccount();
        controller.setCon = stdSetController;
        Test.stopTest();
    }
}