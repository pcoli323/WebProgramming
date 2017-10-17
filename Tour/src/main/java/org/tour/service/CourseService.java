package org.tour.service;

import java.util.List;

import org.tour.domain.CourseVO;

public interface CourseService {

	public CourseVO read(int courseNumber) throws Exception;
	
	public void add(CourseVO vo) throws Exception;
	
	public int newCourseNumber(int userNumber) throws Exception;
	
	public void courseAdd(CourseVO vo) throws Exception;
	
	public int courseNumberRead(int userNumber) throws Exception;
	
	public void update(CourseVO vo) throws Exception;
	
	public List<String> courseNameRead(int userNumber) throws Exception;
	
	public List<String> courseNoUploadNameRead(int userNumber) throws Exception;
	
	public List<String> courseUploadNameRead(int userNumber) throws Exception;

	public int courseNumByName(String courseName) throws Exception;
	
	public void delete(int courseNumber) throws Exception;
	
	public List<CourseVO> simpleViewAll(int userNumber) throws Exception;

}
