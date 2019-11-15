/**
 * Test class to test methods of DaysCalculator Class.
 */
@isTest
public class DaysCalculatorTest 
{
    @isTest
    public static void GetWorkingDaystest()
    {
        Date d1 = Date.newInstance(2019,11,1);
        Date d2 = Date.newInstance(2019,11,31);
        DaysCalculator daysCalculatorObject = new DaysCalculator();
        System.assertEquals(21, daysCalculatorObject.calculateWorkingDays(d1,d2));  
    }
}