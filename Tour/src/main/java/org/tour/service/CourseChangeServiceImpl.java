package org.tour.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.CourseInfoVO;
import org.tour.dto.CourseIDDTO;
import org.tour.persistence.CourseChangeDAO;

@Service
public class CourseChangeServiceImpl implements CourseChangeService {

	@Inject
	private CourseChangeDAO dao;

	@Override
	public List<CourseIDDTO> getCourseIDList(int courseNumber) throws Exception {

		return dao.getCourseIDList(courseNumber);
	}

	@Override
	public List<CourseInfoVO> getCoursesList(int courseNumber) throws Exception {

		return dao.getCoursesList(courseNumber);
	}
	
}
