/**
* Class which calculates number of working days between two days.
*/ 
public class DaysCalculator 
{
    /**
    * Method to calculate number of working days between two days.
    * @param date1 is the first date
    * @param date2 is the second date
	* @return {Integer} number of working days between date1 and date2
    */ 
    public Integer calculateWorkingDays(Date date1, Date date2)
    {
        Integer nonWorkingDays = 0;
        Integer numberofDaysBetween = date1.daysBetween(date2);
        for(Integer i = 0; i < numberofDaysBetween; i++)
        {
            Date intermediateDate = date1.addDays(i);
            if(getDayOfTheWeek(intermediateDate) == 'Sat' || getDayOfTheWeek(intermediateDate) == 'Sun')
                nonWorkingDays++;
        }
        return (numberofDaysBetween - nonWorkingDays);
    }
    
    /**
     * Helper method to get the Day of the Week of the corresponding date.
     * @param myDate is the date whose Day of Week is to be determined.
     * @return {String} Day of the Week of myDate.
     */ 
    public String getDayOfTheWeek(Date myDate)
    {
        DateTime myDateTime = (DateTime) myDate;
        String dayOfWeek = myDateTime.format('E','Kolkata');
        return dayOfWeek;
    }
}