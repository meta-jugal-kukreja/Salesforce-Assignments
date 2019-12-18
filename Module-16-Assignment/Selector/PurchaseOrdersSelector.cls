/**
 * Selector class to get the data of Purchase Orders(Purchase History)
 */ 
public class PurchaseOrdersSelector extends fflib_SObjectSelector
{
    /**
     * Contructor to set the default inclusion of fields list to false.
     */ 
	public PurchaseOrdersSelector()
    {
        super(false);
    }
    
    /**
     * Contructor to set the default inclusion of fields list to includeFieldSetList.
     */ 
    public PurchaseOrdersSelector(Boolean includeFieldSetList)
    {
        super(includeFieldSetList);
    }
    
    /**
     * Selector method to get the lists Fields.
     */ 
    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField> {Purchase_Order__c.Id, Purchase_Order__c.Order_Price__c, Purchase_Order__c.Name,
            								   Purchase_Order__c.Order_Status__c};
    }
    
    /**
     * Selector method to get the object type.
     */ 
    public Schema.SObjectType getSObjectType()
    {
        return Purchase_Order__c.getSObjectType();
    }
    
    /**
     * Method to get the list of purchase orders sorted according to the field type selected in the UI.
     */ 
    public List<Purchase_Order__c> selectAllOrderBy(String orderBy, Boolean sortAscending)
    {
        String query = '';
        if(sortAscending)
        {
            query = String.format('SELECT {0} FROM {1} ' + 'ORDER BY {2} ' + 'ASC',
                                  new List<String> {
                                      getFieldListString(),
                                          getSObjectName(),
                                          orderBy});
        }
        else
        {
            query = String.format('SELECT {0} FROM {1} ' + 'ORDER BY {2} ' + 'DESC',
                                  new List<String> {
                                      getFieldListString(),
                                          getSObjectName(),
                                          orderBy});
        }
        return (List<Purchase_Order__c>) Database.query(query);
    }
}