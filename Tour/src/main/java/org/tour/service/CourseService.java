package org.tour.service;

import org.tour.domain.CourseVO;

public interface CourseService {

	public CourseVO read(int courseNumber) throws Exception;
	
}
