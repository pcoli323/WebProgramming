package org.tour.service;

import java.util.List;

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

	@Override
	public void add(CourseVO vo) throws Exception {
		
		dao.add(vo);
	}

	@Override
	public int newCourseNumber(int userNumber) throws Exception {
		
		return dao.newCourseNumber(userNumber);
	}

	@Override
	public void courseAdd(CourseVO vo) throws Exception {

		dao.courseAdd(vo);
		
	}

	@Override
	public int courseNumberRead(int userNumber) throws Exception {

		return dao.courseNumberRead(userNumber);
	}

	@Override
	public List<String> courseNameRead(int userNumber) throws Exception {
		
		return dao.courseNoUploadNameRead(userNumber);
	}
	
	@Override
	public List<String> courseNoUploadNameRead(int userNumber) throws Exception {
		
		return dao.courseNoUploadNameRead(userNumber);
		
	}
	
	@Override
	public List<String> courseUploadNameRead(int userNumber) throws Exception {
		
		return dao.courseUploadNameRead(userNumber);
		
	}
	
	@Override
	public void update(CourseVO vo) throws Exception {
		
		dao.update(vo);
	}
	
	@Override
	public int courseNumByName(String courseName) throws Exception {
		
		return dao.courseNumByName(courseName);
	}
	
	@Override
	public void delete(int courseNumber) throws Exception {
		dao.delete(courseNumber);
	}
	
	@Override
	public List<CourseVO> simpleViewAll(int userNumber) throws Exception {
		
		return dao.simpleViewAll(userNumber);
	}


}
