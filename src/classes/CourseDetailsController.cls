public class CourseDetailsController extends LoginController {

	public boolean isUserLoggedIn {get;set;}
	
	public CourseDetailsController(){
		this.loginHelper = getLoginHelper();
		this.isUserLoggedIn = loginHelper.isUserLoggedIn();
	}
	
	public UserLoginHelper getLoginHelper(){
		return new UserLoginHelper('http://fibrasek.eadbox.com');
	}
	
	public Course__c getCourse(){
		Course__c[] course;
		if(loginHelper.isUserLoggedIn()) {
			course = [SELECT Id,course_id__c,title__c,description__c,workload__c FROM Course__c WHERE course_id__c = :ApexPages.currentPage().getParameters().get('courseId')];
			return course[0];
		} else {
			return course[0];
		}
	}
	
	public override PageReference login() {
		if(loginHelper.loginUser())	{
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Logado com sucesso!'));
			
			PageReference detail = new PageReference('/apex/CourseDetails?courseId=' + Apexpages.currentPage().getParameters().get('courseId'));
			detail.setRedirect(true);
			return detail;
		} else {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'E-mail/senha incorretos.'));
			
			PageReference detail = new PageReference('/apex/CourseDetails?courseId=' + Apexpages.currentPage().getParameters().get('courseId'));
			detail.setRedirect(true);
			return detail;
		}
	}
	
	public override PageReference logout() {
		if(loginHelper.logoutUser())	{
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Deslogado com sucesso!'));
			
			PageReference detail = new PageReference('/apex/CourseDetails?courseId=' + Apexpages.currentPage().getParameters().get('courseId'));
			detail.setRedirect(true);
			return detail;
		} else {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Aconteceu alguma coisa.'));
			
			PageReference detail = new PageReference('/apex/CourseDetails?courseId=' + Apexpages.currentPage().getParameters().get('courseId'));
			detail.setRedirect(true);
			return detail;
		}
	}
	
}