public class DaysCalculator {
	
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
    
    public String getDayOfTheWeek(Date myDate)
    {
        DateTime myDateTime = (DateTime) myDate;
        String dayOfWeek = myDateTime.format('E','Kolkata');
        return dayOfWeek;
    }
}