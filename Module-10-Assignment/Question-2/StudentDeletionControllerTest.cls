/**
 * Test class to test the methods of StudentDeletionController.
 */ 
@isTest
public class StudentDeletionControllerTest 
{
    /**
     * Setup method to setup the data for testing.
     */ 
    @testSetup
    private static void testSetup()
    {
        Class__c newClass = new Class__c(Name = 'Test Class');
        insert newClass;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 5; i++)
        {
            Student__c oneStudent = new Student__c(Name = 'Test Student ' + i, Class__c = newClass.Id);
            studentList.add(oneStudent);
        }
        insert studentList;
    }
    
    /**
     * Test method to test the selected list of students.
     */ 
    @isTest
    private static void testGetSelectedStudentList()
    {
        String AppendingIds = '';
        for(Student__c oneStudent : [SELECT Id FROM Student__c])
        {
            AppendingIds += oneStudent.Id + ',';
        }
        if(AppendingIds.endsWith(','))
        {
            AppendingIds.removeEnd(',');
        }
        PageReference pref = Page.StudentPdfPage;
        pref.getParameters().put('recs', AppendingIds);
        Test.setCurrentPage(pref);
        StudentDeletionController controller = new StudentDeletionController();
        System.assertEquals(5, controller.selectedStudentsIds.size(), 'Students were not selected successfully.');
        System.assertEquals('Test Student 0', controller.getStudents().get(0).Name, 'Incorrect student is found.');
    }
    
    /**
     * Test method to check the redirection when the user clicks Continue and cancel buttons.
     */ 
    @isTest
    private static void testContinueDeletion()
    {
        String AppendingIds = '';
        for(Student__c oneStudent : [SELECT Id FROM Student__c])
        {
            AppendingIds += oneStudent.Id + ',';
        }
        if(AppendingIds.endsWith(','))
        {
            AppendingIds.removeEnd(',');
        }
        PageReference pref = Page.StudentPdfPage;
        pref.getParameters().put('recs', AppendingIds);
        Test.setCurrentPage(pref);
        StudentDeletionController controller = new StudentDeletionController();
        Test.startTest();
        pref = controller.redirect();
        System.assertEquals(pref.getUrl(), '/a0A', 'The page was not redirected to the expected page.');
        Test.stopTest();
    }
}