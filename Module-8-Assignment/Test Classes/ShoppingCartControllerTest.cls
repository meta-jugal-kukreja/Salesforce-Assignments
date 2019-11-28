/**
 * Test class to test ShoppingCartController.
 */ 
@isTest
public class ShoppingCartControllerTest 
{
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
}