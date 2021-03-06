package org.tour.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String allCourseName(HashMap<String, Object> courseNameCompare) throws Exception {
		
		return dao.allCourseName(courseNameCompare);
	}

	@Override
	public String courseReadName(int courseNumber) throws Exception {
		
		return dao.courseReadName(courseNumber);
	}

	@Override
	public List<Integer> noUploadCourseNumber(int userNumber) throws Exception {
		
		return dao.noUploadCourseNumber(userNumber);
	}

	@Override
	public List<Integer> uploadCourseNumber(int userNumber) throws Exception {
		
		return dao.uploadCourseNumber(userNumber);
	}
	
	@Override
	public void update(CourseVO vo) throws Exception {
		
		dao.update(vo);
	}
	
	@Override
	public void delete(int courseNumber) throws Exception {
		dao.delete(courseNumber);
	}
	
	@Override
	public List<CourseVO> simpleViewAll(int userNumber) throws Exception {
		
		return dao.simpleViewAll(userNumber);
	}
	
	@Override
	public List<Integer> searchAll() throws Exception {
		
		return dao.searchAll();
	}
	
	@Override
	public List<Integer> searchAccordingToAreaAndSigunguCode(List<Map<String, Integer>> areaAndSigunguCode)throws Exception {
		
		return dao.searchAccordingToAreaAndSigunguCode(areaAndSigunguCode);
	}
	
	@Override
	public List<Integer> searchAccordingToUserNumber(int userNumber) throws Exception {
		
		return dao.searchAccordingToUserNumber(userNumber);
	}
	
	@Override
	public void deletePost(int courseNumber) throws Exception {
		
		dao.deletePost(courseNumber);
	}
	
	@Override
	public Integer noUploadCourseNumberRead(int userNumber) throws Exception {
		return dao.noUploadCourseNumberRead(userNumber);
	}

	@Override
	public void modifyInModify(CourseVO vo) throws Exception {

		dao.modifyInModify(vo);
		
	}

	@Override
	public void deleteAll(int userNumber) throws Exception {
		
		dao.deleteAll(userNumber);
	}

	@Override
	public List<Integer> deleteCourseRead(int userNumber) throws Exception {
		
		return dao.deleteCourseRead(userNumber);
	}
}
