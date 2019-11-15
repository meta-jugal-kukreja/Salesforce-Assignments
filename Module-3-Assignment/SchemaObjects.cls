/**
 * Class to get all the SObjects present in the org.
 */
public class SchemaObjects 
{
    /**
 	 * Method to get all the SObjects present in the org.
 	 */
    public List<String> getAllObjects()
    {
        List<schema.sObjectType> allObjects = Schema.getGlobalDescribe().Values();
        List<String> objectList = new List<String>();
        for(schema.sObjectType singleObject : allObjects)
        {
            objectList.add(singleObject.getDescribe().getName());
        }
        return objectList;
    }
}