package org.tour.service;

import org.tour.domain.CourseInfoSimpleVO;

public interface CourseInfoSimpleService {

	public void courseInfoSimpleAdd(CourseInfoSimpleVO vo) throws Exception;
	
	public void delete(int courseNumber) throws Exception;
}
