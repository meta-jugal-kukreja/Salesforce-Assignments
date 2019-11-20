/**
 * Test class to test StudentPdfController.
 */ 
@isTest
public class StudentPdfControllerTest 
{
    /**
     * Method to test the generation of Pdf file.
     */ 
	@isTest
    private static void testPdfGeneration()
    {
        Class__c oneClass = new Class__c(Name = 'Test Class');
        insert oneClass;
        Student__c oneStudent = new Student__c(Name = 'Test student', Class__c = oneClass.Id);
        insert oneStudent;
        PageReference pref = Page.StudentPdfPage;
        pref.getParameters().put('id',oneStudent.Id);
    	Test.setCurrentPage(pref);
        StudentPdfController spc = new StudentPdfController();
        Test.startTest();
        spc.currentStudentId = oneStudent.Id;
        pref = spc.savePdf();
        System.assertEquals(pref.getUrl(), '/'+oneStudent.Id, 'The page was not redirected to the expected page.');
		System.assertEquals(1,[SELECT COUNT() FROM Attachment WHERE ParentId =: oneStudent.Id], 'Attachment was not formed as expected');
        Test.stopTest();
    }
}