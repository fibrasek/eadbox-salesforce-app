public abstract with sharing class LoginController {

	public UserLoginHelper loginHelper {get;set;}
	
	public LoginController() {
		loginHelper = new UserLoginHelper('http://fibrasek.eadbox.com');
	}
	
	public abstract PageReference login();
	public abstract PageReference logout();
	
	public boolean isUserLoggedIn(){
		return loginHelper.isUserLoggedIn();
	}

}