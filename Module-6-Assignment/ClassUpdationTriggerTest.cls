/**
* Test Class for testing ClassUpdationTrigger.
*/
@isTest
public class ClassUpdationTriggerTest {
    
    @isTest
    private static void testStudentDeletion()
    {
        Class__c oneClass = new Class__c(Name = 'Test Class', Custom_Status__c = 'New');
        oneClass.MaxSize__c = 100;
        insert oneClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 11; i++)
        {
            studentList.add(new Student__c(Name='Test ' + i, class__c = oneClass.id));
        }
        insert studentList;
        oneClass.Custom_Status__c = 'Reset';
        Database.update(oneClass);
        System.assertEquals(0, [Select COUNT() FROM Student__c WHERE class__c =: oneClass.id]);
    }
}