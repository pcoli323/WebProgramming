package org.tour.service;

import java.util.List;
import java.util.Map;

import org.tour.domain.CourseInfoVO;

public interface CourseInfoService {

	public List<CourseInfoVO> representatives(int courseNumber) throws Exception;
	
	public String getRealImage(int gotoNumber) throws Exception;
	
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception;
	
	public void courseInfoAdd(CourseInfoVO vo) throws Exception;
	
	public void changeImage(int gotoNumber, int imageNumber) throws Exception;
	
	//public void deleteImage(int gotoNumber) throws Exception;
	
	public void initialRepresented(int courseNumber) throws Exception;
	
	public void representativeMark(int gotoNumber, int representedOrder) throws Exception;
	
	public void delete(int CourseNumber) throws Exception;
	
	public List<Integer> searchAccordingToAreaCode(int areaCode) throws Exception;
	
	public List<Integer> searchAccordingToAreaAndSigunguCode(Map<String, Integer> areaAndSigunguCode) throws Exception;
}
