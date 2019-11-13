//Trigger to restrict insertion of a student into a class if that class max capacity is reached
trigger StudentInsertionTrigger on Student__c (before insert) {
	
    Integer i = 0;
    Set<ID> newIds = new Set<ID>();
    for(Integer i = 0; i < Trigger.new.Size(); i++)
    {
        newIds.add(Trigger.new[i].class__c);
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