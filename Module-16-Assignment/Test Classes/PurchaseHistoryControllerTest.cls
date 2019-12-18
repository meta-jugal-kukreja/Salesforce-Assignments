@isTest
public class PurchaseHistoryControllerTest 
{
	/**
     * Method to initialize the data for the tests.
     */ 
    @testSetUp
    static void setupProductsHistory() 
    {
        List<Purchase_Order__c> productHistoryList = new List<Purchase_Order__c>();
        for(Integer i = 0 ; i < 101; i++)
        {
            productHistoryList.add(new Purchase_Order__c(Order_Status__c = 'Pending'));
        }
        insert productHistoryList;
    }
    
    /**
     * Test method to test sortBy variable set to 'Order_Price'.
     */ 
    @isTest
    private static void testOrderByPrice()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        PurchaseHistoryControllerobj.sortByOrderPrice();
        System.assertEquals('Order_Price__c', PurchaseHistoryControllerobj.sortBy, 'SortBy variable was not not set as expected.');
    }
    
    /**
     * Test method to test sortBy variable set to 'Order_Status'.
     */
    @isTest
    private static void testOrderByStatus()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        PurchaseHistoryControllerobj.sortByOrderStatus();
        System.assertEquals('Order_Status__c', PurchaseHistoryControllerobj.sortBy, 'SortBy variable was not not set as expected.');
    }
    
    /**
     * Test method to test size of PurchasedOrders List.
     */
    @isTest
    private static void testPurchasedOrdersListInAscendingOrder()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        PurchaseHistoryControllerobj.sortAscending = true;
        System.assertEquals(10, PurchaseHistoryControllerobj.getPurchasedOrders().size(), 'List was not formed as expected.');
    }
    
    /**
     * Test method to test size of PurchasedOrders List.
     */
    @isTest
    private static void testPurchasedOrdersListInDescendingOrder()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        PurchaseHistoryControllerobj.sortAscending = false;
        System.assertEquals(10, PurchaseHistoryControllerobj.getPurchasedOrders().size(), 'List was not formed as expected.');
    }
    
    /**
     * Test method to test Page Number of the Purchase history List.
     */ 
    @isTest
    private static void testGetPageNumber()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        System.assertEquals(1, PurchaseHistoryControllerobj.getPageNumber(), 'Page number was not as Expected');
    }
    
    /**
     * Test method to test Page Size of the Purchase history List.
     */ 
    @isTest
    private static void testGetPageSize()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        System.assertEquals(10, PurchaseHistoryControllerobj.getPageSize(), 'Page size was not as Expected');
    }
    
    /**
     * Test method to test Result Size of the Purchase history List.
     */
    @isTest
    private static void testGetResultSize()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        System.assertEquals(101, PurchaseHistoryControllerobj.getResultSize(), 'Result Size was not as Expected');
    }
    
    /**
     * Test method to test whether the page has more records next.
     */
    @isTest
    private static void testNext()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        PurchaseHistoryControllerobj.next();
        System.assertEquals(10, PurchaseHistoryControllerobj.getPurchasedOrders().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has more records previous.
     */
    @isTest
    private static void testPrevious()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        PurchaseHistoryControllerobj.previous();
        System.assertEquals(10, PurchaseHistoryControllerobj.getPurchasedOrders().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has records on first page.
     */
    @isTest
    private static void testFirst()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        PurchaseHistoryControllerobj.first();
        System.assertEquals(10, PurchaseHistoryControllerobj.getPurchasedOrders().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has records on last page.
     */
    @isTest
    private static void testLast()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        PurchaseHistoryControllerobj.last();
        System.assertEquals(1, PurchaseHistoryControllerobj.getPurchasedOrders().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has next page.
     */
    @isTest
    private static void testHasNext()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        System.assert(PurchaseHistoryControllerobj.getHasNext(), 'Some More data is present');
    }
    
    /**
     * Test method to test whether the page has previous page.
     */
    @isTest
    private static void testHasPrevious()
    {
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        System.assert(!PurchaseHistoryControllerobj.getHasPrevious(), 'Some More data is present');
    }
}