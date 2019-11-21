/**
 * Test class for ManageClassController.
 */ 
@isTest
public class ManageClassControllerTest 
{
    /**
     * Test Method to test the updation of class details.
     */ 
	@isTest
    private static void testSaveDetails()
    {
        Contact con = new Contact(LastName = 'Test Contact');
        insert con;
        Class__c newClass = new Class__c(Name = 'Test Class', ClassTeacher__c = con.Id);
        insert newClass;
        PageReference pref = Page.manageClass;
        pref.getParameters().put('id', newClass.Id);
        Test.setCurrentPage(pref);
        ManageClassController controller = new ManageClassController();
        Test.startTest();
        controller.classId = newClass.Id;
        controller.className = 'New Class Name';
        controller.classDescription = 'New Class description';
        controller.classFee = '12345';
        controller.classMaxSize = '12';
        pref = controller.SaveDetails();
        System.assertEquals(pref.getUrl(), 'https://c.ap15.visual.force.com/apex/manageClass?core.apexpages.request.devconsole=1', 
                            'Page was not redirected as expected.');
        System.assertEquals('New Class Name', [SELECT Name FROM Class__c WHERE Id =: newClass.Id].Name, 
                            'Class was not succesfully updated');
        Test.stopTest();
    }
    
    /**
     * Test Method to test the deletion of class.
     */ 
    @isTest
    private static void testclassDeletion()
    {
        Contact con = new Contact(LastName = 'Test Contact');
        insert con;
        Class__c newClass = new Class__c(Name = 'Test Class', ClassTeacher__c = con.Id);
        insert newClass;
        PageReference pref = Page.manageClass;
        pref.getParameters().put('id', newClass.Id);
        Test.setCurrentPage(pref);
        ManageClassController controller = new ManageClassController();
        Test.startTest();
        controller.classId = newClass.Id;
        pref = controller.deleteClass();
        System.assertEquals(pref.getUrl(), 'https://c.ap15.visual.force.com/apex/manageClass?core.apexpages.request.devconsole=1', 
                            'Page was not redirected as expected.');
        System.assertEquals(0, [SELECT Name FROM Class__c WHERE Id =: newClass.Id].Size(), 
                            'Class was not succesfully deleted');
        Test.stopTest();
    }
}