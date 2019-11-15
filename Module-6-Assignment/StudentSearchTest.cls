/**
 * Test class to test StudentSearch class methods.
 */
@isTest
public class StudentSearchTest 
{
	@isTest
   public static void GetNametest(){
       Class__c cls = new Class__c(Name='x',MaxSize__c=2);
       insert cls;
       Student__c relatedStudents = new Student__c(Name='x', Class__c=cls.Id, Sex__c='Female');
       insert relatedStudents;
       List<Student__c> namesOfStudents = StudentSearch.searchStudentsByClass(cls.Id);
       System.assertEquals('x', namesOfStudents.get(0).Name);
   }
   
   @isTest
   public static void GetMaptest(){
       List<Student__c> listOfStudents = new List<Student__c>();
       Class__c c = new Class__c(Name='x',MaxSize__c=2);
       insert c;
       for(Integer i=0;i<2;i++){
           Student__c stu = new Student__c(Name='x'+i,Class__c=c.Id,Sex__c='Female');
           listOfStudents.add(stu);
       }
       insert listOfStudents;
       Map<String,List<Id>> result= StudentSearch.getStudentMap();
       List<Id> setOfStudents = new List<Id>();
       setOfStudents = result.get(c.Name);
       System.assertEquals(2,setOfStudents.size());
   }
}