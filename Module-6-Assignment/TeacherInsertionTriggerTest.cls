/**
* Test class to test TeacherInsertionTrigger.
*/
@isTest
public class TeacherInsertionTriggerTest 
{
    /**
     * Test method to check no insertion of teacher if that teacher is teaching 'Hindi'.
     */ 
    @isTest 
    static void testTeacherInsertionWithSubjectHindi() 
    {
        Contact con = new Contact(LastName = 'Contact 1', Experience__c = 1, Subject__C = 'Hindi;English');
        Database.saveResult result = Database.insert(con, false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }
    
    /**
     * Test method to check no updation of teacher data if that teacher's subject is changed to 'Hindi'.
     */ 
    @isTest 
    static void testTeacherUpdationWithSubjectUpdatedToHindi() 
    {
        Contact con = new Contact(LastName = 'Contact 1', Experience__c = 1, Subject__c = 'Maths;English');
        insert con;
        con.Subject__c = 'Hindi';
        Database.saveResult result = Database.update(con, false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }
    
    /**
     * Test method to check insertion of teacher if that teacher is teaching subjects other than 'Hindi'.
     */ 
    @isTest 
    static void testTeacherInsertionWithSubjectNotHindi() 
    {
        Contact con = new Contact(LastName = 'Contact 2', Experience__c = 2, Subject__C = 'English;Maths');
        insert con;
        Class__c cls = new Class__C(Name = 'Test Class', Custom_Status__c = 'New');
        insert cls;
        con.Description = 'Trigger test2';
        Database.saveResult result = Database.update(con, false);
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
}