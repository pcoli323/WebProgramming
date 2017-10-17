package org.tour.persistence;

import java.util.List;

import org.tour.domain.CourseInfoVO;
import org.tour.dto.CourseIDDTO;

public interface CourseChangeDAO {

	public List<CourseIDDTO> getCourseIDList(int courseNumber) throws Exception;
	
	public List<CourseInfoVO> getCoursesList(int courseNumber) throws Exception;
	
}
