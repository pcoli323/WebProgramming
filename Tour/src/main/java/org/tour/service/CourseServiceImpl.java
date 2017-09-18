package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.CourseVO;
import org.tour.persistence.CourseDAO;

@Service
public class CourseServiceImpl implements CourseService {

	@Inject
	private CourseDAO dao;
	
	@Override
	public CourseVO read(int courseNumber) throws Exception {
		
		return dao.read(courseNumber);
	}

}
