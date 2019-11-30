/**
 * Class to Control the actions of Purchase History Section.
 */ 
public class PurchaseHistoryController 
{
	public String sortBy = 'Order_Status';
	
	//Initializing StandardSetController
    public ApexPages.StandardSetController setCon 
    {
        get
        {
            if(setcon == null)
            {
                List<Purchase_Order__c> ordersPurchased = new List<Purchase_Order__c>();
                if('Order_Status'.equals(sortBy))
                {
                    ordersPurchased = [SELECT Name, Order_Price__c, Order_Status__c FROM Purchase_Order__c 
                                       ORDER BY Order_Status__c ASC];
                }
                else if('Order_Price'.equals(sortBy))
                {
                    ordersPurchased = [SELECT Name, Order_Price__c, Order_Status__c FROM Purchase_Order__c 
                                       ORDER BY Order_Price__c ASC];
                }
                setCon = new ApexPages.StandardSetController(ordersPurchased);   
                setCon.setPageSize(10);
            }
            return setCon;
        }
        set;
    }
    
    /**
     * Method to set sortBy to Order_Price
     */ 
    public void sortByOrderPrice()
    {
        this.sortBy = 'Order_Price';
    }
    
    /**
     * Method to set sortBy to Order_Status
     */
    public void sortByOrderStatus()
    {
        this.sortBy = 'Order_Status';
    }
    
    /**
     * This method returns the list of purchased orders.
     */
    public List<Purchase_Order__c> getPurchasedOrders()
    {
        setCon = null;
        return (List<Purchase_Order__c>)setCon.getRecords();
    }
    
    //Pagination Methods.
    public Integer getPageSize() {return setCon.getPageSize();}
    public Integer getPageNumber() {return setCon.getPageNumber();}
    public Integer getResultSize() {return setCon.getResultSize();}
    public void next() { setCon.next();}
    public void previous() { setCon.previous(); }
    public void first() { setCon.first(); }
    public void last() { setCon.last(); }
    public Boolean getHasNext() { return setCon.getHasNext(); }
    public Boolean getHasPrevious() { return setCon.getHasPrevious(); }
}