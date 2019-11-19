/**
 * Test class to test SchemaObjects methods.
 */
@isTest
public class SchemaObjectsTest 
{
    /**
     * Test method to test the schema objects in the org.
     */ 
    @isTest
    public static void getObjectsInOrg()
    {
        SchemaObjects scObject = new SchemaObjects();
        List<String> listOfObject = scObject.getAllObjects();
        Set<String> result = new Set<String>();
        result.addAll(listOfObject);
        System.assert(result.contains('Student__c'), 'Object doesn\t exist.');  
    }
}