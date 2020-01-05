/**
 * Controller for BillToContactLookUp page
 */ 
public class BillToContactLookUpController 
{
    public Id lookUpBillToContact {get;set;}
    public Opportunity currentOpportunity;
    //Getting the Id of the current User.
    public Id currentOpportunityId 
    {
        get 
        {
            return Id.valueOf(ApexPages.CurrentPage().getparameters().get('Id'));
        }
        set;
    }
    
    /**
     * Constructor to initialize the current opoortunity list.
     */ 
    public BillToContactLookUpController()
    {
        currentOpportunity = [SELECT Manager__c, BillToContact__c, BillToContact__r.Name
                              FROM Opportunity 
                              WHERE Id =: currentOpportunityId];
    }
    
    /**
     * Method to return the list of Contacts related to current Opportunity's manager.
     */ 
    public List<Contact> getContactList()
    {
        List<Contact> contactList = [SELECT Id, Name, Experience__c, Birthdate, Email FROM Contact WHERE AccountId =: currentOpportunity.Manager__c];
        return contactList;
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