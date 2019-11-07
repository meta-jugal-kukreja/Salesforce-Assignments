public class StudentSearch {
    
	public static List<Student__c> searchStudentsByClass(String classId)
    {
        return [SELECT FirstName__c,Name FROM Student__c WHERE Class__c =: classId];
    }
    
    public Map<String, Set<String>> searchStudents()
    {
        Map<String, Set<String>> studentMap = new Map<String, Set<String>>();
        Class__c[] classes = [SELECT Name from Class__c];
        Student__c[] students = [SELECT Class__r.Name,Id FROM Student__c];
        for(Integer i = 0; i < classes.size(); i++)
        {
            String className = classes[i].Name;
            Set<String> studentSet = new Set<String>();
            for(Integer j = 0; j < students.size(); j++)
            {
                if(students[j].Class__r.Name == className)
                {
                    studentSet.add(students[j].Id);
                }
            }
            studentMap.put(className,studentSet);
        }
        return studentMap;
    }
    
    public static Map<String, List<String>> searchStudents1()
    {
        Map<String, List<String>> studentMap = new Map<String, List<String>>();
        List<Class__c> listClass = [SELECT Name, (SELECT id FROM Students__r) FROM Class__c];
        for(Class__c cl : listClass)
        {
            List<String> studentList = new List<String>();
            System.debug(cl.Students__r);
            //studentMap.put(cl.Name,studentList);
        }
        return studentMap;
    }
}