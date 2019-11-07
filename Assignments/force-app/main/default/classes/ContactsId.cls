/**
 * Class to set ContactIds__c field in the Account
**/
public class ContactsId {
    
    /**
     * This is the main method which calls makeList and UpdateList method to perform the functionality
     * @param contactId is the contact id to be checked
    **/ 
    public static void setContactIds(ID contactId)
    {
        List<Contact> listContacts = [SELECT Account.Id, Account.ContactIDs__c FROM Contact WHERE id =: contactId];
        ID accountId = listContacts.get(0).Account.Id;
        String resultantContactId = listContacts.get(0).Account.ContactIDs__c;
        if(resultantContactId == null)
        {
            makeList(contactId, accountId);
        }
        else
        {
            updateList(contactId, accountId);
        }
    }
    
    /**
 	 * Method to make ContactIds list and add it to the Account object if the ContactIds__c field is null
 	 * @param contactId is the contact Id to be checked
	**/
    private static void makeList(ID contactId, ID accountId)
    {
        String result = '';
        List<Account> listAccounts = [SELECT id, (SELECT id FROM Contacts) FROM Account WHERE id =: accountId];
        for(Integer i = 0; i < listAccounts.get(0).Contacts.size(); i++)
        {
            if(i == listAccounts.get(0).Contacts.size()-1)
            {
                result = result + listAccounts.get(0).Contacts.get(i).id;
            }
            else
            {
                result = result + listAccounts.get(0).Contacts.get(i).id + ' , ';
            }
        }
        Account acc = new Account(id=accountId);
        acc.ContactIDs__c = result;
        upsert acc;
    }
    
    /**
 	 * Method to update ContactIds list and update it to the Account object if the ContactIds__c field is not null and contact is not present in the ContactIds__c Field
 	 * @param contactId is the contact Id to be checked
	**/
    private static void updateList(ID contactId, ID accountId)
    {
        List<Account> listAccounts = [SELECT id, ContactIds__c FROM Account WHERE id =: accountId];
        String ContactIds = listAccounts.get(0).ContactIds__c;
        if(!ContactIds.contains(String.valueOf(contactId)))
        {
            ContactIds = ContactIds + ' , ' + String.valueOf(contactId);
            Account acc = new Account(id=accountId);
            acc.ContactIDs__c = ContactIds;
            upsert acc;
        }
        else
        {
            System.debug('Id Already present in the list');
        }
    }

}