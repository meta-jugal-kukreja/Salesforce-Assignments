/**
 * Controller for ContactForm Lightning Component.
 */ 
public with sharing class ContactCreateController 
{
    /**
     * Aura Enabled method to save the contact to the salesforce.
     */ 
	@AuraEnabled
    public static Contact saveContact(Contact newContact)
    {
        upsert newContact;
        return newContact;
    }
}