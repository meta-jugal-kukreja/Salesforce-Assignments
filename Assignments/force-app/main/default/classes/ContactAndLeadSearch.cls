public class ContactAndLeadSearch {

    public static List<List< SObject>> searchContactsAndLeads(String name)
    {
        List<List< SObject>> searchList = [FIND 'Smith' IN NAME FIELDS RETURNING Account(Name), Lead(FirstName,LastName)];
        return searchList;
    }
}