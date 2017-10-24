package org.tour.persistence;

import java.util.HashMap;
import java.util.List;

import org.tour.domain.CourseVO;

public interface CourseDAO {

	public CourseVO read(int courseNumber) throws Exception;
	
	public void add(CourseVO vo) throws Exception;
		
	public int newCourseNumber(int userNumber) throws Exception;
	
	public void courseAdd(CourseVO vo) throws Exception;
	
	public int courseNumberRead(int userNumber) throws Exception;
	
	public String allCourseName(HashMap<String, Object> courseNameCompare) throws Exception;
	
	public String courseReadName(int courseNumber) throws Exception;
	
	public List<Integer> noUploadCourseNumber(int userNumber) throws Exception;
	
	public List<Integer> uploadCourseNumber(int userNumber) throws Exception;
	
	public void update(CourseVO vo) throws Exception;
	
	public void delete(int courseNumber) throws Exception;
	
	public List<CourseVO> simpleViewAll(int userNumber) throws Exception;
	
	public List<Integer> searchAccordingToUserNumber(int userNumber) throws Exception;
	
	public void deletePost(CourseVO vo) throws Exception;
	
	public int noUploadCourseNumberRead(int userNumber) throws Exception;
}
