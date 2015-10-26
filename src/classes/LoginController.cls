public with sharing class LoginController {

	public UserLoginHelper loginHelper{get;set;}
	
	public LoginController() {
		loginHelper = new UserLoginHelper('http://fibrasek.eadbox.com');
	}
	
	public void login() {
		loginHelper.loginUser();
	}
	
	public void logout() {
		loginHelper.logoutUser();
	}

}