/**
 * Class to display products with a checkbox and some other attributes.
 */ 
public class ProductsController 
{
    public String productToBeSearched;
    List<ProductWrapper> productWrapperList;
    Map<Id, ProductWrapper> selectedProductMap = new Map<Id, ProductWrapper>();
    
    //Initializing StandartSetController
    public ApexPages.StandardSetController setCon 
    {
        get
        {
            if(setCon == null)
            {
                List<Product2> productList = new List<Product2>();
                if(String.isNotBlank(this.productTobeSearched)) 
                {
                    productList = [SELECT Name, ProductCode, Description, Price__c, Quantity__c
                                   FROM Product2 
                                   WHERE Name LIKE: this.productTobeSearched+'%' AND Quantity__c != NULL ORDER BY Name DESC];
                }
                else 
                {
                    productList = [SELECT Name, ProductCode, Description, Price__c, Quantity__c
                                   FROM Product2 WHERE Quantity__c != NULL ORDER BY Name DESC];
                }
                setCon = new ApexPages.StandardSetController(productList);
                setCon.setPageSize(10);
            }
            return setCon;
        }
        set;
    }
    
    /**
     * This method returns the list of products available.
     */ 
    public List<Product2> getProducts()
    {
        return (List<Product2>)setCon.getRecords();
    }
    
    /**
     * This method enables the search to happen.
     */
    public void search()
    {
        this.setCon = null;
    }
    
    /**
     * This method populates the map with selected products.
     */
    public void updateProductWrapperMap() 
    {
        for(ProductWrapper prod : getProductWrapperList()) 
        {
            if(!selectedProductMap.containsKey(prod.product.Id)) 
            {
                selectedProductMap.put(prod.product.Id, prod);
            } 
        }
    }
    
    /**
     * This method returns the list to be displayed with the checkbox on the visualforce page.
     */
    public List<ProductWrapper> getProductWrapperList()
    {
        productWrapperList = new List<ProductWrapper>();
        for(product2 oneProduct : getProducts())
        {
            if(selectedProductMap.containsKey(oneProduct.Id))
            {
                productWrapperList.add(selectedProductMap.get(oneProduct.Id));
            }
            else
            {
                productWrapperList.add(new ProductWrapper(oneProduct, false));
            }
        }
        return productWrapperList;
    }
    
    /**
     * This method returns selectedProducts Map.
     */
    public Map<Id , ProductWrapper> getSelectedProductMap() 
    {
        return this.selectedProductMap;
    }
    
    /**
     * This method returns the name of the product to be searched for.
     */
    public String getProductTobeSearched() 
    {
        return this.productTobeSearched;
    }
    
    /**
     * This method sets the name of the product to be searched for.
     */
    public void setProductTobeSearched(String productName) 
    {
		this.productTobeSearched = productName;
    }
    
    //Pagination Methods.
    public Integer getPageSize() {return setCon.getPageSize();}
    public Integer getPageNumber() {return setCon.getPageNumber();}
    public Integer getResultSize() {return setCon.getResultSize();}
    public void next() 
    { 
        updateProductWrapperMap();
        setCon.next(); 
    }
    public void previous() 
    { 
        updateProductWrapperMap();
        setCon.previous(); 
    }
    public void first() 
    { 
        updateProductWrapperMap();
        setCon.first(); 
    }
    public void last() 
    { 
        updateProductWrapperMap();
        setCon.last(); 
    }
    public Boolean getHasNext() { return setCon.getHasNext(); }
    public Boolean getHasPrevious() { return setCon.getHasPrevious(); }
}