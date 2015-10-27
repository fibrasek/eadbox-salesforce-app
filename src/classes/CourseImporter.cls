public class CourseImporter {
	public static boolean importCourses(String url) {
		CourseHelper helper = new CourseHelper(url);
		try {
			upsert helper.getCourses();
			
			return true;
		} catch(Exception e){
			return false;
		}
	}
}