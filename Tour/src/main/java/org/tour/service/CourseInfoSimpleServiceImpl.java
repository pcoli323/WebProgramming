package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.CourseInfoSimpleVO;
import org.tour.persistence.CourseInfoSimpleDAO;

@Service
public class CourseInfoSimpleServiceImpl implements CourseInfoSimpleService {

	@Inject
	private CourseInfoSimpleDAO dao;

	@Override
	public void courseInfoSimpleAdd(CourseInfoSimpleVO vo) throws Exception {
		
		dao.courseInfoSimpleAdd(vo);
	}
	
}
