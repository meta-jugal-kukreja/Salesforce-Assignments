/**
 * Controller for MassDeleteRemoteActionPage.
 */ 
public class MassDeleteRemoteActionController
{
    public List<String> selectedStudentsIds = new List<String>();
    
    /**
	 * Constructor to initialize selectedStudentsIds with the values passed in the url. 
	 */ 
    public MassDeleteRemoteActionController ()
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
     * Remote action button to delete the selected students.
     * This method is called through JavaScript from visualforce page.
     */ 
    @RemoteAction
    public static void deleteStudents(ID[] studentsToBeDeleted)
    {
        try
        {
            List<Database.DeleteResult> results = Database.delete(studentsToBeDeleted, false);
        }
        catch(Exception exp)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, exp.getMessage()));
        }
    }
    
    /**
     * This handles the redirection when continue and cancel buttons are clicked.
     */ 
    public PageReference redirect()
    {
        return new PageReference('/a0A');
    }

}