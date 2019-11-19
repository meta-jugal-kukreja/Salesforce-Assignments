/**
 * Test class to test the functionality of AccountContacts Class 
 */
@isTest
public class AccountContactsTest 
{
    /**
     * Method to test the formation of ContactIds field value with one contact in the account when ContactIds field is null.
     */
	@isTest
    private static void testWithOneContactId()
    {
        Account acc = new Account(Name='Test Account', ContactIds__c = null);
        insert acc;
        Contact con = new Contact(LastName='Test contact', AccountId = acc.Id);
        insert con;
        AccountContacts.setContacts(con.id);
        Account resultantAccount = [SELECT ContactIDs__c FROM Account WHERE Id =: acc.Id];
        System.assertEquals(con.id, resultantAccount.ContactIDs__c, 'ContactIds field is not formed as expected');
    }
    
    /**
     * Method to test the formation of ContactIds field value with multiple contact in the account  when ContactIds field is null.
     */
    @isTest
    private static void testWithBulkContactIds()
    {
        Account acc = new Account(Name='Test Account', ContactIds__c = null);
        insert acc;
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < 10; i++)
        {
            Contact oneContact = new Contact(LastName = 'Test contact ' + i, AccountId = acc.id);
            contactList.add(oneContact);
        }
        insert contactList;
       	AccountContacts.setContacts(contactList.get(0).id);
        Account resultantAccount = [SELECT ContactIDs__c FROM Account WHERE Id =: acc.Id];
        String testResult = '';
        for(Integer i = 0; i < contactList.size(); i++)
        {
            Contact oneContact = contactList.get(i);
            if(i == contactList.size() - 1)
            {
                testResult += oneContact.id;
            }
            else
            {
                testResult += oneContact.id + ',';
            }  
        }
        System.assertEquals(testResult, resultantAccount.ContactIDs__c, 'ContactIds field is not formed as expected');
    }
    
    /**
     * Method to test the formation of ContactIds field value with one contact in the account when ContactIds field is not null.
     */
    @isTest
    private static void testOneContactIdWithContactIdsNotNull()
    {
        Account acc = new Account(Name = 'Test Account', ContactIds__c = null);
        insert acc;
        Contact contact1 = new Contact(LastName = 'Test contact 1', AccountId = acc.id);
        insert contact1;
        acc.ContactIDs__c = contact1.id;
        update acc;
        Contact contact2 = new Contact(LastName = 'Test contact 2', AccountId = acc.id);
        insert contact2;
        AccountContacts.setContacts(contact2.id);
        Account resultantAccount = [SELECT ContactIDs__c FROM Account WHERE Id =: acc.Id];
        System.assertEquals(contact1.id + ',' + contact2.id, resultantAccount.ContactIDs__c, 'ContactIds field is not formed as expected');
    }
    
    /**
     * Method to test the formation of ContactIds field value with multiple contact in the account when ContactIds field is not null.
     */
    @isTest
    private static void testMultipleContactIdWithContactIdsNotNull()
    {
        Account acc = new Account(Name = 'Test Account', ContactIds__c = null);
        insert acc;
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < 10; i++)
        {
            Contact oneContact = new Contact(LastName = 'Test contact ' + i, AccountId = acc.id);
            contactList.add(oneContact);
        }
        insert contactList;
        String resultantString = '';
        for(Integer i = 0; i < contactList.size(); i++)
        {
            Contact oneContact = contactList.get(i);
            if(i == contactList.size() - 1)
            {
                resultantString += oneContact.id;
            }
            else
            {
                resultantString += oneContact.id + ',';
            }  
        }
        acc.ContactIDs__c = resultantString;
        update acc;
        Contact contact2 = new Contact(LastName = 'Test contact 2', AccountId = acc.Id);
        insert contact2;
        AccountContacts.setContacts(contact2.Id);
        Account resultantAccount = [SELECT ContactIDs__c FROM Account WHERE Id =: acc.Id];
        System.assertEquals(resultantString + ',' + contact2.id, resultantAccount.ContactIDs__c, 'ContactIds field is not formed as expected');
    }
}