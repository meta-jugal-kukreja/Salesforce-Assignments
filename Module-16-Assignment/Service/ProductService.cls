/**
 * Interface for Product service.
 */ 
public interface ProductService 
{
    /**
     * Method to initiate Product Wrapper List.
     */ 
	List<ProductWrapper> initProductWrapper (Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId, 
                                             Map<Id, ProductWrapper> dirtyProductMapByProductId, 
                                             List<Product2> productList);
    
    /**
     * Method to update the Product Wrapper Map.
     */ 
	void updateProductWrapperMap(Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId, 
                                 Map<Id, ProductWrapper> dirtyProductMapByProductId, 
                                 List<ProductWrapper> productWrapperList);
}