/**
* Test class to test TeacherInsertionTrigger.
*/
@isTest
public class TeacherInsertionTriggerTest 
{
    /**
     * Test method to check no insertion of one teacher if that teacher is teaching 'Hindi'.
     */ 
    @isTest 
    static void testOneTeacherInsertionWithSubjectHindi() 
    {
        Contact con = new Contact(LastName = 'Contact 1' , Experience__c = 1 , Subject__C = 'Hindi;English');
        Database.saveResult result = Database.insert(con , false);
        System.assert(!result.isSuccess() , 'The teacher was inserted succesfully');
        System.assert(result.getErrors().size() > 0 , 'There was no Error while inserting the teacher.');
        System.assertEquals('Cannot Insert or Update teacher if that teacher is teaching Hindi.' , 
                      result.getErrors().get(0).getMessage() , 'There was no Error while inserting the teacher.');
    }
    
    /**
     * Test method to check no insertion of a teacher if a teacher in the teacher list is teaching 'Hindi'.
     */ 
    @isTest 
    static void testTeacherInsertionInBulkWithSubjectHindi() 
    {
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < 101; i++)
        {
            contactList.add(new Contact(LastName = 'Contact ' + i , Experience__c = 1 , Subject__C = 'Hindi;English'));
        }
        List<Database.saveResult> resultList = Database.insert(contactList , false);
        for(Database.SaveResult result : resultList)
        {
            System.assert(!result.isSuccess() , 'The teacher was inserted succesfully');
            System.assert(result.getErrors().size() > 0 , 'There was no Error while inserting the teacher.');
            System.assertEquals('Cannot Insert or Update teacher if that teacher is teaching Hindi.' , 
                      result.getErrors().get(0).getMessage() , 'There was no Error while inserting the teacher.');
        }
    }
    
    /**
     * Test method to check no updation of teacher data if that teacher's subject is changed to 'Hindi'.
     */ 
    @isTest 
    static void testOneTeacherUpdationWithSubjectUpdatedToHindi() 
    {
        Contact con = new Contact(LastName = 'Contact 1', Experience__c = 1, Subject__c = 'Maths;English');
        insert con;
        con.Subject__c = 'Hindi';
        Database.saveResult result = Database.update(con, false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }
    
    /**
     * Test method to check no insertion of a teacher if a teacher in the teacher list is teaching 'Hindi'.
     */ 
    @isTest 
    static void testTeacherUpdationInBulkWithSubjectUpdatedToHindi() 
    {
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < 101; i++)
        {
            contactList.add(new Contact(LastName = 'Contact ' + i , Experience__c = 1 , Subject__C = 'Maths;English'));
        }
        insert contactList;
        for(Contact oneContact : contactList)
        {
            oneContact.Subject__c = 'Hindi';
        }
        List<Database.saveResult> resultList = Database.update(contactList , false);
        for(Database.SaveResult result : resultList)
        {
            System.assert(!result.isSuccess() , 'The teacher was inserted succesfully');
            System.assert(result.getErrors().size() > 0 , 'There was no Error while inserting the teacher.');
            System.assertEquals('Cannot Insert or Update teacher if that teacher is teaching Hindi.' , 
                      result.getErrors().get(0).getMessage() , 'There was no Error while inserting the teacher.');
        }
    }
    
    /**
     * Test method to check insertion of teacher if that teacher is teaching subjects other than 'Hindi'.
     */ 
    @isTest 
    static void testOneTeacherInsertionWithSubjectNotHindi() 
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
    
    /**
     * Test method to check insertion of teachers in bulk if that teachers are teaching subjects other than 'Hindi'.
     */ 
    @isTest 
    static void testTeacherInsertionInBulkWithSubjectNotHindi() 
    {
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < 101; i++)
        {
            contactList.add(new Contact(LastName = 'Contact ' + i , Experience__c = 1 , Subject__C = 'Maths;English'));
        }
        insert contactList;
        Class__c cls = new Class__C(Name = 'Test Class', Custom_Status__c = 'New');
        insert cls;
        List<Database.saveResult> resultList = Database.update(contactList, false);
        for(Database.SaveResult result : resultList)
        {
            System.assert(result.isSuccess() , 'The Teacher was not inserted succesfully');
            System.assert(result.getErrors().size() == 0 , 'There was an Error while inserting the teacher.');
        }
    }
}