/**
 * Test class to test CartController.
 */ 
@isTest
public class CartControllerTest 
{
    /**
     * Method to initialize the data for the tests.
     */ 
    @testSetUp
    static void setupProducts() 
    {
        List<Product2> productStockList = new List<Product2>();
        for(Integer i = 0 ; i < 101 ; i++)
        {
            productStockList.add(new Product2(Name = 'Test Product ' + (i+1), 
                                              ProductCode = 'PCode' + (i+1),
                                              Description = 'Test product data',
                                              Price__c = 50 * (i+1),
                                              Quantity__c = i));
        }
        insert productStockList;  
    }
    
    /**
     * Test method to test SelectedProductMap When Quantity Of Product is greater Than Two.
     */ 
    @isTest
    static void testSelectedProductMapWhenQuantityOfProductIsGreaterThanTwo() 
    {
       Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId = new Map<Id, ProductWrapper>();
       for(Product2 product :[SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2])
       {
            if(product.Quantity__c > 2) 
            {
                selectedProductWrapperMapbyProductId.put(product.Id, new ProductWrapper(product, true));
            }
        }
        CartController cartObj = new CartController();
        cartObj.initCart(selectedProductWrapperMapbyProductId);
        Integer expectedProductInCart = 98;
        System.assertEquals(expectedProductInCart, cartObj.getProductsInCart().size(), 'Number of products in cart were not as expected');
    }
    
    /**
     * Test method to test PageMessage Errors When Available Quanity Is Less Than or Equal To Zero.
     */ 
	@isTest
    static void testPageMessageErrorWhenAvailableQuanityIsLessThanZeroOrZero() 
    {
       Map<Id, ProductWrapper> selectedProductWrapperMap = new Map<Id, ProductWrapper>();
       List<Product2> productList = [SELECT Name, ProductCode, Price__c, Quantity__c, Description 
                                     FROM Product2 
                                     WHERE Quantity__c < 2];
        for(Product2 product :productList) 
        {
            selectedProductWrapperMap.put(product.Id, new ProductWrapper(product, true));
        }
        PageReference shoppingCartPage = Page.shoppingCart;
        Test.setCurrentPage(shoppingCartPage);
        CartController cartObj = new CartController();
        cartObj.initCart(selectedProductWrapperMap);
        System.assert(ApexPages.hasMessages(), 'Page doesn\'t has any errors');
        System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR), 'Page doesn\'t has required type errors');
        System.assert(ApexPages.getMessages().size() == 1, 'Page more than one errors');
    }
    
    /**
     * Test method to test PageErrors When Updated Product Quantity Is Greater Than Available Quantity.
     */ 
    @isTest
    static void testPageErrorWhenUpdatedProductQuantityIsGreaterThanAvailableQuantity() 
    {
       Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId = new Map<Id, ProductWrapper>();
       List<Product2> productList = [SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2];
        for(Product2 product :productList) 
        {
            product.Quantity__c += 5;
            selectedProductWrapperMapbyProductId.put(product.Id, new ProductWrapper(product, true));
        }
        CartController cartObj = new CartController();
        cartObj.initCart(selectedProductWrapperMapbyProductId);
        ProductWrapper prod = selectedProductWrapperMapbyProductId.get(productList[0].Id);
        prod.quantity = 500;
        cartObj.updateCart(selectedProductWrapperMapbyProductId, productList[0].Id);
        Test.setCurrentPage(Page.shoppingCart);
        System.assert(ApexPages.hasMessages(), 'Page doesn\'t has any errors');
        System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR), 'Page doesn\'t has required type errors');
        System.assert(ApexPages.getMessages().size() == 1, 'Page more than one errors');
        System.assert(ApexPages.getMessages()[0].getSummary().contains('Required Quantity not available'), 'Error message is not as Expected.');
    }
    
    /**
     * Test method to test ageErrors When Updated Product Quantity Is Negative Or Zero.
     */ 
    @isTest
    static void testPageErrorWhenUpdatedProductQuantityIsNegativeOrZero() {
       //Given
       Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId = new Map<Id, ProductWrapper>();
       List<Product2> productList = [SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2];
        for(Product2 product :productList) 
        {
            product.Quantity__c += 5;
            selectedProductWrapperMapbyProductId.put(product.Id, new ProductWrapper(product, TRUE));
        }
        CartController cartObj = new CartController();
        cartObj.initCart(selectedProductWrapperMapbyProductId);
        ProductWrapper prod = selectedProductWrapperMapbyProductId.get(productList[0].id);
        prod.quantity = -5;
        cartObj.updateCart(selectedProductWrapperMapbyProductId, productList[0].id);
        Test.setCurrentPage(Page.shoppingCart);
        System.assert(ApexPages.hasMessages(), 'Page doesn\'t has any errors');
        System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR), 'Page doesn\'t has required type errors');
        System.assert(ApexPages.getMessages().size() == 1, 'Page more than one errors');
        System.assert(ApexPages.getMessages()[0].getSummary().contains('Quantity cannot be zero or less'), 'Error message is not as Expected.');
    }
    
    /**
     * Test method to test Removal of One Product.
     */ 
    @isTest
    static void testRemoveOneProduct() 
    {
        Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId = new Map<Id, ProductWrapper>();
        List<Product2> productList = [SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2];
        for(Product2 product : productList) 
        {
            product.Quantity__c += 5;
            selectedProductWrapperMapbyProductId.put(product.Id, new ProductWrapper(product, true));
        }
        CartController cartObj = new CartController();
        cartObj.initCart(selectedProductWrapperMapbyProductId);
        System.assertEquals(101, cartObj.getProductsInCart().size(), 'Number of products in cart are not as Expected.');
        cartObj.removeProductFromCart(productList[0].id);
        Integer expectedProductsInCartAfterRemoval = 100;
        System.assertEquals(expectedProductsInCartAfterRemoval, cartObj.getProductsInCart().size(), 'Number of products in cart are not as Expected.');
        System.assert(!cartObj.getProductsInCart().contains(selectedProductWrapperMapbyProductId.get(productList[0].id))
                      , 'Product was present in the cart even after removal.');    
    }

    /**
     * Test method to test Removal of All Products.
     */
    @isTest
    static void testRemoveAllProducts() 
    {
        Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId = new Map<Id, ProductWrapper>();
        List<Product2> productList = [SELECT Name, ProductCode, Price__c, Quantity__c, Description FROM Product2 LIMIT 2];
        for(Product2 product :productList) 
        {
            product.Quantity__c += 5;
            selectedProductWrapperMapbyProductId.put(product.Id, new ProductWrapper(product, TRUE));
        }
        CartController cartObj = new CartController();
        cartObj.initCart(selectedProductWrapperMapbyProductId);
        System.assertEquals(2,cartObj.getProductsInCart().size(), 'Number of products in cart are not as Expected.');
        cartObj.removeProductFromCart(productList[0].id);
        cartObj.removeProductFromCart(productList[1].id);
        System.assert(cartObj.getProductsInCart().isEmpty(), 'Products are still present in cart even after removing all products.');
    }
}