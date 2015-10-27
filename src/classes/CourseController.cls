public with sharing class CourseController {
	
	public CourseHelper courseHelper{get;set;}
	public String url{get;set;}
	public List<Course__c> courses;
	public Course__c course;
	public final CourseImporter importer;
	public String courseId;
	
	public CourseController() {
		if(url == null){
			this.courseHelper = new CourseHelper('http://academia.eadbox.com');	
		} else {
			this.courseHelper = new CourseHelper(url);
		}
	}

	public List<Course__c> getCourses(){
		return [SELECT Id,course_id__c,title__c,description__c,workload__c FROM Course__c];
	}
	
	public PageReference reload(){
		return ApexPages.currentPage();
	}
	
	public PageReference details(){
		String id = Apexpages.currentPage().getParameters().get('courseId');
		PageReference detail = new PageReference('/apex/CourseDetails?courseId=' + id);
		detail.setRedirect(true);
		return detail;
	}
	
	/*
	public List<Course__c> getCoursesWithAuth(){
		User[] auth_token = [SELECT Eadbox_Auth_Token__c FROM User WHERE Id = :UserInfo.getUserId()];
		
		if(auth_token[0].Eadbox_Auth_Token__c == null){
			
		} else{
			return [SELECT Id,course_id__c,title__c,description__c,workload__c FROM Course__c];
		}
	}*/
}