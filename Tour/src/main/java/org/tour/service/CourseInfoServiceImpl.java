package org.tour.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.CourseInfoVO;
import org.tour.persistence.CourseInfoDAO;

@Service
public class CourseInfoServiceImpl implements CourseInfoService {

	@Inject
	private CourseInfoDAO dao;
	
	@Override
	public List<CourseInfoVO> representatives(int courseNumber) throws Exception {
		
		return dao.representatives(courseNumber);
	}

	@Override
	public String getRealImage(int gotoNumber) throws Exception {
		
		return dao.getRealImage(gotoNumber);
	}

	@Override
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception {
		
		return dao.readAll(courseNumber);
	}

	@Override
	public void add(CourseInfoVO vo) throws Exception {

		dao.add(vo);
	}
	
}
