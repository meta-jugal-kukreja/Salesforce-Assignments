/**
 * Test class for ManageClassController.
 */ 
@isTest
public class ManageClassControllerTest 
{
    /**
     * Setup method to setup data for tests.
     */ 
    @testSetup
    static void setUpTestdata() 
    {
    	Class__c testClass = new Class__c(Name = 'testClass');
        insert testClass;
    }
    
    /**
     * Test method to test the updation of class details.
     */ 
    @isTest
    static void testUpdateClass() 
    {
        ManageClassController controller = new ManageClassController();
        // call getClass method
        list<Class__c> allClasses = controller.getClasses();
        controller.ClassId = allClasses[0].Id;
        //call editClass method
        controller.editClass();
        controller.SelectedClass.Name = 'test1';
        controller.SelectedClass.Currency__c = 10000;
        controller.SelectedClass.MaxSize__c = 40;
        //call updateClassMethod
        controller.updateClass();
        allClasses = controller.getClasses();
        System.assertEquals(10000, allClasses[0].Currency__c,'Class not updated');
    }
    
    /**
     * Test method to test the deletion of class details.
     */
    @isTest
    static void testDeleteClass() 
    {
        ManageClassController controller = new ManageClassController();
        list<Class__c> allClasses = controller.getClasses();
        controller.ClassId = allClasses[0].Id;
        controller.deleteClass();
        allClasses = controller.getClasses();
        System.assertEquals(0, allClasses.size(),'Class not deleted');
    }
}