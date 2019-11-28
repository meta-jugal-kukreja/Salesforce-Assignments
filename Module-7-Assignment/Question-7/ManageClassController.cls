/**
 * Controller for page ManageClass.
 */ 
public class ManageClassController 
{
    public List<Class__c> classes {get;set;}
    public Id classId {get;set;}
    public String className {get;set;}
    public String classDescription{get;set;}
    public String classFee{get;set;}
    public String classMaxSize{get;set;}
    public boolean isEdit{get;set;}
    
    /**
     * Constructor to initialize the isEdit variable to false and get all the classes.
     */ 
    public ManageClassController()
    {
        isEdit = false;
        classes = [SELECT Name FROM Class__c];
    }
    
    /**
     * This method sets the isEdit field to true in order to display the Edit Details Section
     */ 
    public void editClassDetails()
    {
        isEdit = true;  
    }
    
    /**
     * This method saves new data of the class and redirects to the same page.
     */ 
    public PageReference SaveDetails()
    {
        Class__c currentClass = [SELECT Name, DetailedDescription__c , Currency__c, MaxSize__c FROM Class__c WHERE Id =: classId];
        currentClass.Name = className;
        currentClass.DetailedDescription__c = classDescription;
        currentClass.Currency__c = !String.isBlank(classFee) ? Decimal.valueOf(classFee) : 0;
        currentClass.MaxSize__c = !String.isBlank(classMaxSize) ? Decimal.valueOf(classMaxSize) : 0;
        update currentClass;
        PageReference pageRef = new PageReference('/apex/manageClass');
        pageRef.setRedirect(false);
        isEdit = false;
        classes = [SELECT Name FROM Class__c];
        return pageRef;
    }
    
    /**
     * This method deletes the class and redirects to the same page.
     */ 
    public PageReference deleteClass()
    {
        Class__c currentClass = [SELECT Id FROM Class__c WHERE Id =: classId];
        delete currentClass;
        PageReference pageRef = new PageReference('/apex/manageClass');
        pageRef.setRedirect(false);
        isEdit = false;
        return pageRef;
    }
}