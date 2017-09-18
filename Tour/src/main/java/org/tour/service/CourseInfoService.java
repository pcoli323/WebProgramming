package org.tour.service;

import java.util.List;

import org.tour.domain.CourseInfoVO;

public interface CourseInfoService {

	public List<CourseInfoVO> representatives(int courseNumber) throws Exception;
}
