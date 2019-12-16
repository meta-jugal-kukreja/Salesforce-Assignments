/**
 * Implementation of ProductService Interface.
 */ 
public class ProductServiceImplementation implements ProductService
{
    /**
     * Method to initiate Product Wrapper List.
     */ 
    public static List<ProductWrapper> initProductWrapper(Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId, 
                                                   Map<Id, ProductWrapper> dirtyProductMapByProductId, 
                                                   List<Product2> productList) 
    {
        List<ProductWrapper> productWrapperList = new List<ProductWrapper>();
        for(Product2 prod :productList) 
        {
            if(selectedProductWrapperMapbyProductId.containsKey(prod.Id)) 
            {
                productWrapperList.add(selectedProductWrapperMapbyProductId.get(prod.Id));
            }
            else if(dirtyProductMapByProductId.containsKey(prod.Id)) 
            {
                productWrapperList.add(dirtyProductMapByProductId.get(prod.Id));
            }
            else
            {
                productWrapperList.add(new ProductWrapper(prod, FALSE));
            }
        }
        return productWrapperList;
    }
    
    /**
     * Method to update the Product Wrapper Map.
     */ 
    public static void updateProductWrapperMap(Map<Id, ProductWrapper> selectedProductWrapperMapbyProductId, 
                                        Map<Id, ProductWrapper> dirtyProductMapByProductId, 
                                        List<ProductWrapper> productWrapperList) 
    {
        for(ProductWrapper prod : productWrapperList) 
        {
            if(prod.Checked && !selectedProductWrapperMapbyProductId.containsKey(prod.product.Id)) 
            {
                selectedProductWrapperMapbyProductId.put(prod.product.Id, prod);
                dirtyProductMapByProductId.put(prod.product.Id, prod);
            }
            else if(!prod.Checked && selectedProductWrapperMapbyProductId.containsKey(prod.product.Id) ) 
            {
                selectedProductWrapperMapbyProductId.remove(prod.product.Id);
            }
        }
    } 
}