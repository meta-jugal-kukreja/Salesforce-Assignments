/**
 * Class to Control the actions of Purchase History Section.
 */ 
public class PurchaseHistoryController 
{
	public String sortBy = 'Order_Status__c';
    public Boolean sortAscending = false;
	List<Purchase_Order__c> ordersPurchased = new List<Purchase_Order__c>();
    
	//Initializing StandardSetController
    public ApexPages.StandardSetController setCon 
    {
        get
        {
            if(setcon == null)
            { 
                ordersPurchased = new PurchaseOrdersSelector().selectAllOrderBy(this.sortBy, this.sortAscending);
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
        this.setCon = null;
        this.sortAscending = !this.sortAscending;
        this.sortBy = 'Order_Price__c';
    }
    
    /**
     * Method to set sortBy to Order_Status
     */
    public void sortByOrderStatus()
    {
        this.setCon = null;
        this.sortAscending = !this.sortAscending;
        this.sortBy = 'Order_Status__c';
    }
    
    /**
     * This method returns the list of purchased orders.
     */
    public List<Purchase_Order__c> getPurchasedOrders()
    {
        return (List<Purchase_Order__c>)setCon.getRecords();
    }
    
    public void save()
    {
        update ordersPurchased;
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