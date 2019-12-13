/**
 * Email service class for creating contacts extracted from a XML file attached in the Mail.
 */ 
public class EmailServiceForCreatingContacts implements Messaging.InboundEmailHandler
{
    /**
     * This method handles the every inbound emails and does the necessary operations.
     */ 
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String contactsXmlFileContent = '';
        if(email.textAttachments != null)
        {
            for(Messaging.InboundEmail.textAttachment attachment : email.textAttachments)
            {
                if(attachment.fileName == 'Contacts.xml')
                {
                    contactsXmlFileContent = attachment.Body;
                    break;
                }
            }
            if(String.isNotBlank(contactsXmlFileContent))
            {
                try
                {
                    Integer numberOfContactsInserted = parseAndCreateContacts(contactsXmlFileContent);
                    result.success = true;
                    result.message = numberOfContactsInserted + ' Contacts were Inserted';
                }
                catch(Exception ex)
                {
                    result.success = false;
                    result.message = ex.getMessage();
                }
            }
            else
            {
                result.success = false;
                result.message = 'Empty XML File was provided, So no data was Inserted';
            }
        }
        return result;
    }
    
    /**
     * This method parses the whole XML File content, extracts each contact and insert all contacts in bulk.
     */ 
    public Integer parseAndCreateContacts(String xmlContentOfFile)
    {
        XmlStreamReader xmlReader = new XmlStreamReader(xmlContentOfFile);
        List<Contact> contactList = new List<Contact>();
        while(xmlReader.hasNext())
        {
            if(xmlReader.getEventType() == XmlTag.START_ELEMENT && xmlReader.getLocalName() == 'contact')
            {
                contactList.add(parseOneContact(xmlReader));
            }
            else if(xmlReader.getEventType() == XmlTag.END_ELEMENT && xmlReader.getLocalName() == 'contacts')
            {
                break;
            }
            xmlReader.next();
        }
        if(contactList.size() > 0)
        {
            insert contactList;
        }
        return contactList.size();
    }
    
    /**
     * This method parses the content of one contact and returns the formed contact with the parsed details.
     */
    public Contact parseOneContact(XmlStreamReader xmlReader)
    {
        Contact newContact = new Contact();
        while(xmlReader.hasName())
        {
            if(xmlReader.getEventType() == XmlTag.START_ELEMENT && xmlReader.getLocalName() == 'fname')
            {
                xmlReader.next();
                newContact.FirstName = xmlReader.getText();
            }
            else if(xmlReader.getEventType() == XmlTag.START_ELEMENT && xmlReader.getLocalName() == 'lname')
            {
                xmlReader.next();
                newContact.LastName = xmlReader.getText();
            }
            else if(xmlReader.getEventType() == XmlTag.START_ELEMENT && xmlReader.getLocalName() == 'email')
            {
                xmlReader.next();
                newContact.Email = xmlReader.getText();
            }
            else if(xmlReader.getEventType() == XmlTag.START_ELEMENT && xmlReader.getLocalName() == 'department')
            {
                xmlReader.next();
                newContact.Department = xmlReader.getText();
            }
            else if(xmlReader.getEventType() == XmlTag.START_ELEMENT && xmlReader.getLocalName() == 'experience')
            {
                xmlReader.next();
                newContact.Experience__c = Decimal.valueOf(xmlReader.getText());
            }
            else if(xmlReader.getEventType() == XmlTag.END_ELEMENT && xmlReader.getLocalName() == 'contact')
            {
                break;
            }
            xmlReader.next();
        }
        return newcontact;
    }
}