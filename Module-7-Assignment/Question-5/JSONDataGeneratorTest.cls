/**
 * Test class to test generation of JSON String
 */ 
@isTest
public class JSONDataGeneratorTest 
{
    /**
     * Method to test the Generated String.
     */ 
	@isTest
    private static void testJsonString()
    {
        List<Student__c> studentList = new List<Student__c>();
        Class__c oneClass = new Class__c(Name = 'Test Class', MaxSize__c = 500);
        insert oneClass;
        for(Integer i = 0; i < 2; i++)
        {
            studentList.add(new Student__c(Name = 'Test ' + i, Class__c = oneClass.Id));
        }
        insert studentList;
        JSONDataGenerator generator = new JSONDataGenerator();
        System.assert(generator.jsonString != null, 'JSON String was not generated');
    }
}