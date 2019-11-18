/**
* Class to set contactIds of Account
* */
public class AccountContacts 
{
   /*
    * Used to set ContactIds to contact list if null otherwise set with contactId.
    **/
   public static void setContacts(Id contactId) 
   {
       Contact con = [SELECT AccountId from Contact Where Id = :contactID] ;
       Account acc = [SELECT Id, ContactIds__c from Account Where Id = :con.AccountId];
       if(acc.ContactIDs__c == null) 
       {
           List<Contact> contacts = [Select Id from Contact Where AccountID = :acc.Id];
           String result = '';
           for (Integer i = 0; i < contacts.size(); i++) 
           {
               Contact cont = contacts.get(i);
               if(i == contacts.size() - 1)
               {
                   result = result + cont.Id;
               }
               else
               {
                   result = result + cont.Id + ',';
               }  
           }
           acc.ContactIDs__c = result;
       } 
       else 
       {
           if(!acc.ContactIDs__c.contains(contactId))
           {
               acc.ContactIDs__c =   acc.ContactIDs__c + ',' + contactId;
           }
       }
       update acc;
   }
}