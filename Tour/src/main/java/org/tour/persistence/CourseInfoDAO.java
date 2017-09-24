package org.tour.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.tour.domain.CourseInfoVO;

public interface CourseInfoDAO {

	public List<CourseInfoVO> representatives(int courseNumber) throws Exception;
	
	public String getRealImage(int gotoNumber) throws Exception;
	
	public List<Date> dates(int courseNumber) throws Exception;

	public List<CourseInfoVO> readAccordingToDate(HashMap<String, Object> courseNumberAndDate) throws Exception;
	
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception;
	
	public void add(CourseInfoVO vo) throws Exception;
<<<<<<< HEAD
	
	public void courseInfoAdd(CourseInfoVO vo) throws Exception;
=======

>>>>>>> 08dbe60be2bca58bafc184f2fd23fbaac6b0c86d
}
