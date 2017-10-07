package org.tour.service;

import java.util.List;

import org.tour.domain.CourseInfoVO;

public interface CourseInfoService {

	public List<CourseInfoVO> representatives(int courseNumber) throws Exception;
	
	public String getRealImage(int gotoNumber) throws Exception;
	
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception;
	
	public void add(CourseInfoVO vo) throws Exception;
	
	public void courseInfoAdd(CourseInfoVO vo) throws Exception;
	
	public void changeImage(int gotoNumber, int imageNumber) throws Exception;
	
	public void deleteImage(int gotoNumber) throws Exception;
	
	public void representativeMark(int gotoNumber, int representedOrder) throws Exception;
}
