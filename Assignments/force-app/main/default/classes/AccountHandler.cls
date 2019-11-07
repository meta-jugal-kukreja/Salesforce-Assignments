public class AccountHandler {
    
    public static Account insertNewAccount(String accountName)
    {
        System.debug('hello');
        try
        {
            Account acc = new Account(Name = accountName);
            insert acc;
            return acc;
        }
        catch(DmlException e)
        {
            return null;
        }
    }

}