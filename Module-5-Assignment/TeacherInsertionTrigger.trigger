/**
 * Trigger to restrict insertion of teacher if that teacher is teaching 'Hindi'.
 */
trigger TeacherInsertionTrigger on Contact (before insert, before update) 
{
    for(integer i = 0; i < Trigger.new.Size(); i++)
    {
        if(Trigger.new[i].Subject__c.contains('Hindi'))
        {
            Trigger.new[i].addError('Cannot Insert or Update teacher if that teacher is teaching Hindi.');
        }
    }
}