/**
 * Test class to test the QueryController.
 */ 
@isTest
public class QueryControllerTest 
{
    /**
     * Test method to test execute method when query is empty.
     */ 
	@isTest
    private static void testExecuteWhenQueryIsEmpty()
    {
        QueryController conObj = new QueryController();
        conObj.query = '';
        conObj.execute();
        System.assertEquals(false, conObj.showQueryResultsArea, 'Result Area was visible');
    }
    
    /**
     * Test method to test execute method when query is not empty.
     */ 
	@isTest
    private static void testExecuteWhenQueryIsNotEmpty()
    {
        QueryController conObj = new QueryController();
        conObj.query = 'SELECT Name FROM Account';
        conObj.execute();
        System.assertEquals(true, conObj.showQueryResultsArea, 'Result Area was visible');
    }
}