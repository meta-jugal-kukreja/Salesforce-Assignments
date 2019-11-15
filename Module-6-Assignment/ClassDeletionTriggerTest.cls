/**
* Test class to test ClassDeletionTrigger.
*/
@isTest
public class ClassDeletionTriggerTest {
    
    @isTest
    private static void testClassDeletion1()
    {
        Class__c oneClass = new Class__c(Name = 'Test Class', Custom_Status__c = 'New');
        oneClass.MaxSize__c = 100;
        insert oneClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 10; i++)
        {
            if(math.mod(i,2) == 0)
            {
                studentList.add(new Student__c(Name='Test ' + i, class__c = oneClass.id, Sex__c = 'Male'));
            }
            else
            {
                studentList.add(new Student__c(Name='Test ' + i, class__c = oneClass.id, Sex__c = 'Female'));
            }
        }
        insert studentList;
        Database.DeleteResult result = Database.delete(oneClass, false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }
    
    @isTest
    private static void testClassDeletion2()
    {
        Class__c oneClass = new Class__c(Name = 'Test Class', Custom_Status__c = 'New');
        oneClass.MaxSize__c = 100;
        insert oneClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 10; i++)
        {
            studentList.add(new Student__c(Name='Test ' + i, class__c = oneClass.id, Sex__c = 'Male'));
        }
        insert studentList;
        Database.DeleteResult result = Database.delete(oneClass, false);
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
}