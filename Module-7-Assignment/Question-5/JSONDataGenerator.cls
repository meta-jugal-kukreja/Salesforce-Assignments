/**
 * Controller for JSONPage to generate JSON String.
 */ 
public class JSONDataGenerator 
{
    public String jsonString {get;set;}
    
    /**
     * Constructor to initialize the jsonString with data;
     */ 
	public JSONDataGenerator()
    {
        jsonString = prepareData();
    }
    
    /**
     * Method to prepare the JSON String.
     */ 
    public String prepareData()
    {
        List<Student__c> studentList = [SELECT Name, Class__r.Name, FirstName__c, DOB__c, Age__c, Email__c, Sex__c FROM Student__c];
        return JSON.serialize(studentList);
    }
}