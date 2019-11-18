/**
 * Test class to test StudentSearch class methods.
 */
@isTest
public class StudentSearchTest 
{
   /**
    * Test method to get the student name in a particular class.
    */ 
   @isTest
   public static void getNameOfOneStudent()
   {
       Class__c cls = new Class__c(Name='x',MaxSize__c=2);
       insert cls;
       Student__c relatedStudents = new Student__c(Name='xyz', Class__c=cls.Id, Sex__c='Female');
       insert relatedStudents;
       List<Student__c> namesOfStudents = StudentSearch.searchStudentsByClass(cls.Id);
       System.assertEquals('xyz', namesOfStudents.get(0).Name, 'No student by such name is present in the class');
   }
    
    /**
    * Test method to get the student name in a particular class.
    */ 
   @isTest
   public static void getNamesOfMultipleStudent()
   {
       Class__c cls = new Class__c(Name='x',MaxSize__c=2);
       insert cls;
       List<Student__c> studentsInClass = new List<Student__c>();
       for(Integer i = 0; i < 101; i++)
       {
           studentsInClass.add(new Student__c(Name = 'Test Student ' + i, class__c = cls.Id));
       }
       insert studentsInClass;
       List<Student__c> namesOfStudents = StudentSearch.searchStudentsByClass(cls.Id);
       System.assertEquals(studentsInClass.size(), namesOfStudents.size(), 'All students are not there in the class');
   }
   
    /**
     * Test method to get the Map where key is class Name and value is the list of Student ids present in that class.
     */ 
   @isTest
   public static void getMaptest()
   {
       List<Student__c> listOfStudents = new List<Student__c>();
       Class__c c = new Class__c(Name='x',MaxSize__c=2);
       insert c;
       for(Integer i=0;i<2;i++)
       {
           Student__c stu = new Student__c(Name='x'+i,Class__c=c.Id,Sex__c='Female');
           listOfStudents.add(stu);
       }
       insert listOfStudents;
       Map<String,List<Id>> result= StudentSearch.getStudentMap();
       List<Id> setOfStudents = new List<Id>();
       setOfStudents = result.get(c.Name);
       System.assertEquals(2,setOfStudents.size(), 'All students are not there in the class');
   }
}