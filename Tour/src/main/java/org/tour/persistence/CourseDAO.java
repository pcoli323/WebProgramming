package org.tour.persistence;

import org.tour.domain.CourseVO;

public interface CourseDAO {

	public CourseVO read(int courseNumber) throws Exception;
	
	public void add(CourseVO vo) throws Exception;
		
	public int newCourseNumber(int userNumber) throws Exception;
	
	public void courseAdd(CourseVO vo) throws Exception;
	public int courseNumberRead(int userNumber) throws Exception;

}
