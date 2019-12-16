/**
 * Selector class to get the data of Products according to some conditions.
 */ 
public class ProductSelector extends fflib_SObjectSelector 
{
    /**
     * Contructor to set the default inclusion of fields list to false.
     */ 
    public ProductSelector() 
    {
        super(false);
    }
    
    /**
     * Contructor to set the default inclusion of fields list to includeFieldSetList.
     */
    public ProductSelector(Boolean includeFieldSetFields) 
    {
        super(includeFieldSetFields);
    }
    
    /**
     * Selector method to get the lists Fields.
     */
    public List<Schema.SObjectField> getSObjectFieldList() 
    {
        return new List<Schema.SObjectField>
        { Product2.Id, Product2.Name, Product2.ProductCode, Product2.Description, Product2.Price__c, Product2.Quantity__c };
    }
    
    /**
     * Selector method to get the object type.
     */ 
    public Schema.SObjectType getSObjectType() 
    {
        return Product2.sObjectType;
    }
    
    /**
     * Method to get the list of all products.
     */ 
    public List<Product2> selectAll() 
    {
        String query = newQueryFactory().setCondition('Quantity__c != NULL').toSOQL();
        return (List<Product2>) Database.query(query);
    }
    
    /**
     * Method to get the list of all products by name.
     */ 
    public List<Product2> selectByName(String name) 
    {
        String query = newQueryFactory().setCondition('Name LIKE \''+ name + '%\' AND Quantity__c != NULL').toSOQL();
        return (List<Product2>) Database.query(query);
    }
}