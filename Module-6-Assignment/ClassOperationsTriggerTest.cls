/**
* Test Class for testing ClassOperationsTrigger.
*/
@isTest
public class ClassOperationsTriggerTest {
    
    /**
	  * Test method to check change of Custom_Status__c field to 'Reset'.(In Before trigger)
	 */ 
    @isTest
    private static void testCustomStatusFieldChangedFromNewToReset()
    {
        Class__c oneClass = new Class__c(Name = 'Test Class' , Custom_Status__c = 'New');
        oneClass.MaxSize__c = 100;
        insert oneClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 101 ; i++)
        {
            studentList.add(new Student__c(Name='Test ' + i , Class__c = oneClass.Id));
        }
        insert studentList;
        oneClass.Custom_Status__c = 'Reset';
        Database.update(oneClass);
        System.assertEquals(0, [SELECT COUNT() FROM Student__c WHERE Class__c =: oneClass.Id], 
                            'Students were not deleted from the class when its Custom_Status_Field is changed to \'Reset\'');
    }
    
    /**
     * Test method to test class deleion when more than one female student is present.
     */ 
    @isTest
    private static void testClassDeletionWhenMorethanOneFemaleStudentIsThere()
    {
        Class__c oneClass = new Class__c(Name = 'Test Class' , Custom_Status__c = 'New');
        oneClass.MaxSize__c = 100;
        insert oneClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 10; i++)
        {
            if(math.mod(i , 2) == 0)
            {
                studentList.add(new Student__c(Name='Test ' + i , Class__c = oneClass.Id , Sex__c = 'Male'));
            }
            else
            {
                studentList.add(new Student__c(Name='Test ' + i , Class__c = oneClass.Id , Sex__c = 'Female'));
            }
        }
        insert studentList;
        Database.DeleteResult result = Database.delete(oneClass , false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }

	 /**
     * Test method to test class deleion when no female student is present.
     */     
    @isTest
    private static void testClassDeletionWhenNoFemaleStudentIsPresent()
    {
        Class__c oneClass = new Class__c(Name = 'Test Class' , Custom_Status__c = 'New');
        oneClass.MaxSize__c = 100;
        insert oneClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 10; i++)
        {
            studentList.add(new Student__c(Name='Test ' + i , class__c = oneClass.Id , Sex__c = 'Male'));
        }
        insert studentList;
        Database.DeleteResult result = Database.delete(oneClass , false);
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
}