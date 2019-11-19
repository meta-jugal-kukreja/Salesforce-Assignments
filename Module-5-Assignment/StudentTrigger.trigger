/**
* Trigger to restrict insertion of a student into a class if that class max capacity is reached.
*/
trigger StudentTrigger on Student__c (before insert, after insert, after update) 
{
    if(Trigger.isBefore)
    {
        Set<ID> newIds = new Set<ID>();
        for(Student__c oneStudent : Trigger.New)
        {
            newIds.add(oneStudent.class__c);
        }
        Map<Id, Decimal> studentsCountForClass = new Map<Id, Decimal>();
        Map<Id, Class__c> classes = new Map<Id, Class__c>([SELECT Id, MaxSize__c, NumberOfStudents__c FROM Class__c WHERE Id in :newIds]);
        for(Student__c student: Trigger.new)
        {
            Decimal maxSize = classes.get(student.Class__c).MaxSize__c;
            if(studentsCountForClass.get(student.Class__c) == null)
            {
                Decimal existingStudentsInClass = classes.get(student.Class__c).NumberOfStudents__c;
            
                if(existingStudentsInClass >=  maxSize)
                {
                    student.addError('Maximum class size reached');
                }
                else
                {
                    studentsCountForClass.put(student.Class__c, existingStudentsInClass);
                }
            }
            else
            {
                Decimal numberOfStudents = studentsCountForClass.get(student.Class__c) + 1 ;
                if(numberOfStudents >= maxSize)
                {
                    student.addError('Maximum class size reached');
                }
                else
                {
                    studentsCountForClass.put(student.Class__c, numberOfStudents);
                }
            }
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
            classList = [SELECT Name, (SELECT Name FROM Students__r) FROM class__c WHERE Id IN: newIds OR Id IN: oldIds];
        }
        else
        {
            classList = [SELECT Name, (SELECT Name FROM Students__r) FROM class__c WHERE Id IN: newIds];
        }
        for(Class__c oneClass : classList)
        {
            oneClass.MyCount__c = oneClass.Students__r.size();
        }
        update classList;
    } 
}