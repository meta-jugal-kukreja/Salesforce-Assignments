/**
 * Test class to test the functionality of AccountContacts Class 
 */
@isTest
public class AccountContactsTest 
{
	@isTest
    private static void testWithOneContactId()
    {
        Account acc = new Account(Name='Test Account', ContactIds__c = null);
        insert acc;
        Contact con = new Contact(LastName='Test contact', AccountId=acc.id);
        insert con;
        Test.startTest();
        String resultantContactIds = AccountContacts.setContacts(con.id);
        Test.stopTest();
        System.assertEquals(con.id + ',', resultantContactIds);
    }
    
    @isTest
    private static void testWithBulkContactIds()
    {
        Account acc = new Account(Name='Test Account', ContactIds__c = null);
        insert acc;
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < 12; i++)
        {
            Contact oneContact = new Contact(LastName='Test contact ' + i, AccountId=acc.id);
            contactList.add(oneContact);
        }
        insert contactList;
        Test.startTest();
        String resultantContactIds = AccountContacts.setContacts(contactList.get(0).id);
        Test.stopTest();
        String testResult = '';
        for(Contact oneContact: contactList)
        {
            testResult += oneContact.id + ',';
        }
        System.assertEquals(testResult, resultantContactIds);
    }
    
    @isTest
    private static void testContactIdWithConatctIdsNotNull()
    {
        Account acc = new Account(Name='Test Account', ContactIds__c = null);
        insert acc;
        Contact contact1 = new Contact(LastName='Test contact 1', AccountId=acc.id);
        insert contact1;
        acc.ContactIDs__c = contact1.id + ',';
        update acc;
        Contact contact2 = new Contact(LastName='Test contact 2', AccountId=acc.id);
        insert contact2;
        Test.startTest();
        String resultantContactIds = AccountContacts.setContacts(contact2.id);
        Test.stopTest();
        System.assertEquals(contact1.id + ',' + contact2.id, resultantContactIds);
    }
}