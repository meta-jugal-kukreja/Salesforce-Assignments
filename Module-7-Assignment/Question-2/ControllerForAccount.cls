/**
 * Custom Controller for AccountsPage.
 */ 
public class ControllerForAccount 
{
    public String city{get; set;}
    public String state{get; set;}
    public String country{get; set;}
    public List<Account> accountsList{get; set;}
    public ApexPages.StandardSetController setCon{get; set;}
    public Integer ResultSize {get; set;}
    public Integer pageSize {get; set;}
    public Integer pageNumber {get; set;}
    public Boolean showAccountsList{get; set;}
    
    /**
     * Constructor to initialise the data members.
     */ 
    public ControllerForAccount()
    {
        this.ResultSize = 0;
        this.pageSize = 0;
        this.pageNumber = 0;
        this.showAccountsList = false;
    }
    
    /**
     * Method to send account details to the visualforce page.
     */ 
    public void getAccounts() 
    {  
        if(!String.isBlank(city) || !String.isBlank(state) || !String.isBlank(country)) 
        {
            String query = 'SELECT Name, BillingCity, BillingState, BillingCountry FROM Account ';
            query += 'WHERE' ;
            query += String.isBlank(city) ? '' : ' BillingCity LIKE ' + '\'%' + city + '%\'' + ' AND ';
            query += String.isBlank(state)? '' : ' BillingState LIKE ' + '\'%' + state + '%\'' + ' AND ';
            query += String.isBlank(country)? '' : ' BillingCountry LIKE ' + '\'%' + country + '%\'';
            if(query.endsWith('AND ')) 
            {
                query = query.substring(0, query.length()-4);
            }
            setCon = new ApexPages.StandardSetController(Database.query(query));
            resultSize = setCon.getResultSize();
            pageSize = 10;
            setCon.setPageSize(pageSize);
            pageNumber = setCon.getPageNumber();
            accountsList = (List<Account>) setCon.getRecords();
            if(accountsList.size() > 0)
            {
                this.showAccountsList = true;
            }
            else
            {
                this.showAccountsList = false;
            }
        }
        else
        {
            this.showAccountsList = false;
        }
    }
       
    /*
	 * Method to get custom pagination first page
	 */
    public void first() 
    {
        setcon.first();
        pageNumber = setCon.getPageNumber();
        accountsList = (List<Account>)setCon.getRecords();
    }
    
    /*
	 * Method to get custom pagination last page
	 */
    public void last() 
    {
        setcon.last();
        pageNumber = setCon.getPageNumber();
        accountsList = (List<Account>)setCon.getRecords();
    }
    
    /*
	 * Method to get custom pagination previous page
	 */
    public void previous() 
    {
        setcon.previous();
        pageNumber = setCon.getPageNumber();
        accountsList = (List<Account>)setCon.getRecords();
    }
    
    /*
	 * Method to get custom pagination next page
	 */
    public void next() 
    {
        setcon.next();
        pageNumber = setCon.getPageNumber();
        accountsList = (List<Account>)setCon.getRecords();
    } 
}