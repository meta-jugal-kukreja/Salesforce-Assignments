/**
 * Test class to test methods of DaysCalculator Class.
 */
@isTest
public class DaysCalculatorTest 
{
    /**
     * Method to test calculation number of working days between two dates. 
     */ 
    @isTest
    public static void getWorkingDaystest()
    {
        Date d1 = Date.newInstance(2019,11,1);
        Date d2 = Date.newInstance(2019,11,31);
        DaysCalculator daysCalculatorObject = new DaysCalculator();
        System.assertEquals(21, daysCalculatorObject.calculateWorkingDays(d1,d2), 'There were different working days between the specified dates.');  
    }
}