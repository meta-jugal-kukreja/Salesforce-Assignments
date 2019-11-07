public class ContactSearch {

    public static List<Contact> searchForContacts(String string1, String string2)
    {
        Contact[] resultantContactArray = [SELECT id, Name FROM Contact WHERE LastName=:string1 AND MailingPostalCode=:string2];
        List<Contact> resultantContacts = new List<Contact>();
        for(Integer i=0; i < resultantContactArray.size(); i++)
        {
            resultantContacts.add(resultantContactArray[i]);
        }
        return resultantContacts;
    }
}