/**
 * Controller for BillToContactLookUp page
 */ 
public class BillToContactLookUpController 
{
    public Id lookUpBillToContact {get;set;}
    //Getting the Id of the current User.
    public Id currentAccountId 
    {
        get 
        {
            return Id.valueOf(ApexPages.CurrentPage().getparameters().get('Id'));
        }
        set;
    }
    
    /**
     * This method generates the list of contacts associated with the Manager and makes options for selection.
     */ 
    public List<SelectOption> getContactOptions()
    {
        List<SelectOption> contactOptions = new List<SelectOption>();
        Opportunity oneOpportunity = [SELECT Manager__c FROM Opportunity WHERE Id =: currentAccountId];
        List<Contact> contactList = [SELECT Id, Name FROM Contact WHERE AccountId =: oneOpportunity.Manager__c];
        for(Contact oneContact : contactList)
        {
            contactOptions.add(new SelectOption(oneContact.Id, oneContact.Name));
        }
        return contactOptions;
    }
    
    /**
     * This method serves as action when save button is clicked.
     * This method populates the BillTOContact__c field with the option selected on the visualforce page and redirects to the details page.
     */ 
    public PageReference save()
    {
        Opportunity opp = [SELECT BillToContact__c FROM Opportunity WHERE Id =: currentAccountId];
        opp.BillToContact__c = lookUpBillToContact;
        update opp;
        return (new PageReference('/' + currentAccountId));
    }
    
    /**
     * This method serves as action when clear button is clicked.
     * This method populates the BillTOContact__c field with null and redirects to the details page.
     */ 
    public PageReference clear()
    {
        Opportunity opp = [SELECT BillToContact__c FROM Opportunity WHERE Id =: currentAccountId];
        opp.BillToContact__c = null;
        update opp;
        return (new PageReference('/' + currentAccountId));
    }
    
    /**
     * This method serves as action when cancel button is clicked.
     * This method redirects to the details page.
     */ 
    public PageReference cancel()
    {
        return (new PageReference('/' + currentAccountId));
    }
}