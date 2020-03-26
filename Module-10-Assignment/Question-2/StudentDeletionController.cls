/**
 * Controller for DeleteStudentsPage.
 */ 
public class StudentDeletionController 
{
    public List<String> selectedStudentsIds = new List<String>();
    
    /**
     * Constructor to initialize selectedStudentsIds with the values passed in the url. 
     */ 
    public StudentDeletionController ()
    {
        selectedStudentsIds = ApexPages.currentPage().getParameters().get('recs').split(',');
    }
    
    /**
     * This method returns the list of selected students.
     */ 
    public List<Student__c> getStudents()
    {
        return [SELECT Id, Name FROM Student__c WHERE Id IN: selectedStudentsIds];
    }
    
    /**
     * This handles the redirection when continue and cancel buttons are clicked.
     */ 
    public PageReference redirect()
    {
        return new PageReference('/a0A');
    }
}