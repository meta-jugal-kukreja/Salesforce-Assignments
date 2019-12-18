/**
* Controller Class for ShoppingCart Page.
*/ 
public class ShoppingCartController
{
    public Boolean showNewOrderButton {get;set;}
    public Boolean selectedAllProperties {get; set;}
    public String selectedProduct {get; set;}
    
    public Boolean showPurchaseHistoryArea {get; set;}
    public Boolean showProducts {get; set;}
    public Boolean showCart {get; set;}
    public Boolean showCheckout {get; set;}
    
    public PurchaseHistoryController purchaseHistoryObj;
    public ProductsController productsObj;
    public CartController cartObj;
    public CheckoutController checkoutObj;
    public ShoppingCartService shoppingCartServiceobj;
    
    /**
     * Constructor to initialize the data members.
     */ 
    public ShoppingCartController()
    {
        this.purchaseHistoryObj = new PurchaseHistoryController();
        this.productsObj = new ProductsController();
        this.cartObj = new CartController();
        this.checkoutObj = new CheckoutController();
        this.shoppingCartServiceobj = new ShoppingCartService();
        this.showPurchaseHistoryArea = false;
        this.showProducts = false;
        this.showCart = false;
        this.showCheckout = false;
        this.selectedAllProperties = false;
    }
    
    /****Show Product History Area****/
    
    //Method to get purchased orders
    public List<Purchase_Order__c> getPurchasedOrders()
    {
        return this.purchaseHistoryObj.getPurchasedOrders();
    }
    
    //Method To show purchased area on the page
    public boolean getShowPurchasedHistoryArea()
    {
        if(getPurchasedOrders().size() > 0)
        {
            this.showPurchaseHistoryArea = true;
        }
        else
        {
            this.showPurchaseHistoryArea = false;
        }
        return this.showPurchaseHistoryArea;
    }
    
    //Method to set sorting to Order Price.
    public void sortByOrderPrice() 
    {
        this.purchaseHistoryObj.sortByOrderPrice();
    }
    
    //Method to set sorting to Order Status.
    public void sortByOrderStatus() 
    {
        this.purchaseHistoryObj.sortByOrderStatus();
    }
    
    public void save()
    {
        this.purchaseHistoryObj.save();
    }
    //Methods for pagination
    public Integer getPageSize() {return this.purchaseHistoryObj.getPageSize();}
    public Integer getPageNumber() {return this.purchaseHistoryObj.getPageNumber();}
    public Integer getResultSize() {return this.purchaseHistoryObj.getResultSize();}
    public void next() { this.purchaseHistoryObj.next(); }
    public void previous() { this.purchaseHistoryObj.previous(); }
    public void first() { this.purchaseHistoryObj.first(); }
    public void last() { this.purchaseHistoryObj.last(); }
    public Boolean getHasNext() { return this.purchaseHistoryObj.getHasNext(); }
    public Boolean getHasPrevious() { return this.purchaseHistoryObj.getHasPrevious(); }
    
    /****Show Products****/
    
    //Method to show the Products_Area
    public void newPurchase()
    {
        this.showProducts = true;
    }
    
    //Method to set the ProductToBeSearched
    public void setProductTobeSearched(String productName) 
    {
        this.productsObj.setProductTobeSearched(productName);
    }
    
    //Method to get the name of the product to be searched for.
    public String getProductTobeSearched() 
    {
        return this.productsObj.getProductTobeSearched();
    }
    
    //Method to search the product
    public void searchProduct()
    {
        this.productsObj.search();
    }
    
    //Method to show the ProductWrapperList
    public List<ProductWrapper> getProductWrapperList () 
    {
        return this.productsObj.getProductWrapperList();
    }
    
    //Methods for pagination
    public Integer getPageSizeProd() {return this.productsObj.getPageSize();}
    public Integer getPageNumberProd() {return this.productsObj.getPageNumber();}
    public Integer getResultSizeProd() {return this.productsObj.getResultSize();}
    public void nextProd() { this.productsObj.next(); }
    public void previousProd() { this.productsObj.previous(); }
    public void firstProd() { this.productsObj.first(); }
    public void lastProd() { this.productsObj.last(); }
    public Boolean getHasNextProd() { return this.productsObj.getHasNext(); }
    public Boolean getHasPreviousProd() { return this.productsObj.getHasPrevious(); }
    
    /***Cart Area ***/
    
    //Method to add products to the cart.
    public void addToCart() 
    {
        this.productsObj.updateProductWrapperMap();
        this.cartObj.initCart(this.productsObj.getSelectedProductMap());
        if(this.cartObj.getProductsInCart().size() > 0)
        {
            this.showCart = true;
        }
    }
    
    //Method to update the cart products.
    public void updateCart() 
    { 
        this.cartObj.updateCart(this.productsObj.getSelectedProductMap() , this.selectedProduct); 
    }
    
    //Method to remove product from cart.
    public void removeProductFromCart() 
    {
        this.cartObj.removeProductFromCart(this.selectedProduct);
        if(this.cartObj.getProductsInCart().isEmpty()) 
        {
            this.showCart = false;
        }
    }
    
    //Method to get the list of products in the cart.
    public List<ProductWrapper> getProductsInCart() 
    {
        return this.cartObj.getProductsInCart(); 
    }
    
    //Method to hide the products and cart section when checkout button is clicked.
    public void checkout() 
    {
        if(ApexPages.hasMessages())
        {
            return;
        }
        this.showPurchaseHistoryArea = false;
        this.showProducts = false;
        this.showCart = false;
        this.showNewOrderButton = false;
        
        this.checkoutObj.calculateTotalAmount(getProductsInCart());
        this.showCheckout = true; 
    }
    
    /*** Checkout Area ***/
    
    //Method to show the total amount or bill of products in the cart
    public Decimal getTotalAmount() 
    {
        return this.checkoutObj.getTotalAmount();
    }
    
    //Method to cancel orders.
    public void cancelOrder() 
    {
        this.showPurchaseHistoryArea = true;
        this.showProducts = true;
        this.showCart = true;
        this.showNewOrderButton = true;
        this.showCheckout = false;  
    }
    
    //Method to place order and redirect to the first screen showing only Purchase History.
    public PageReference placeOrder() 
    {
        this.checkoutObj.placeOrder(getProductsInCart()); 
        PageReference page = ApexPages.currentPage();
        page.setRedirect(true);
        return page;
    }
}