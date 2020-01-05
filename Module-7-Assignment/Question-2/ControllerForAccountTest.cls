/**
 * Test class for testing ControllerForAccount Controller
 */ 
@isTest
public class ControllerForAccountTest 
{   
    @testSetup
    private static void setupTestData()
    {
        List<Account> accountList = new List<Account>();
        for(Integer i = 0; i < 101; i++)
        {
            accountList.add(new Account(Name = 'Test Account ' + i));
        }
        insert accountList;
    }
    
    /**
     * Test method to test the controller function with blank filter fields.
     */
    @isTest
    private static void testGetAccountsWithAllBlankFilterFields()
    { 
        ControllerForAccount controllerForAccountsobj = new ControllerForAccount();
        controllerForAccountsobj.city = '';
        controllerForAccountsobj.state = '';
        controllerForAccountsobj.country = '';
        controllerForAccountsobj.showAccountsList = true;
        controllerForAccountsobj.getAccounts();
        System.assertEquals(false, controllerForAccountsobj.showAccountsList, 'Account Details area is visible');
    }
    
    /**
     * Test method to test the controller function with two blank filter fields.
     */
    @isTest
    private static void testGetAccountsWithTwoBlankFilterFields()
    { 
        ControllerForAccount controllerForAccountsobj = new ControllerForAccount();
        controllerForAccountsobj.city = '';
        controllerForAccountsobj.state = '';
        controllerForAccountsobj.country = 'Ind';
        List<Account> accountList = [SELECT Name, BillingCity, BillingState, BillingCountry FROM Account WHERE Name LIKE 'Test Account 1%'];
        for(Account oneAccount : accountList)
        {
            oneAccount.BillingCountry = 'India';
        }
        update accountList;
        controllerForAccountsobj.getAccounts();
        System.assertEquals(10, controllerForAccountsobj.accountsList.size(), 'List was not formed as expected');
    }
    
     /**
     * Test method to test the controller function with one blank filter field.
     */
    @isTest
    private static void testGetAccountsWithOneBlankFilterField()
    { 
        ControllerForAccount controllerForAccountsobj = new ControllerForAccount();
        controllerForAccountsobj.city = '';
        controllerForAccountsobj.state = 'ajas';
        controllerForAccountsobj.country = 'Ind';
        List<Account> accountList = [SELECT Name, BillingCity, BillingState, BillingCountry FROM Account WHERE Name LIKE 'Test Account 2%'];
        for(Account oneAccount : accountList)
        {
            oneAccount.BillingCountry = 'India';
            oneAccount.BillingState = 'Rajasthan';
        }
        update accountList;
        controllerForAccountsobj.getAccounts();
        System.assertEquals(10, controllerForAccountsobj.accountsList.size(), 'List was not formed as expected');
    }
    
    /**
     * Test method to test whether the page has more records next.
     */
    @isTest
    private static void testNext()
    {
        ControllerForAccount controllerForAccountsobj = new ControllerForAccount();
        List<Account> accountList = [SELECT Name, BillingCity, BillingState, BillingCountry FROM Account WHERE Name LIKE 'Test Account %'];
        for(Account oneAccount : accountList)
        {
            oneAccount.BillingCity = 'Jaipur';
            oneAccount.BillingCountry = 'India';
            oneAccount.BillingState = 'Rajasthan';
        }
        update accountList;
        String query = 'SELECT Name, BillingState, BillingCity, BillingCountry FROM Account WHERE BillingState LIKE \'%Rajasthan%\'' + 
            'AND BillingCity LIKE \'%Jaipur%\' AND BillingCountry LIKE \'%India%\'';
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        controllerForAccountsobj.setCon = stdSetController;
        controllerForAccountsobj.setCon.setPageSize(10);
        controllerForAccountsobj.next();
        System.assertEquals(10, controllerForAccountsobj.SetCon.getRecords().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has more records previous.
     */
    @isTest
    private static void testPrevious()
    {
        ControllerForAccount controllerForAccountsobj = new ControllerForAccount();
        List<Account> accountList = [SELECT Name, BillingCity, BillingState, BillingCountry FROM Account WHERE Name LIKE 'Test Account %'];
        for(Account oneAccount : accountList)
        {
            oneAccount.BillingCity = 'Jaipur';
            oneAccount.BillingCountry = 'India';
            oneAccount.BillingState = 'Rajasthan';
        }
        update accountList;
        String query = 'SELECT Name, BillingState, BillingCity, BillingCountry FROM Account WHERE BillingState LIKE \'%Rajasthan%\'' + 
            'AND BillingCity LIKE \'%Jaipur%\' AND BillingCountry LIKE \'%India%\'';
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        controllerForAccountsobj.setCon = stdSetController;
        controllerForAccountsobj.setCon.setPageSize(10);
        controllerForAccountsobj.next();
        controllerForAccountsobj.previous();
        System.assertEquals(10, controllerForAccountsobj.SetCon.getRecords().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has records on first page.
     */
    @isTest
    private static void testFirst()
    {
        ControllerForAccount controllerForAccountsobj = new ControllerForAccount();
        List<Account> accountList = [SELECT Name, BillingCity, BillingState, BillingCountry FROM Account WHERE Name LIKE 'Test Account %'];
        for(Account oneAccount : accountList)
        {
            oneAccount.BillingCity = 'Jaipur';
            oneAccount.BillingCountry = 'India';
            oneAccount.BillingState = 'Rajasthan';
        }
        update accountList;
        String query = 'SELECT Name, BillingState, BillingCity, BillingCountry FROM Account WHERE BillingState LIKE \'%Rajasthan%\'' + 
            'AND BillingCity LIKE \'%Jaipur%\' AND BillingCountry LIKE \'%India%\'';
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        controllerForAccountsobj.setCon = stdSetController;
        controllerForAccountsobj.setCon.setPageSize(10);
        controllerForAccountsobj.next();
        controllerForAccountsobj.first();
        System.assertEquals(10, controllerForAccountsobj.SetCon.getRecords().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has records on last page.
     */
    @isTest
    private static void testLast()
    {
        ControllerForAccount controllerForAccountsobj = new ControllerForAccount();
        List<Account> accountList = [SELECT Name, BillingCity, BillingState, BillingCountry FROM Account WHERE Name LIKE 'Test Account %'];
        for(Account oneAccount : accountList)
        {
            oneAccount.BillingCity = 'Jaipur';
            oneAccount.BillingCountry = 'India';
            oneAccount.BillingState = 'Rajasthan';
        }
        update accountList;
        String query = 'SELECT Name, BillingState, BillingCity, BillingCountry FROM Account WHERE BillingState LIKE \'%Rajasthan%\'' + 
            'AND BillingCity LIKE \'%Jaipur%\' AND BillingCountry LIKE \'%India%\'';
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        controllerForAccountsobj.setCon = stdSetController;
        controllerForAccountsobj.setCon.setPageSize(10);
        controllerForAccountsobj.first();
        controllerForAccountsobj.last();
        System.assertEquals(1, controllerForAccountsobj.SetCon.getRecords().size(), 'List was not as Expected');
    }
}