/**
 * Test class to test TeacherInsertionTrigger.
 */
@isTest
public class TeacherInsertionTriggerTest 
{
	 @isTest 
    static void restrictTeacherActionTest1() 
    {
        Contact con = new Contact(LastName = 'Contact 1', Experience__c = 1, Subject__C = 'Hindi;English');
        Database.saveResult result = Database.insert(con, false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }
    
    @isTest 
    static void restrictTeacherActionTest2() 
    {
        Contact con = new Contact(LastName = 'Contact 1', Experience__c = 1, Subject__C = 'Maths;English');
        insert con;
        con.Subject__c = 'Hindi';
        Test.startTest();
        Database.saveResult result = Database.update(con, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }
   
     @isTest 
    static void restrictTeacherActionTest3() 
    {
        Contact con = new Contact(LastName = 'Contact 2', Experience__c = 2, Subject__C = 'English;Maths');
        insert con;
        Class__c cls = new Class__C(Name = 'Test Class', Custom_Status__c = 'New');
        insert cls;
        con.Description = 'Trigger test2';
        Test.startTest();
        Database.saveResult result = Database.update(con, false);
        Test.stopTest();
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
}