/**
 * Class to execute the SendEmailToOpptyOwner class operations in batches.
 */
global class ScheduledBatchable implements Schedulable {
   global void execute(SchedulableContext sc) {
      sendEmailToOpptyOwner b = new sendEmailToOpptyOwner(); 
      database.executebatch(b);
   }
}