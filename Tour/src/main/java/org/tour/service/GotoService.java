package org.tour.service;

import java.util.List;

import org.tour.domain.CourseInfoVO;

public interface GotoService {

	public List<String> readRepresentativeNames(List<CourseInfoVO> representatives) throws Exception;

}
