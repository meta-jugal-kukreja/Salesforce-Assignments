public with sharing class ContactCreateController 
{
	@AuraEnabled
    public static Contact saveContact(Contact newContact)
    {
        upsert newContact;
        return newContact;
    }
}