/**
 * Controller for BillToContactLookUp page
 */ 
public class BillToContactLookUpController 
{
    public Id lookUpBillToContact {get;set;}
    Opportunity currentOpportunity;
    //Getting the Id of the current User.
    public Id currentOpportunityId 
    {
        get 
        {
            return Id.valueOf(ApexPages.CurrentPage().getparameters().get('Id'));
        }
        set;
    }
    
    public BillToContactLookUpController()
    {
        currentOpportunity = [SELECT Manager__c, BillToContact__c FROM Opportunity WHERE Id =: currentOpportunityId];
    }
    /**
     * This method generates the list of contacts associated with the Opportunity's Manager and makes options for selection.
     */ 
    public List<SelectOption> getContactOptions()
    {
        List<SelectOption> contactOptions = new List<SelectOption>();
        List<Contact> contactList = [SELECT Id, Name FROM Contact WHERE AccountId =: currentOpportunity.Manager__c];
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
        currentOpportunity.BillToContact__c = lookUpBillToContact;
        update currentOpportunity;
        return (new PageReference('/' + currentOpportunityId));
    }
    
    /**
     * This method serves as action when clear button is clicked.
     * This method populates the BillTOContact__c field with null and redirects to the details page.
     */ 
    public PageReference clear()
    {
        currentOpportunity.BillToContact__c = null;
        update currentOpportunity;
        return (new PageReference('/' + currentOpportunityId));
    }
    
    /**
     * This method serves as action when cancel button is clicked.
     * This method redirects to the details page.
     */ 
    public PageReference cancel()
    {
        return (new PageReference('/' + currentOpportunityId));
    }
}