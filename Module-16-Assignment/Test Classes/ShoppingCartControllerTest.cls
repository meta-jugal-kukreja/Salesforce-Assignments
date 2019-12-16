/**
 * Test class to test ShoppingCartController.
 */ 
@isTest
public class ShoppingCartControllerTest 
{  
    /**
     * Method to initialize the data for the purchase history.
     */ 
    private static void setupProductsHistory() 
    {
        List<Purchase_Order__c> productHistoryList = new List<Purchase_Order__c>();
        for(Integer i = 0 ; i < 101; i++)
        {
            productHistoryList.add(new Purchase_Order__c(Order_Status__c = 'Pending'));
        }
        insert productHistoryList;
    }
    
    /**
     * Method to initialize the data for the tests.
     */ 
    private static void setupProducts() 
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
    }
    
    
    /**
     * Test method to test visibility of Purchase History area when Purchase Order History is Present.
     */ 
    @isTest
    private static void testPurchseHistoryAreaWithListNotNull()
    {
        List<Purchase_Order__c> purchasedOrders = new List<Purchase_Order__c>();
        purchasedOrders.add(new Purchase_Order__c(Order_Status__c = 'Pending'));
        insert purchasedOrders;
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.showPurchaseHistoryArea = false;
        shoppingCartControllerObj.getShowPurchasedHistoryArea();
        System.assertEquals(true, shoppingCartControllerObj.showPurchaseHistoryArea, 'Purchase history area was not Shown.');
    }
    
    /**
     * Test method to test visibility of Purchase History area when Purchase Order History is not Present.
     */ 
    @isTest
    private static void testPurchseHistoryAreaWithListNull()
    {
        List<Purchase_Order__c> purchasedOrders = new List<Purchase_Order__c>();
        insert purchasedOrders;
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.showPurchaseHistoryArea = false;
        shoppingCartControllerObj.getShowPurchasedHistoryArea();
        System.assertEquals(false, shoppingCartControllerObj.showPurchaseHistoryArea, 'Purchase history area was shown.');
    }
    
    /**
     * Test method to test visibility of Purchase products Area.
     */ 
    @isTest
    private static void testNewPurchaseArea()
    {
        List<Purchase_Order__c> purchasedOrders = new List<Purchase_Order__c>();
        purchasedOrders.add(new Purchase_Order__c(Order_Status__c = 'Pending'));
        insert purchasedOrders;
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.showProducts = false;
        shoppingCartControllerObj.newPurchase();
        System.assertEquals(true, shoppingCartControllerObj.showProducts, 'New Purchase area was not Shown.');
    }
    
    /**
     * Test method to test the visibility of various areas when checkout button is clicked.
     */ 
    @isTest
    private static void testCheckout()
    {
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.showPurchaseHistoryArea = true;
        shoppingCartControllerObj.showProducts = true;
        shoppingCartControllerObj.showCart = true;
        shoppingCartControllerObj.showNewOrderButton = true;
        shoppingCartControllerObj.showCheckout = false; 
        shoppingCartControllerObj.checkout();
        System.assertEquals(false, shoppingCartControllerObj.showPurchaseHistoryArea, 'Purchase History area was Shown.');
        System.assertEquals(false, shoppingCartControllerObj.showProducts, 'New Purchase area was Shown.');
        System.assertEquals(false, shoppingCartControllerObj.showCart, 'Cart Area area was Shown.');
        System.assertEquals(false, shoppingCartControllerObj.showNewOrderButton, 'New Order button was Shown.');
        System.assertEquals(true, shoppingCartControllerObj.showCheckout, 'Checkout area was not Shown.');
    }
    
    /**
     * Test method to test the visibility of various areas when cancel button is clicked.
     */ 
    @isTest
    private static void testCancel()
    {
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.showPurchaseHistoryArea = false;
        shoppingCartControllerObj.showProducts = false;
        shoppingCartControllerObj.showCart = false;
        shoppingCartControllerObj.showNewOrderButton = false;
        shoppingCartControllerObj.showCheckout = true; 
        shoppingCartControllerObj.cancelOrder();
        System.assertEquals(true, shoppingCartControllerObj.showPurchaseHistoryArea, 'Purchase History area was not Shown.');
        System.assertEquals(true, shoppingCartControllerObj.showProducts, 'New Purchase area was not Shown.');
        System.assertEquals(true, shoppingCartControllerObj.showCart, 'Cart Area area was not Shown.');
        System.assertEquals(true, shoppingCartControllerObj.showNewOrderButton, 'New Order button was not Shown.');
        System.assertEquals(false, shoppingCartControllerObj.showCheckout, 'Checkout area was Shown.');
    }
    
    /**
     * Test method to test setting up of sortBy field with 'Order_Price'.
     */
    @isTest
    private static void testSettingOfSortByOrderPrice()
    {
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.sortByOrderPrice();
        System.assertEquals('Order_Price__c', shoppingCartControllerObj.purchaseHistoryObj.sortBy, 'SortBy variable was not not set as expected.');
    }
    
    /**
     * Test method to test setting up of sortBy field with 'Order_Status'.
     */
    @isTest
    private static void testSettingOfSortByOrderStatus()
    {
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.sortByOrderStatus();
        System.assertEquals('Order_Status__c', shoppingCartControllerObj.purchaseHistoryObj.sortBy, 'SortBy variable was not not set as expected.');
    }
    
    /**
     * Test method to test Page Number of the Purchase history List.
     */ 
    @isTest
    private static void testPurchaseHistoryGetPageNumber()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assertEquals(1, shoppingCartControllerObj.getPageNumber(), 'Page number was not as Expected');
    }

	/**
     * Test method to test Page Size of the Purchase history List.
     */ 
    @isTest
    private static void testPurchaseHistoryGetPageSize()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assertEquals(10, shoppingCartControllerObj.getPageSize(), 'Page size was not as Expected');
    }    
    /**
     * Test method to test Result Size of the Purchase history List.
     */
    @isTest
    private static void testPurchaseHistoryGetResultSize()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assertEquals(101, shoppingCartControllerObj.getResultSize(), 'Result Size was not as Expected');
    }
    
    /**
     * Test method to test whether the Purchase history page has more records next.
     */
    @isTest
    private static void testPurchaseHistoryNext()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.next();
        System.assertEquals(10, shoppingCartControllerObj.getPurchasedOrders().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the Purchase history page has more records previous.
     */
    @isTest
    private static void testPurchaseHistoryPrevious()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.previous();
        System.assertEquals(10, shoppingCartControllerObj.getPurchasedOrders().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the Purchase history page has records on first page.
     */
    @isTest
    private static void testPurchaseHistoryFirst()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.first();
        System.assertEquals(10, shoppingCartControllerObj.getPurchasedOrders().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the Purchase history page has records on last page.
     */
    @isTest
    private static void testPurchaseHistoryLast()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.last();
        System.assertEquals(1, shoppingCartControllerObj.getPurchasedOrders().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the Purchase history page has next page.
     */
    @isTest
    private static void testPurchaseHistoryHasNext()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assert(shoppingCartControllerObj.getHasNext(), 'Some More data is present');
    }
    
    /**
     * Test method to test whether the Purchase history page has previous page.
     */
    @isTest
    private static void testPurchaseHistoryHasPrevious()
    {
        setupProductsHistory();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assert(!shoppingCartControllerObj.getHasPrevious(), 'Some More data is present');
    }
    
    /**
     * Test method to test Page Number of the Products List.
     */ 
    @isTest
    private static void testProductGetPageNumber()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assertEquals(1, shoppingCartControllerObj.getPageNumberProd(), 'Page number was not as Expected');
    }

	/**
     * Test method to test Page Size of the Products List.
     */ 
    @isTest
    private static void testProductGetPageSize()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assertEquals(10, shoppingCartControllerObj.getPageSizeProd(), 'Page size was not as Expected');
    }    
    /**
     * Test method to test Result Size of the Products List.
     */
    @isTest
    private static void testProductGetResultSize()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assertEquals(101, shoppingCartControllerObj.getResultSizeProd(), 'Result Size was not as Expected');
    }
    
    /**
     * Test method to test whether the Products page has more records next.
     */
    @isTest
    private static void testProductNext()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.getProductWrapperList();
        shoppingCartControllerObj.nextProd();
        System.assertEquals(10, shoppingCartControllerObj.getProductWrapperList().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the Products page has more records previous.
     */
    @isTest
    private static void testProductPrevious()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.getProductWrapperList();
        shoppingCartControllerObj.previousProd();
        System.assertEquals(10, shoppingCartControllerObj.getProductWrapperList().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the Products page has records on first page.
     */
    @isTest
    private static void testProductFirst()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.getProductWrapperList();
        shoppingCartControllerObj.firstProd();
        System.assertEquals(10, shoppingCartControllerObj.getProductWrapperList().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the Products page has records on last page.
     */
    @isTest
    private static void testProductLast()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.getProductWrapperList();
        shoppingCartControllerObj.lastProd();
        System.assertEquals(1, shoppingCartControllerObj.getProductWrapperList().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the Products page has next page.
     */
    @isTest
    private static void testProductHasNext()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assert(shoppingCartControllerObj.getHasNextProd(), 'Some More data is present');
    }
    
    /**
     * Test method to test whether the Products page has previous page.
     */
    @isTest
    private static void testProductHasPrevious()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        System.assert(!shoppingCartControllerObj.getHasPreviousProd(), 'Some More data is present');
    }
    
    /**
     * Test method to test setting and getting of product to be searched for.
     */
    @isTest
    private static void testSetAndGetProductTOBeSearched()
    {
        setupProducts();
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.setProductTobeSearched('Test Product');
        System.assertEquals('Test Product', shoppingCartControllerObj.getProductTobeSearched(), 'The product was not as Expected');
    }
    
    /**
     * Test method to test Removal of Product from cart.
     */ 
    @isTest
    static void testRemoveOneProduct() 
    {
        setupProducts();
        Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId = new Map<Id, ProductWrapper>();
        Product2 product = [SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2 LIMIT 1];
        product.Quantity__c += 5;
        selectedProductWrapperMapbyProductId.put(product.Id, new ProductWrapper(product, true));
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.cartObj.initCart(selectedProductWrapperMapbyProductId);
        shoppingCartControllerObj.selectedProduct = product.id;
        shoppingCartControllerObj.removeProductFromCart();
        System.assertEquals(false, shoppingCartControllerObj.showCart, 'Cart area is visible');
    }
    
    /**
     * Test method to test the amount of the order when the cart list or product wrappe list is not null.
     */ 
    @isTest
    static void totalAmountTestWhenProductWrapperListIsNotNull() 
    {
        setupProducts();
        List<Product2> productStockList = [SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2];
        List<ProductWrapper> productWrapperList = new List<ProductWrapper>();
        for(Product2 product : productStockList) 
        {
            ProductWrapper prod = new ProductWrapper(product , false);
            prod.quantity = 1;
            productWrapperList.add(prod);
        }
        ShoppingCartController shoppingCartControllerObj = new ShoppingCartController();
        shoppingCartControllerObj.checkoutObj.calculateTotalAmount(productWrapperList);
        Decimal result = shoppingCartControllerObj.getTotalAmount();
        Decimal expectedResult = 257550.00;
        System.assertEquals(expectedResult, result, 'Total Amount was not calculated as expected.');
    }
    
}