/**
* Test class for testing StudentInsertionTrigger.
*/
@isTest
public class StudentInsertionTriggerTest {
    
    @isTest
    private static void insertOneStudentTest()
    {
        Class__c oneClass = new Class__c(Name='Test Class');
        oneClass.MaxSize__c = 0;
        insert oneClass;
        Student__c oneStudent = new Student__c(Name='Test 1', Class__c=oneClass.id);
        Database.SaveResult result  = Database.insert(oneStudent, false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }
    
    @isTest
    private static void insertStudentInBulkTest()
    {
        Class__c oneClass = new Class__c(Name='Test Class');
        oneClass.MaxSize__c = 10;
        insert oneClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 10; i++)
        {
            studentList.add(new Student__c(Name='Test ' + i, class__c = oneClass.id));
        }
        Database.SaveResult[] srList = Database.insert(studentList, false);
        Class__c cls = [SELECT MyCount__c FROM Class__c WHERE Id =: oneClass.id];
        System.assertEquals(10, srList.size());
        System.assertEquals(10, cls.MyCount__c);
    }
    
    // @isTest
    
}