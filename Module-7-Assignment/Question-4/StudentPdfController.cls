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
        PageReference pdfPage = Page.StudentPdfPageCopy;
        // add parent id to the parameters for standardcontroller
        pdfPage.getParameters().put('id', currentStudentId);
        // create the new attachment
        Attachment attach = new Attachment();        
        attach.Body = pdfPage.getContentAsPdf();
        attach.Name = 'StudentDetails.pdf';
        // attach the pdf to the account
        attach.ParentId = currentStudentId;
        //delete previous attachments
        List<Attachment> attachmentList = [SELECT Id, ParentId FROM Attachment WHERE ParentId = :currentStudentId];
        if(attachmentList.size() > 0) 
        {
            delete attachmentList[0];
        }
        insert attach;
        //redirect the user to the same page
        PageReference renderOnPage = new PageReference('/'+ currentStudentID);
        return renderOnPage;
    }
    
    /**
     * Method to return the current student details.
     */ 
    public Student__c getStudent()
    {
        Student__C student = [Select FirstName__c, Name, Class__r.Name, Age__c, DOB__c from Student__c Where id = :currentStudentID];
        return student;
    }
}