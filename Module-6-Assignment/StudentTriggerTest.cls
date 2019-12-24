/**
* Test class for testing StudentTrigger.
*/
@isTest
public class StudentTriggerTest 
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
    @isTest
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
        Class__c cls = [SELECT MyCount__c, NumberOfStudents__c FROM Class__c WHERE Id =: oneClass.id];
        System.assertEquals(10, cls.NumberOfStudents__c, 'Number of students were not inserted as were required.');
    }
    
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
        List<Class__c> classList1 = [SELECT MyCount__c FROM Class__c WHERE Id =: classOne.Id];
        System.assertEquals(0, classList1.get(0).MyCount__c, 'Student was not updated');
        List<Class__c> classList2 = [SELECT MyCount__c FROM Class__c WHERE Id =: classTwo.Id];
        System.assertEquals(1, classList2.get(0).MyCount__c, 'Student was not update');
    }
    
    /**
     * Test to check updation of multiple student.
     */ 
    @isTest
    private static void updateMultipleStudentClass()
    {
        Class__c classOne = new Class__c(Name='Test Class 1');
        classOne.MaxSize__c = 15;
        insert classOne;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 12; i++)
        {
            studentList.add(new Student__c(Name='Test ' + i, class__c = classOne.id));
        }
        insert studentList;
        Class__c classTwo = new Class__c(Name='Test Class 2');
        classTwo.MaxSize__c = 15;
        insert classTwo;
       	for(Student__c oneStudent : studentList)
        {
            oneStudent.class__c = classTwo.id;
        }
        Database.SaveResult[] result = Database.update(studentList);
        List<Class__c> classList1 = [SELECT MyCount__c FROM Class__c WHERE Id =: classOne.Id];
        System.assertEquals(0, classList1.get(0).MyCount__c, 'Student was not updated');
        List<Class__c> classList2 = [SELECT MyCount__c FROM Class__c WHERE Id =: classTwo.Id];
        System.assertEquals(12, classList2.get(0).MyCount__c, 'Student was not update');
    }
}