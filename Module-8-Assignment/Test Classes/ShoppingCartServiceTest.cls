/**
 * Test class to test ShoppingCartService class.
 */ 
@isTest
public class ShoppingCartServiceTest 
{
    /**
     * Test method to test records of Purchase History.
     */ 
	@isTest
    private static void testRecordsOfPurchaseHistory()
    {
        List<Purchase_Order__c> productHistoryList = new List<Purchase_Order__c>();
        for(Integer i = 0 ; i < 101; i++)
        {
            productHistoryList.add(new Purchase_Order__c(Order_Status__c = 'Pending'));
        }
        insert productHistoryList;
        PurchaseHistoryController PurchaseHistoryControllerobj = new PurchaseHistoryController();
        ShoppingCartService shoppingCartServiceobj = new ShoppingCartService();
        List<Purchase_Order__c> records = new List<Purchase_Order__c>();
        records = (List<Purchase_Order__c>)shoppingCartServiceobj.getRecords(PurchaseHistoryControllerobj.setCon);
        System.assertEquals(10, records.size(), 'Purchase History List was not formed as expected');
    }
    
    /**
     * Test method to test records of Products.
     */ 
	@isTest
    private static void testRecordsOfProducts()
    {
        List<Product2> productStockList = new List<Product2>();
        for(Integer i = 0 ; i < 101; i++)
        {
            productStockList.add(new Product2(Name = 'Test Product ' + (i+1) , 
                                              ProductCode = 'PCode' + (i+1) ,
                                              Description = 'Test product data' ,
                                              Price__c = 50 * (i+1) ,
                                              Quantity__c = i));
        }
        insert productStockList;
        ProductsController productObj = new ProductsController();
        ShoppingCartService shoppingCartServiceobj = new ShoppingCartService();
        List<Product2> records = new List<Product2>();
        records = (List<Product2>)shoppingCartServiceobj.getRecords(productObj.setCon);
        System.assertEquals(10, records.size(), 'Products List was not formed as expected');
    }
}