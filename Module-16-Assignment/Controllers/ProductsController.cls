/**
 * Class to display products with a checkbox and some other attributes.
 */ 
public class ProductsController 
{
    public String productToBeSearched;
    List<ProductWrapper> productWrapperList = new List<ProductWrapper>();
    Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId = new Map<Id, ProductWrapper>();
    Map<Id, ProductWrapper> dirtyProductMapByProductId = new Map<Id, ProductWrapper>();
    ProductService service = new ProductServiceImplementation();
    
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
                    productList = new ProductSelector(true).selectByName(this.productTobeSearched);
                }
                else 
                {
                    productList = new ProductSelector(true).selectAll();
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
     * Method to initiate Product Wrapper List.
     */ 
    public void initProductWrapper() 
    {
       this.productwrapperList = service.initProductWrapper(selectedProductWrapperMapbyProductId, 
                                                            dirtyProductMapByProductId, getProducts());
    }
    
    /**
     * Method to update the Product Wrapper Map.
     */ 
    public void updateProductWrapperMap() 
    {
        service.updateProductWrapperMap(selectedProductWrapperMapbyProductId, 
                                        dirtyProductMapByProductId, productWrapperList);
    }
    
    
    /**
     * This method returns the list to be displayed with the checkbox on the visualforce page.
     */
    public List<ProductWrapper> getProductWrapperList()
    {
        productWrapperList = new List<ProductWrapper>();
        initProductWrapper();
        return productWrapperList;
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
    
    /**
     * Method to get the selectedProductWrapperMapbyProductId.
     */ 
    public Map<Id, ProductWrapper> getSelectedProductMap()
    {
        return selectedProductWrapperMapbyProductId;
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
