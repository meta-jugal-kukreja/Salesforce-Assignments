/**
* This class is used to get students list.
*/
public class StudentSearch {
    
	/**
	* This method searches the student by classid.
	* @param classId is the id of the class whose students are to be determined.
	* @return {List<Student__c>} List of students.
	*/
	public static List<Student__c> searchStudentsByClass(String classId)
    {
        return [SELECT FirstName__c,Name FROM Student__c WHERE Class__c =: classId];
    }
    
	/**
	* This method generates a map of class name and the corresponding list of students in it.
	* @return {Map<String, List<Id>>}
	*/
    public static Map<String, List<Id>> getStudentMap()
    {
        Map<String, List<Id>> studentMap = new Map<String, List<Id>>();
        List<Class__c> listClass = [SELECT Name, (SELECT id FROM Students__r) FROM Class__c];
        for(Class__c cl : listClass)
        {
            List<Id> studentList = new List<Id>();
            Map<Id, Student__c> relatedStudentsMap = new Map<Id, Student__c>(cl.Students__r);
            studentList = new List<Id>(relatedStudentsMap.keySet());
            studentMap.put(cl.Name,studentList);
        }
        return studentMap;
    }
}