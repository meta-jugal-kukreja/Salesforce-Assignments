/**
 * Test class to test CheckoutController.
 */ 
@isTest
public class CheckoutControllerTest 
{
    /**
     * Method to initialize the data for the tests.
     */ 
    @testSetUp 
    static void setup_products()
    {
        List<Product2> productStockList = new List<Product2>();
        for(Integer i = 0 ; i < 101 ; i++)
        {
            productStockList.add(new Product2(Name = 'Test Product ' + (i+1) , 
                                              ProductCode = 'PCode' + (i+1) ,
                                              Description = 'Test product data' ,
                                              Price__c = 50 * (i+1) ,
                                              Quantity__c = i));
        }
        insert productStockList;
    } 
    
    /**
     * Test method to test the amount of the order when the cart list or product wrappe list is not null.
     */ 
    @isTest
    static void totalAmountTestWhenProductWrapperListIsNotNull() 
    {
        List<Product2> productStockList = [SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2];
        List<ProductWrapper> productWrapperList = new List<ProductWrapper>();
        for(Product2 product : productStockList) 
        {
            ProductWrapper prod = new ProductWrapper(product , false);
            prod.quantity = 1;
            productWrapperList.add(prod);
        }
        CheckoutController checkoutObj = new CheckoutController();
        Decimal result = checkoutObj.calculateTotalAmount(productWrapperList);
        Decimal expectedResult = 257550.00;
        System.assertEquals(expectedResult, result, 'Total Amount was not calculated as expected.');
    }
    
    /**
     * Test method to test the amount of the order when the cart list or product wrappe list is null.
     */
    @isTest 
    static void totalAmountTestWhenProductWrapperListIsNull() 
    {
        CheckoutController checkoutObj = new CheckoutController(); 
        Decimal result = checkoutObj.calculateTotalAmount(null);
        Decimal expectedResult = 0.00;
        System.assertEquals(expectedResult, result, 'Total Amount was not calculated as expected.');
    }
    
    /**
     * Test method to test the amount of the order when the cart list or product wrappe list is empty.
     */
    @isTest 
    static void totalAmountTestWhenProductWrapperListIsEmpty() 
    {
        List<ProductWrapper> productWrapperList = new List<ProductWrapper>();
        CheckoutController checkoutObj = new CheckoutController();
        Decimal result = checkoutObj.calculateTotalAmount(productWrapperList);
        Decimal expectedResult = 0.00;
        System.assertEquals(expectedResult, result, 'Total Amount was not calculated as expected.');
    }
    
    /**
     * Test method to test the place order functionality.
     */
    @isTest 
    static void testPlaceOrder() 
    {
        List<Product2> productStockList = [SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2];
        List<ProductWrapper> productWrapperInCartList = new List<ProductWrapper>();
        for(Product2 product : productStockList) 
        {
            ProductWrapper prod = new ProductWrapper(product , false);
            prod.quantity = 1;
            productWrapperInCartList.add(prod);
        }
        CheckoutController checkoutObj = new CheckoutController();
        checkoutObj.placeOrder(productWrapperInCartList);
        Purchase_Order__c purchaseOrder = [SELECT Id FROM Purchase_Order__c][0];
        System.assert(purchaseOrder != null, 'No order was placed.');
        List<PurchaseOrderLineItem__c> purchaseOrderLineItemList = [SELECT Id FROM PurchaseOrderLineItem__c WHERE Purchase_Order__c = :purchaseOrder.Id];
        System.assertEquals(101,purchaseOrderLineItemList.size(), 'PurchaseOrderLineItemList was not created as expected.');
    }
}