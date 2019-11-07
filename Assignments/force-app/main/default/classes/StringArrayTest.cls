public class StringArrayTest {
    
    public static List<String> generateStringArray(Integer n)
    {
        List<String> generatedString = new List<String>();
        for(Integer i = 0; i < n; i++)
        {
            generatedString.add('Test ' + i);
        }
        return generatedString;
    }

}