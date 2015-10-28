public with sharing class CourseDetailsController {
//	public Course__c course{get;set;}
	
	public Course__c getCourse(){
		Course__c[] course = [SELECT Id,course_id__c,title__c,description__c,workload__c FROM Course__c WHERE course_id__c = :ApexPages.currentPage().getParameters().get('courseId')];
		return course[0];
	}

}