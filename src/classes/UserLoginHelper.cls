public class UserLoginHelper {
	
	private String url;
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public UserLoginHelper(String url) {
		this.setUrl(url);
	}
	
	public void logoutUser() {
		updateUserAuthToken(null);
	}
	
	
	public boolean loginUser(String user, String password) {
		
		boolean isLoginValid = false;
		String reqUrl = url + ''; 
		
		HttpRequest req = new HttpRequest(); 

		req.setMethod('POST');
		req.setHeader('content-type', 'application/json');
		req.setHeader('Accept','application/json');
		req.setHeader('Host', url);
		req.setEndpoint(url + '/api/login');
		req.setHeader('Connection','close');
		req.setBody('{"email":"' + user + '","password":"' + password + '"}');
		
		System.debug(req.getBody() + ' ' + req.toString());
		Http http = new Http();
  
		try {	
			HTTPResponse res = http.send(req);
			JSONParser parser = JSON.createParser(res.getBody());
			System.debug(res.getBody());
			Map<String,String> result = parseJSONResponse(parser);
			
			if(result.containsKey('valid') || result.containsKey('auth_token')){
				isLoginValid = Boolean.valueOf(result.get('valid'));
			
				updateUserAuthToken(result.get('auth_token'));
			}
			
							
		} catch(System.CalloutException e) {
		
		}
		
		return isLoginValid;
	}
	
	private Map<String,String> parseJSONResponse(JSONParser parser) {
		String auth_token = null;
		Map<String,String> result = new Map<String,String>();
	
        while (parser.nextToken() != null) {
        	if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'valid')){
        		parser.nextToken();
        		System.debug('Resultado: '+parser.getBooleanValue());
        		result.put('valid', ''+parser.getBooleanValue());
        	}
        	
        	if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'authentication_token')){
        		parser.nextToken();
        		result.put('auth_token', parser.getText());
        	}
        }
        
        return result;
    }
    
    private void updateUserAuthToken(String token) {
		try{
			User[] auth_token = [SELECT Eadbox_Auth_Token__c FROM User WHERE Id = :UserInfo.getUserId()];
		
			auth_token[0].Eadbox_Auth_Token__c = token;
			
			update auth_token;
		} catch(Exception e) {
			System.debug('Erro na query ou update!');
		}
    }
}