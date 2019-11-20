/**
 * Custom Controller for AccountsPage.
 */ 
public class ControllerForAccount 
{
    public String city{get; set;}
    public String state{get; set;}
    public String country{get; set;}
    public String accountsToShow{get; set;}
    public List<Account> accountsList{get; set;}
    public ApexPages.StandardSetController setCon{get; set;}
    public Integer ResultSize {get; set;}
    public Integer pageSize {get; set;}
    
    /**
     * Method to send account details to the visualforce page.
     */ 
    public void getAccounts() 
    {
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name, BillingCity, BillingState, BillingCountry FROM Account 
                                                                               WHERE BillingCity =: City AND BillingState =:state
                                                                               AND BillingCountry =:country]));
        resultSize = setCon.getResultSize();
        pageSize = 1;
        setCon.setPageSize(pageSize);
        accountsList = (List<Account>) setCon.getRecords();
        
    }
    
    /*
	 * Method to get custom pagination first page
	 */
    public void first() 
    {
        setcon.first();
        accountsList= (List<Account>)setCon.getRecords();
    }
    
    /*
	 * Method to get custom pagination last page
	 */
    public void last() 
    {
        setcon.last();
        accountsList= (List<Account>)setCon.getRecords();
    }
    
    /*
	 * Method to get custom pagination previous page
	 */
    public void previous() 
    {
        setcon.previous();
        accountsList= (List<Account>)setCon.getRecords();
    }
    
    /*
	 * Method to get custom pagination next page
	 */
    public void next() 
    {
        setcon.next();
        accountsList= (List<Account>)setCon.getRecords();
    } 
}
