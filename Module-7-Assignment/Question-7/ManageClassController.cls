/**
* Controller for page ManageClass.
*/ 
public class ManageClassController 
{
    public Id ClassId{get;set;}
    public boolean Render{get;set;}
    public Class__c SelectedClass{get;set;}
    
    /**
     * Constructor to initialize the data memebers of the class.
     */ 
    public ManageClassController() 
    {
        Render = false;
    }
    
    /**
     * Method to get the class list.
     */ 
    Public list<Class__c> getClasses() 
    {
        List<Class__c> classes = [SELECT Name, Currency__c, MaxSize__c, MyCount__c FROM Class__c];
        return classes;
    }
    
    /**
     * Method to select the class for editing.
     */ 
    public void editClass() 
    {
        SelectedClass = [SELECT Name, Currency__c, MaxSize__c, MyCount__c FROM Class__c WHERE Id = :ClassId];
        Render = true;
    }
    
    /**
     * Method to update the edited class details.
     */
    public void updateClass() 
    {
        update SelectedClass;
        Render = false;
    }
    
    /**
     * Method to delete the class.
     */
    public void deleteClass() 
    {
        SelectedClass = [SELECT Name, Currency__c, MaxSize__c, MyCount__c FROM Class__c WHERE Id = :ClassId];
        Render = false;
        delete SelectedClass;
    }
}