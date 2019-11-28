/**
 * This wrapper class is used to wrap product details, checkbox, the product's original quantity and its avalable quantity.
 */ 
public class ProductWrapper 
{
    public Product2 product{get;set;}
    public Boolean checked{get;set;}
    public Integer quantity{get;set;}
    public Integer availableQuantity{get;set;}
    public Integer originalQuantity{get;set;}
    
    /**
     * Constructor to initialize the product and its checkbox attribute.
     */ 
    public ProductWrapper(Product2 product , Boolean checked)
    {
        this.product = product;
        this.checked = Checked;
        this.originalQuantity = (Integer)product.Quantity__c;
        this.availableQuantity = (Integer)product.Quantity__c;
    }
    
    /**
     * Constructor to initialize the instance of the ProductWrapper class.
     */ 
    public ProductWrapper(ProductWrapper prodWrap)
    {
        this.product = prodWrap.product;
        this.checked = prodWrap.checked;
        this.quantity = prodWrap.quantity;
        this.availableQuantity = prodWrap.availableQuantity;
        this.originalQuantity = prodWrap.originalQuantity;
    }
}