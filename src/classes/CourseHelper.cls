public with sharing class CourseHelper {

	//CONSTANTS
	private static final String EMPTY_TITLE = 'Sem título';
	private static final String EMPTY_DESCRIPTION = 'Sem descrição';
	private static final String EMPTY_WORKLOAD = String.valueOf((Time.newInstance(0,0,0,0)).hour());
	private static final String EMPTY_TIME_AVAILABLE = String.valueOf((Time.newInstance(0,0,0,0)).hour());
	
	private String url;
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public CourseHelper(String url) {
		this.setUrl(url);
	}
	
	public List<Course__c> getCourses() {
		
		String reqUrl = url + ''; 
		List<Course__c> results;
		
		HttpRequest req = new HttpRequest(); 

		req.setMethod('GET');
		req.setHeader('content-type', 'application/json');
		req.setHeader('Accept','application/json');
		req.setHeader('Host', url);
		req.setEndpoint(url + '/api/courses');
		req.setHeader('Connection','close');
		
		Http http = new Http();
  
		try {	
			HTTPResponse res = http.send(req);	
			
			JSONParser parser = JSON.createParser(res.getBody());
			
			System.debug(res.toString());
			System.debug('STATUS:'+res.getStatus());
			System.debug('STATUS_CODE:'+res.getStatusCode());
			
			results = parseJSONResponse(parser);
							
		} catch(System.CalloutException e) {
		
		}
		
		return results;
	}
	
	private List<Course__c> parseJSONResponse(JSONParser parser) {
		
		List<Course__c> results = new List<Course__c>();
		
        while (parser.nextToken() != null) {
        	Course__c c;
        	if(parser.getCurrentToken() == JSONToken.START_OBJECT){
        		c = new Course__c();
        		PreCourse pre = (PreCourse) parser.readValueAs(PreCourse.class);
        		
        		if(pre.course_id != null) {
        			c.course_id__c = pre.course_id;
        		}
        		
        		if(pre.title != null) {
        			c.title__c = pre.title;
        		} else {
					c.title__c = EMPTY_DESCRIPTION;
        		}
        		
        		if(pre.title != null) {
        			c.description__c = pre.description;
        		} else {
        			c.description__c = EMPTY_DESCRIPTION;
        		}
        		
        		if(pre.workload != null) {
        			c.workload__c = String.valueOf(DateTime.parse(pre.workload).hour());
        		} else {
        			c.workload__c = EMPTY_WORKLOAD;
        		}
        		
        		if(pre.time_available != null) {
        			//c.time_available__c = String.valueOf(DateTime.parse(pre.time_avaible).hour());
        			c.time_available__c = EMPTY_TIME_AVAILABLE;
        		} else {
        			c.time_available__c = EMPTY_TIME_AVAILABLE;
        		}
        		
        		parser.skipChildren();
        		
        		results.add(c);
        	}
        	
        }
        
        return results;
    }
}