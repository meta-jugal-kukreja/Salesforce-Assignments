/**
 * Implementation of CheckoutService interface.
 */ 
public class CheckoutServiceImplementation implements CheckoutService
{
	/**
     * Method to calculate the total amount or bill of products present in the cart.
     */ 
	public Decimal calculateTotalAmount(List<ProductWrapper> productInCart)
    {
        Decimal totalAmount = 0;
        if(productInCart == null) 
        {
            return 0.00;
        }
        for(ProductWrapper product : productInCart ) 
        {
            totalAmount += product.quantity * product.product.Price__c;
        }
        return totalAmount;
    }
    
    /**
     * This method adds the products to purchaseOrderLineItemList and purchaseOrder records thus place order.
     */
    public void placeOrder(List<ProductWrapper> productWrapperInCartList)
    {
        Purchase_Order__c purchaseOrder = new Purchase_Order__c(Order_Status__c = 'Pending');
        insert purchaseOrder;
        List<PurchaseOrderLineItem__c> purchaseOrderLineItemList = new List<purchaseOrderLineItem__c>();
        List<Product2> productList = new List<Product2>();
        for(ProductWrapper product : productWrapperInCartList) {
            purchaseOrderLineItemList.add(new PurchaseOrderLineItem__c(Purchase_Order__c = purchaseOrder.Id,
                                                                       Ordered_Quantity__c = product.quantity,
                                                                       Product__c = product.product.Id,
                                                                       Amount__c = product.quantity * product.product.Price__c));
            product.product.quantity__c = product.availableQuantity;
            productList.add(product.product);
        }
        update productList;        
        insert purchaseOrderLineItemList;     
    }
}