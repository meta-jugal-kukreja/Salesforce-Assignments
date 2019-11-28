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
        Student__c student = new Student__c();
        Class__c oneClass = new Class__c(Name = 'Test Class', MaxSize__c = 500);
        insert oneClass;
        student = new Student__c(Name = 'Test Student', Class__c = oneClass.Id);
        insert student;
        JSONDataGenerator generator = new JSONDataGenerator();
        String JsonString = generator.prepareData(student);
        Map<String, Object> deserializedString = (Map<String, Object>) JSON.deserializeUntyped(JsonString);
        System.assertEquals('Test Student', deserializedString.get('Name'), 'JSON String was not formed as expected.');
        System.assertEquals(oneClass.Id, deserializedString.get('Class__c'), 'JSON String was not formed as expected.');
    }
}