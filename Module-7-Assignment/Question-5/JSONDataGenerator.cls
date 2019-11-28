/**
 * Controller for JSONPage to generate JSON String conatining a student's details.
 */ 
public class JSONDataGenerator 
{
    public String jsonString {get;set;} 
    public JSONDataGenerator()
    {
        
    }
    /**
     * Constructor to initialize the jsonString with data;
     */ 
	public JSONDataGenerator(ApexPages.StandardController controller)
    {
        controller.addFields(new List<String>{'Name', 'dob__c', 'age__c'});
        Student__c student = (Student__c)controller.getRecord();
        jsonString = prepareData(student);
    }
    
    /**
     * Method to prepare the JSON String.
     */ 
    public String prepareData(Student__c student)
    {
        String jsonString = JSON.serialize(student);
        Map<String, Object> deserialized = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
        deserialized.remove('attributes');
        return JSON.serialize(deserialized);
    }
}