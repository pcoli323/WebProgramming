package org.tour.persistence;

import org.tour.domain.CourseVO;

public interface CourseDAO {

	public CourseVO read(int courseNumber) throws Exception;
	
}
