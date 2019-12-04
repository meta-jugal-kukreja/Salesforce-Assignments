/**
 * Test class to test EmailServiceForCreatingContacts Email service.
 */ 
@isTest
public class EmailServiceForCreatingContactsTest 
{
    /**
     * Test method to test the insertion of contacts when an XML File with contacts details is send as attachment.
     */ 
    @isTest
    public static void testhandleInboundEmail()
    {
        Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail(); 
        Messaging.InboundEnvelope envelop = new Messaging.InboundEnvelope();        
        inboundEmail.fromAddress = 'jugal.kukreja@metacube.com'; 
        Messaging.InboundEmail.TextAttachment textAttachment = new Messaging.InboundEmail.TextAttachment();
        textAttachment.fileName = 'Contacts.xml';
        String xmlContent = '<contacts>' +
            '<contact>' +
            '<fname>fname1</fname>' +
            '<lname>lname1</lname>' +
            '<email>test.email@testdomain.com</email>' +
            '<deptartment>department1</deptartment>' +
            '<experience>1</experience>' +
            '</contact>' +
            '<contact>' +
            '<fname>fname2</fname>' +
            '<lname>lname2</lname>' +
            '<email>test.email2@testdomain.com</email>' +
            '<deptartment>department2</deptartment>' +
            '<experience>2</experience>' +
            '</contact>' +
            '<contact>' +
            '<fname>fname3</fname>' +
            '<lname>lname3</lname>' +
            '<email>test.email@testdomain.com</email>' +
            '<deptartment>department3</deptartment>' +
            '<experience>3</experience>' +
            '</contact>' +
            '<contact>' +
            '<fname>fname4</fname>' +
            '<lname>lname4</lname>' +
            '<email>test.email4@testdomain.com</email>' +
            '<deptartment>department4</deptartment>' +
            '<experience>4</experience>' +
            '</contact>' +
            '<contact>' +
            '<fname>fname5</fname>' +
            '<lname>lname5</lname>' +
            '<email>test.email5@testdomain.com</email>' +
            '<deptartment>department5</deptartment>' +
            '<experience>5</experience>' +
            '</contact>' +
            '</contacts>';
        textAttachment.body = xmlContent;
        inboundEmail.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { textAttachment };
        EmailServiceForCreatingContacts testMail = new EmailServiceForCreatingContacts();
        testMail.handleInboundEmail(inboundEmail, envelop);
        List<Contact> contactList = [SELECT FirstName, LastName, Email, Department, experience__c FROM Contact];
        System.assertEquals(5, contactList.size(), 'Contacts were not inserted as expected.');
        System.assertEquals('fname1', contactList.get(0).FirstName, 'Contacts were not inserted as expected.');
    }
}