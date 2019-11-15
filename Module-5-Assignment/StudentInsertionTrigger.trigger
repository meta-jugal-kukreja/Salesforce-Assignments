/**
* Trigger to restrict insertion of a student into a class if that class max capacity is reached.
*/
trigger StudentInsertionTrigger on Student__c (before insert, after insert, after update) 
{
    if(Trigger.isBefore)
    {
        Integer i = 0;
        Set<ID> newIds = new Set<ID>();
        for(Student__c oneStudent : Trigger.New)
        {
            newIds.add(oneStudent.class__c);
        }
        List<Class__C> classList = [SELECT MaxSize__c, NumberOfStudents__c from class__c WHERE Id IN: newIds];
        for(Class__c oneClass : classList)
        {
            if(oneClass.MaxSize__c == oneClass.NumberOfStudents__c)
            {
                Trigger.New[i].addError('Maximum Capacity of the class is reached.');
            }
            i++;
        }
    }
    else if(Trigger.isAfter)
    {
        List<Class__C> classList = new List<Class__c>();
        Set<ID> newIds = new Set<ID>();
        for(Student__c oneStudent : Trigger.New)
        {
            newIds.add(oneStudent.class__c);
        }
        if(Trigger.isUpdate)
        {
            Set<ID> oldIds = new Set<ID>();
            for(Student__c oneStudent : Trigger.Old)
            {
                    oldIds.add(oneStudent.class__c);
            }
            classList = [SELECT Name, (SELECT Name FROM Students__r) from class__c WHERE Id IN: newIds OR Id IN: oldIds];
        }
        else
        {
            classList = [SELECT Name, (SELECT Name FROM Students__r) from class__c WHERE Id IN: newIds];
        }
        for(Class__c oneClass : classList)
        {
            System.debug(oneClass.Name + ' ' + oneClass.Students__r.size());
            oneClass.MyCount__c = oneClass.Students__r.size();
        }
        update classList;
    } 
}