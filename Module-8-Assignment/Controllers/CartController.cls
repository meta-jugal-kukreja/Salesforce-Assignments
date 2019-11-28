/**
 * Class to Control the actions of user adding products to the cart.
 */ 
public class CartController 
{
    List<ProductWrapper> productWrapperInCartList = new List<ProductWrapper>();
    
    /**
     * This method initializes the cart by the checked products with quanitity 1 if the product is not present in the cart, else updates the product's
     * quantity.
     */ 
    public void initCart(Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId) 
    {
        for(ProductWrapper product : (List<ProductWrapper>)selectedProductWrapperMapbyProductId.values()) 
        {
            if(product.availableQuantity <= 0)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Product:' + 
                                                           product.product.Name + ' Not Available'));
                continue;
            }
            if(product.checked)
            {
                if(!productWrapperInCartList.contains(product)) 
                {
                    product.quantity = 1;
                    productWrapperInCartList.add(product);
                    product.availableQuantity-- ;
                }
                else
                {
                    product.quantity++;
                    product.availableQuantity-- ;
                }
            }    
        }     
    }
    
    /**
     * This method updates the cart's products if the user enters some quantity of the product.
     */ 
    public void updateCart(Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId, Id selected) 
    {
        ProductWrapper product;
        if(selectedProductWrapperMapbyProductId.containsKey(selected)) 
        {
            product = selectedProductWrapperMapbyProductId.get(selected); 
        }	
        else 
        {
            for(ProductWrapper prod : productWrapperInCartList) 
            {
                if(prod.product.id.equals(selected)) 
                {
                    product = prod;
                    break;
                }
            }
        }
        if(product.originalQuantity < product.quantity)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, product.product.Name + 
                                                       ' Required Quantity not available'));
            product.quantity = product.originalQuantity - product.availableQuantity; 
            return;
        }
        else if(product.quantity <= 0)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, product.product.Name + 
                                                       ' Quantity cannot be zero or less'));
            product.quantity = product.originalQuantity - product.availableQuantity;
            return;
        }
        product.availableQuantity = product.originalQuantity - product.quantity;
        
    }
    
    /**
     * This method removes the product from the cart.
     */ 
    public void removeProductFromCart(Id selectedProduct) 
    {
        Integer indexTobeDeleted = -1;
        for(ProductWrapper product:productWrapperInCartList) 
        {
            if(product.product.Id.equals(selectedProduct))
            {
                indexTobeDeleted = productWrapperInCartList.indexOf(product);
                product.availableQuantity += product.quantity;
                product.quantity = 0;
            }
        }
        if(indexTobeDeleted != -1) 
        {
            productWrapperInCartList.remove(indexTobeDeleted);
        }
    }
    
    // Getter Method 
    public List<ProductWrapper> getProductsInCart() 
    {
        return productWrapperInCartList; 
    }
}