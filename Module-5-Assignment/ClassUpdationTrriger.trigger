/**
* Trigger to Delete related student list when Custom_Status__c field of Class__c is set to 'Reset'.
*/
trigger ClassUpdationTrriger on Class__c (after update) 
{
    List<Class__c> classList = new List<Class__C>();
    for(Class__c oneClass : Trigger.New)
    {
        Class__c oldRecord = Trigger.oldMap.get(oneClass.Id);
        if(oldRecord.Custom_Status__c != 'Reset' && oneClass.Custom_Status__c == 'Reset')
        {
            classList.add(oneClass);
        }
    }
    List<Student__c> studentList = [SELECT id,Name FROM Student__c WHERE class__c IN: classList];
    delete studentList;
}