//Trigger to restrict deletion of class if it has more than one female students
trigger ClassDeletionTrigger on Class__c (before delete) {

    for (AggregateResult oneStudent : [SELECT Class__r.id c, COUNT(Name) FROM Student__c WHERE Sex__c = 'Female' AND Class__c IN: Trigger.old
                                        GROUP BY Class__r.id HAVING COUNT(Name) > 1]) {
        Trigger.oldMap.get((id)oneStudent.get('c')).addError('Cannot delete a class with more than one female student');    
     }
}