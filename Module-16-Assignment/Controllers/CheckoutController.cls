/**
 * Class to Control the actions of user checking out.
 */ 
public class CheckoutController 
{
    public Decimal totalAmount {get; set;}
    CheckoutService service = new CheckoutServiceImplementation();
    
    /**
     * Constructor to initialize the data member.
     */ 
    public checkoutController() 
    {
        this.totalAmount = 0;
    }
    
    /**
     * Method to calculate the total amount or bill of products present in the cart.
     */ 
    public Decimal calculateTotalAmount(List<ProductWrapper> productInCart) 
    { 
        this.totalAmount = service.calculateTotalAmount(productInCart);
        return this.totalAmount;
    }
    
    /**
     * This method adds the products to purchaseOrderLineItemList and purchaseOrder records thus place order.
     */ 
    public void placeOrder(List<ProductWrapper> productWrapperInCartList) 
    {
        service.placeOrder(productWrapperInCartList);
    }
    
    //Getter method
    public Decimal getTotalAmount() 
    {
        return this.totalAmount;
    }
}