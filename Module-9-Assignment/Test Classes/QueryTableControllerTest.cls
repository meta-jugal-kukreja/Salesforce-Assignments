/**
 * Test class to test QueryTableController.
 */ 
@isTest
public class QueryTableControllerTest 
{
    /**
     * Setup method to setup data for the tests.
     */ 
    @testSetup
    static void testDataSetup()
    {
        List<Account> accountList = new List<Account>();
        for(Integer i = 1; i < 101; i++)
        {
            accountList.add(new Account(Name='Test Account ' + i));
        }
        insert accountList;
    }
    
    /**
     * Test method to test the setting up of executing query string.
     */ 
    @isTest
    static void testSetQueryToBeExecuted()
    {
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Account';
        conObj.setQueryToBeExecuted(testQuery);
        System.assertEquals(testQuery, conObj.getQueryToBeExecuted(), 
                            'The queryToBeExecuted field was not set up correctly.');
    }
    
    /**
     * Test method to test display fields if records are found.
     */ 
    @isTest
    static void testDisplayFieldsIfRecordsFound()
    {        
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Account';
        String sortField = 'Name';
        conObj.setQueryToBeExecuted(testQuery);        
        conObj.setSortBy(sortField);
        conObj.sortByMethod();
        List<sObject> records = (List<sObject>)conObj.getRecordsList();
        List<String> recordsFields = new List<String>(records[0].getPopulatedFieldsAsMap().keySet());
        List<String> fields = new List<String>();
        fields.add('Id');
        fields.add('Name');
        System.assertEquals(fields, recordsFields, 'Unexpected record fields formed.');
        System.assertEquals(sortField, conObj.getSortBy(), 'The sortBy field was not set correctly.');                
    }
    
    /**
     * Test method to test display fields if records are not found.
     */
    @isTest
    static void testDisplayFieldsIfRecordsNotFound()
    {
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Account WHERE Name = \'abcd\'';
        String sortField = 'Name';
        conObj.setQueryToBeExecuted(testQuery);
        conObj.setSortBy(sortField);
        List<sObject> records = (List<sObject>)conObj.getRecordsList(); 
        System.assert(records.IsEmpty());
        System.assert(ApexPages.getMessages()[0].getSummary().contains('No records found'),
                     'The page has no error messages.');                    
    }
    
    /**
     * Test method to test display fields if query is incorrect.
     */ 
    @isTest
    static void testDisplayFieldsIfQueryIsIncorrect()
    {
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Amount WHERE';
        String sortField = 'Name';      
        conObj.setQueryToBeExecuted(testQuery);
        conObj.setSortBy(sortField);
        List<sObject> records = (List<sObject>)conObj.getRecordsList(); 
        System.assertEquals(ApexPages.getMessages()[0].getSummary(), 'unexpected token: \'<EOF>\'',
                           'The page has no error messages.');
    }
    
    /**
     * Test method to test setting up of Desired Page Number.
     */
    @isTest
    static void testPageNumber()
    {
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Account';
        String sortField = 'Name';       	
        conObj.setQueryToBeExecuted(testQuery);
        conObj.setSortBy(sortField);
        List<sobject> records = (List<sobject>)conObj.getRecordsList(); 
        conObj.DesiredPage = 2;
        conObj.jumpToPage();
        System.assertEquals(2, conObj.setCon.getPageNumber(), 'The page number was not set correctly.');
    }
}