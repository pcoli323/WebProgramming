package org.tour.service;

import java.util.List;

import org.tour.domain.CourseInfoVO;

public interface CourseInfoService {

	public List<CourseInfoVO> representatives(int courseNumber) throws Exception;
	
	public String getRealImage(int gotoNumber) throws Exception;
	
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception;
	
	public void add(CourseInfoVO vo) throws Exception;
}
