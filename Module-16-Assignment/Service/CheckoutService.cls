/**
 * Interface representing Service for Checkout.
 */ 
public interface CheckoutService 
{
    /**
     * Method to calculate the total amount or bill of products present in the cart.
     */ 
	Decimal calculateTotalAmount(List<ProductWrapper> productInCart);
    
    /**
     * This method adds the products to purchaseOrderLineItemList and purchaseOrder records thus place order.
     */
    void placeOrder(List<ProductWrapper> productWrapperInCartList);
}