package org.tour.persistence;

import java.util.Date;
import java.util.List;

import org.tour.domain.CourseInfoVO;

public interface CourseInfoDAO {

	public List<CourseInfoVO> representatives(int courseNumber) throws Exception;
	
	public List<Date> dates(int courseNumber) throws Exception;
	
	public List<String> gotoCodes(Date gotoDate) throws Exception;
}
