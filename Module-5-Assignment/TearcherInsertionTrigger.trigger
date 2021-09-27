//Trigger to restrict teacher to insert or update if the teacher is teaching 'Hindi'
trigger TearcherInsertionTrigger on Teach__c (before insert, before update) {
    
    for(integer i = 0; i < Trigger.new.Size(); i++)
    {
        if(Trigger.new[i].Multi_Subjects__c.contains('Hindi'))
        {
            Trigger.new[i].addError('Cannot Insert or Update teacher if that teacher is teaching Hindi.');
        }
    }
}