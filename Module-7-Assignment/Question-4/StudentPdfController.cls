/**
 * Controller for StudentPdfPage
 */ 
public class StudentPdfController 
{
    //Getting current student Id
    public Id currentStudentId 
    {
        get 
        {
            return Id.valueOf(ApexPages.CurrentPage().getparameters().get('id'));
        }
        set;
    }
    
    /**
     * Method to generate and save pdf as attachment on related student tab.
     */ 
    public PageReference savePdf() 
    {
        System.debug('hello');
        PageReference pdfPage = Page.StudentPdfPage;
        // add parent id to the parameters for standardcontroller
        pdfPage.getParameters().put('Id', currentStudentId);
        //delete previous attachments
        List<Attachment> attachmentList = [SELECT Id, ParentId FROM Attachment WHERE ParentId = :currentStudentId];
        if(attachmentList.size() > 0) 
        {
            delete attachmentList;
        }
        // create the new attachment
        Attachment attach = new Attachment(); 
        blob pdfBody;
        if(Test.isRunningTest()) 
        { 
            pdfBody = blob.valueOf('Unit.Test');
        } else 
        {
            pdfBody = pdfPage.getContentAsPDF();
        }
        attach.Body = pdfBody;
        attach.Name = 'StudentDetails.pdf';
        // attach the pdf to the account
        attach.ParentId = currentStudentId;
        insert attach;
        //redirect the user to the same page
        return new PageReference('/' + currentStudentID);
    }
    
    /**
     * Method to return the current student details.
     */ 
    public Student__c getStudent()
    {
        Student__C student = [SELECT FirstName__c, Name, Class__r.Name, Age__c, DOB__c FROM Student__c WHERE id = :currentStudentID];
        return student;
    }
}