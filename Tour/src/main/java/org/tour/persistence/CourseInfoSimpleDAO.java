package org.tour.persistence;

import org.tour.domain.CourseInfoSimpleVO;

public interface CourseInfoSimpleDAO {

	public void courseInfoSimpleAdd(CourseInfoSimpleVO vo) throws Exception;
	
	public void delete(int courseNumber) throws Exception;
}
