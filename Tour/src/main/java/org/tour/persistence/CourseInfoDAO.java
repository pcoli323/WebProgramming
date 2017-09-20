package org.tour.persistence;

import java.util.Date;
import java.util.List;

import org.tour.domain.CourseInfoVO;

public interface CourseInfoDAO {

	public List<CourseInfoVO> representatives(int courseNumber) throws Exception;
	
	public String getRealImage(int gotoNumber) throws Exception;
	
	public List<Date> dates(int courseNumber) throws Exception;

	public List<String> gotoCodes(Date gotoDate) throws Exception;
	
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception;
	
	public void add(CourseInfoVO vo) throws Exception;
}
