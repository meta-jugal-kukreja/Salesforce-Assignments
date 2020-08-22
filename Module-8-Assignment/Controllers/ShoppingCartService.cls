/**
 * Service class to get the records according to the standard set controller.
 */ 
public class ShoppingCartService 
{
    public List<sObject> getRecords(ApexPages.StandardSetController setCon)
    {
        List<sObject> items = new List<sObject>();
        items = setCon.getRecords();
        return items;
    }
}