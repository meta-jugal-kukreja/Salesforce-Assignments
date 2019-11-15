/**
 * Test class to test SchemaObjects methods.
 */
@isTest
public class SchemaObjectsTest 
{
    @isTest
    public static void GetObjectsInOrgtest()
    {
        SchemaObjects scObject = new SchemaObjects();
        List<String> listOfObject = scObject.getAllObjects();
        Set<String> result = new Set<String>();
        result.addAll(listOfObject);
        System.assert(result.contains('Student__c'));  
    }
}