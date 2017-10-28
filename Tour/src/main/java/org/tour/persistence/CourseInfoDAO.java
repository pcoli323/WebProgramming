package org.tour.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.tour.domain.CourseInfoVO;

public interface CourseInfoDAO {

	public List<CourseInfoVO> representatives(int courseNumber) throws Exception;
	
	public String getRealImage(int gotoNumber) throws Exception;
	
	public List<Date> dates(int courseNumber) throws Exception;

	public List<CourseInfoVO> readAccordingToDate(HashMap<String, Object> courseNumberAndDate) throws Exception;
	
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception;
	
	public void courseInfoAdd(CourseInfoVO vo) throws Exception;

	public void changeImage(HashMap<String, Object> data) throws Exception;
	
	//public void deleteImage(int gotoNumber) throws Exception;
	
	public void initialRepresented(int courseNumber) throws Exception;
	
	public void representativeMark(HashMap<String, Object> data) throws Exception;
	
	public void delete(int courseNumber) throws Exception;
	
	public List<Map<String, Integer>> regionList(int courseNumber) throws Exception;
}
