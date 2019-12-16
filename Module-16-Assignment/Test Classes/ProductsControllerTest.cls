/**
 * Test class to test ProductsController.
 */ 
@isTest
public class ProductsControllerTest 
{
	/**
     * Method to initialize the data for the tests.
     */ 
    @testSetUp
    static void setupProducts() 
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
     * Test method to test ProductWrapperList And SelectedProductMap.
     */ 
    @isTest
    static void testProductWrapperList() 
    {
        ProductsController productObj = new ProductsController();
        ProductWrapper processedProduct = productObj.getProductWrapperList()[0];
        processedProduct.checked = true; 
        productObj.updateProductWrapperMap();
        System.assertEquals(10, productObj.getProductWrapperList().size(), 'ProductWrapperList was not created as expected');
        processedProduct.checked = false; 
        productObj.updateProductWrapperMap();
    }
    
    /**
     * Test method to test Searching For a Product.
     */
    @isTest
    static void testSearchingForProduct() 
    {
		String selectedProduct = 'Test Product 1';
		ProductsController productObj = new ProductsController();  
        productObj.setProductTobeSearched(selectedProduct);
        System.assertEquals(10,productObj.getProductWrapperList().size(), 'ProductWrapperList was not created as expected');
    }
    
    /**
     * Test method to test Page Number of the Purchase history List.
     */ 
    @isTest
    private static void testGetPageNumber()
    {
        ProductsController productsControllerobj = new ProductsController();
        System.assertEquals(1, productsControllerobj.getPageNumber(), 'Page number was not as Expected');
    }
    
    /**
     * Test method to test Page Number of the Purchase history List.
     */ 
    @isTest
    private static void testGetPageSize()
    {
        ProductsController productsControllerobj = new ProductsController();
        System.assertEquals(10, productsControllerobj.getPageSize(), 'Page number was not as Expected');
    }
    
    /**
     * Test method to test Result Size of the Purchase history List.
     */
    @isTest
    private static void testGetResultSize()
    {
        ProductsController productsControllerobj = new ProductsController();
        System.assertEquals(101, productsControllerobj.getResultSize(), 'Result Size was not as Expected');
    }
    
    /**
     * Test method to test whether the page has more records next.
     */
    @isTest
    private static void testNext()
    {
       ProductsController productsControllerobj = new ProductsController();
        productsControllerobj.next();
        System.assertEquals(10, productsControllerobj.getProducts().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has more records previous.
     */
    @isTest
    private static void testPrevious()
    {
        ProductsController productsControllerobj = new ProductsController();
        productsControllerobj.previous();
        System.assertEquals(10, productsControllerobj.getProducts().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has records on first page.
     */
    @isTest
    private static void testFirst()
    {
        ProductsController productsControllerobj = new ProductsController();
        productsControllerobj.first();
        System.assertEquals(10, productsControllerobj.getProducts().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has records on last page.
     */
    @isTest
    private static void testLast()
    {
        ProductsController productsControllerobj = new ProductsController();
        productsControllerobj.last();
        System.assertEquals(1, productsControllerobj.getProducts().size(), 'List was not as Expected');
    }
    
    /**
     * Test method to test whether the page has next page.
     */
    @isTest
    private static void testHasNext()
    {
        ProductsController productsControllerobj = new ProductsController();
        System.assert(productsControllerobj.getHasNext(), 'Some More data is present');
    }
    
    /**
     * Test method to test whether the page has previous page.
     */
    @isTest
    private static void testHasPrevious()
    {
        ProductsController productsControllerobj = new ProductsController();
        System.assert(!productsControllerobj.getHasPrevious(), 'Some More data is present');
    }
}