/**
 * Class to inform Opportunity owners that there Opportunity is not modified in Last 30 days.
 */
global class SendEmailToOpptyOwner implements Database.Batchable<sObject>{
   global Database.QueryLocator start(Database.BatchableContext BC){
     return Database.getQueryLocator('SELECT Id, Owner.Email FROM Opportunity WHERE LastModifiedDate < LAST_N_DAYS:30');
   }
   global void execute(Database.BatchableContext BC, List<Opportunity > scope){
       List<String> toAddresses = new List<String>();
     for(Opportunity s : scope){
        toAddresses.add(s.Owner.Email);
     }
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       mail.setToAddresses(toAddresses);
       mail.setSubject('Your Opportunity is not modified in last 30 days');
       mail.setPlainTextBody('Your Opportunity is not modified in last 30 days');
       Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] { mail });
   }
   global void finish(Database.BatchableContext BC){
   }
}