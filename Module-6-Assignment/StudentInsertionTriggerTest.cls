/**
* Test class for testing StudentInsertionTrigger.
*/
@isTest
public class StudentInsertionTriggerTest 
{
    /**
     * Test to check insertion of zero students.
     */ 
    @isTest
    private static void insertZeroStudentTest()
    {
        Class__c oneClass = new Class__c(Name='Test Class');
        oneClass.MaxSize__c = 0;
        insert oneClass;
        Student__c oneStudent = new Student__c(Name='Test Student', Class__c=oneClass.id);
        Database.SaveResult result  = Database.insert(oneStudent, false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }
    
    /**
     * Test to check insertion of one student.
     */ 
    @isTest
    private static void insertOneStudentTest()
    {
        Class__c oneClass = new Class__c(Name='Test Class');
        oneClass.MaxSize__c = 1;
        insert oneClass;
        Student__c oneStudent = new Student__c(Name='Test Student', Class__c=oneClass.id);
        Database.SaveResult result  = Database.insert(oneStudent, false);
        List<Class__c> classList = [SELECT NumberOfStudents__c FROM Class__c WHERE Id =: oneClass.Id];
        System.assertEquals(1, classList.get(0).NumberOfStudents__c , 'Student was not inserted');
    }
    
    /**
     * Test to check insertion of multiple students.
     */ 
    /*@isTest
    private static void insertStudentInBulkTest()
    {
        Class__c oneClass = new Class__c(Name='Test Class');
        oneClass.MaxSize__c = 10;
        insert oneClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 12; i++)
        {
            studentList.add(new Student__c(Name='Test ' + i, class__c = oneClass.id));
        }
        Database.SaveResult[] srList = Database.insert(studentList, false);
        Class__c cls = [SELECT MyCount__c FROM Class__c WHERE Id =: oneClass.id];
        //System.assertEquals(10, srList.size());
        System.assertEquals(10, cls.MyCount__c);
    }*/
    
    /**
     * Test to check updation of one student.
     */ 
    @isTest
    private static void updateOneStudentClass()
    {
        Class__c classOne = new Class__c(Name='Test Class 1');
        classOne.MaxSize__c = 1;
        insert classOne;
        Student__c oneStudent = new Student__c(Name='Test Student', Class__c=classOne.id);
        insert oneStudent;
        Class__c classTwo = new Class__c(Name='Test Class 2');
        classTwo.MaxSize__c = 1;
        insert classTwo;
        oneStudent.class__c = classTwo.Id;
        Database.SaveResult result = Database.update(oneStudent);
        List<Class__c> classList1 = [SELECT NumberOfStudents__c FROM Class__c WHERE Id =: classOne.Id];
        System.assertEquals(0, classList1.get(0).NumberOfStudents__c, 'Student was not updated');
        List<Class__c> classList2 = [SELECT NumberOfStudents__c FROM Class__c WHERE Id =: classTwo.Id];
        System.assertEquals(1, classList2.get(0).NumberOfStudents__c, 'Student was not update');
    }
    
}