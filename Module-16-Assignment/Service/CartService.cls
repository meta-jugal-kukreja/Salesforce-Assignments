/**
 * Interface representing Service for Cart
 */ 
public interface CartService 
{
    /**
     * This method initializes the cart by the checked products with quanitity 1 if the product is not present in the cart, else updates the product's
     * quantity.
     */  
    List<ProductWrapper> initCart(Map<Id , ProductWrapper> selectedProductWrapperMapbyProductId, 
                                  List<ProductWrapper> productWrapperInCartList);
    
    /**
     * This method updates the cart's products if the user enters some quantity of the product.
     */ 
    void updateCart(Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId, 
                    List<ProductWrapper> productWrapperInCartList, Id selected);
    
    /**
     * This method removes the product from the cart.
     */ 
    void removeProductFromCart(Id selectedProduct, List<ProductWrapper> productWrapperInCartList);
}