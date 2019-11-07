global class sendEmailToOpptyOwner implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){
     return Database.getQueryLocator('SELECT Id,ownerID FROM Opportunity WHERE LastModifiedDate = LAST_N_DAYS:30');
   }

   global void execute(Database.BatchableContext BC, List<Opportunity > scope){
     for(Opportunity s : scope){
       //Write the logic to send email to the opportunity owner
     }
   }

   global void finish(Database.BatchableContext BC){
   }
}