/**
 * Test class to test EmailServiceForCreatingContacts Email service.
 */ 
@isTest
public class EmailServiceForCreatingContactsTest 
{
    /**
     * Test method to test the insertion of contacts when a XML File in correct format containing contacts details is send as attachment.
     */ 
    @isTest
    public static void testhandleInboundEmailWhenXMLFileIsInCorrectFormat()
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
        Messaging.InboundEmailResult result = testMail.handleInboundEmail(inboundEmail, envelop);
        List<Contact> contactList = [SELECT FirstName, LastName, Email, Department, experience__c FROM Contact];
        System.assertEquals(5, contactList.size(), 'Contacts were not inserted as expected.');
        System.assertEquals('fname1', contactList.get(0).FirstName, 'Contacts were not inserted as expected.');
    }
    
    /**
     * Test method to test the insertion of contacts when a XML File is not in correct format containing contacts details is send as attachment.
     */ 
    @isTest
    public static void testhandleInboundEmailWhenXMLFileIsNotInCorrectFormat()
    {
        Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail(); 
        Messaging.InboundEnvelope envelop = new Messaging.InboundEnvelope();        
        inboundEmail.fromAddress = 'jugal.kukreja@metacube.com'; 
        Messaging.InboundEmail.TextAttachment textAttachment = new Messaging.InboundEmail.TextAttachment();
        textAttachment.fileName = 'Contacts.xml';
        String xmlContent = '<contacts>' +
            '<contact>' +
            '<fname>fname1</fname>' +
            '<lname> </lname>' +
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
        Messaging.InboundEmailResult result = testMail.handleInboundEmail(inboundEmail, envelop);
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [LastName]: [LastName]',
                           result.message, 'Result was not as expected');
    }
    
    /**
     * Test method to test the insertion of contacts when an empty XML File is send as attachment.
     */ 
    @isTest
    public static void testhandleInboundEmailWhenXMLFileIsEmpty()
    {
        Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail(); 
        Messaging.InboundEnvelope envelop = new Messaging.InboundEnvelope();        
        inboundEmail.fromAddress = 'jugal.kukreja@metacube.com'; 
        Messaging.InboundEmail.TextAttachment textAttachment = new Messaging.InboundEmail.TextAttachment();
        textAttachment.fileName = 'Contacts.xml';
        String xmlContent = '';
        textAttachment.body = xmlContent;
        inboundEmail.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { textAttachment };
        EmailServiceForCreatingContacts testMail = new EmailServiceForCreatingContacts();
        Messaging.InboundEmailResult result = testMail.handleInboundEmail(inboundEmail, envelop);
        System.assertEquals('Empty XML File was provided, So no data was inserted', result.message, 'Result was not as expected');
    }
}