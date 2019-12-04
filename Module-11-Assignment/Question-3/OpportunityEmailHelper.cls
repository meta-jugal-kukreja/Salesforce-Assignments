/**
 * Helper class to send email to the user.
 */ 
public class OpportunityEmailHelper 
{
    /**
     * This method sends the email to the opportunity owner.
     */ 
    public static void sendEmail(Opportunity opp) 
    {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String emailId = [SELECT Email FROM User Where Id =: opp.OwnerId].Email;
        // dummy contact
        Contact dummyContact = new Contact();
        dummyContact.LastName = 'dummy';
        dummyContact.Email = emailId;
        insert dummyContact;
        email.setTargetObjectId(dummyContact.Id);
        EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE Name = 'Opportunity Status Changed' LIMIT 1];
        email.setTemplateId(template.Id);
        email.setWhatId(opp.Id);
        email.setSenderDisplayName('Salesforce Support');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        delete dummyContact;
    }
}