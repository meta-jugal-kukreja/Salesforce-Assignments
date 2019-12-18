/**
 * Class to Control the actions of user adding products to the cart.
 */ 
public class CartController 
{
    List<ProductWrapper> productWrapperInCartList = new List<ProductWrapper>();
    CartService service = new CartServiceImplementation();
    
    /**
     * This method initializes the cart by the checked products with quanitity 1. 
     * If the product is not present in the cart, else updates the product's quantity.
     */ 
    public void initCart(Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId) 
    {
        this.productWrapperInCartList = service.initCart(selectedProductWrapperMapbyProductId, 
                                                             this.productWrapperInCartList);
    }
    
    /**
     * This method updates the cart's products if the user enters some quantity of the product.
     */ 
    public void updateCart(Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId, Id selected) 
    {
        service.updateCart(selectedProductWrapperMapbyProductId, productWrapperInCartList, selected);
    }
    
    /**
     * This method removes the product from the cart.
     */ 
    public void removeProductFromCart(Id selectedProduct) 
    {
        service.removeProductFromCart(selectedProduct, this.productWrapperInCartList);
    }
    
    // Getter Method 
    public List<ProductWrapper> getProductsInCart() 
    {
        return productWrapperInCartList; 
    }
}