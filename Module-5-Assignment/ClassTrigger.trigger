/**
* Trigger to restrict deletion of class if it has more than one female students.
*/
trigger ClassTrigger on Class__c (before delete, after update) 
{
    if(Trigger.isBefore)
    {
        List<AggregateResult> students = [SELECT Class__r.id c, COUNT(Name) FROM Student__c WHERE Sex__c = 'Female' AND Class__c IN: Trigger.old
                                          GROUP BY Class__r.id HAVING COUNT(Name) > 1];
        for (AggregateResult oneStudent : students) 
        {
            Trigger.oldMap.get((id)oneStudent.get('c')).addError('Cannot delete a class with more than one female student');    
        }
    }
    else if(Trigger.isAfter)
    {
        List<Id> classListIds = new List<Id>();
        for(Class__c oneClass : Trigger.New)
        {
            Class__c oldRecord = Trigger.oldMap.get(oneClass.Id);
            if(oldRecord.Custom_Status__c != 'Reset' && oneClass.Custom_Status__c == 'Reset')
            {
                classListIds.add(oneClass.Id);
            }
        }
        List<Student__c> studentList = [SELECT Id FROM Student__c WHERE Class__c IN: classListIds];
        delete studentList;
    }
}