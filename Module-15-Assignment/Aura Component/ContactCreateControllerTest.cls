/**
 * Test class for ContactCreateController.
 */ 
@isTest
public class ContactCreateControllerTest 
{
    /**
     * Test method to test the creation of contact is not present before.
     */ 
	@isTest
    private static void testSaveContactWhenContactIsNotPresent()
    {
        ContactCreateController.saveContact(new Contact(LastName = 'Test LastName'));
        Contact newContact = [SELECT LastName FROM Contact];
        System.assertEquals('Test LastName', newContact.LastName, 'Contact created was not as expected');
    }
    
    /**
     * Test method to test the updation of contact is present before.
     */ 
    @isTest
    private static void testSaveContactWhenContactIsPresent()
    {
        Contact oneContact = new Contact(LastName = 'Test LastName');
        insert oneContact;
        oneContact.FirstName = 'Test FirstName';
        ContactCreateController.saveContact(oneContact);
        Contact newContact = [SELECT FirstName, LastName FROM Contact];
        System.assertEquals('Test FirstName', newContact.FirstName, 'Contact created was not as expected');
        System.assertEquals('Test LastName', newContact.LastName, 'Contact created was not as expected');
    }
}