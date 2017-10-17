package org.tour.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.CourseVO;

@Repository
public class CourseDAOImpl implements CourseDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.CourseMapper";

	@Override
	public CourseVO read(int courseNumber) throws Exception {
		
		return session.selectOne(namespace + ".read", courseNumber);
	}

	@Override
	public void add(CourseVO vo) throws Exception {
		
		session.insert(namespace + ".add", vo);
	}
	
	@Override
	public int newCourseNumber(int userNumber) throws Exception {
		
		return session.selectOne(namespace + ".newCourseNumber", userNumber);
	}

	@Override
	public void courseAdd(CourseVO vo) throws Exception {
		
		session.insert(namespace + ".courseAdd", vo);
	}
	
	@Override
	public int courseNumberRead(int userNumber) throws Exception {

		return session.selectOne(namespace + ".courseNumberRead", userNumber);
	}
	
	@Override
	public List<String> allCourseName(int userNumber) throws Exception {
		
		return session.selectList(namespace + ".allCourseName", userNumber);
	}
	
	@Override
	public String courseReadName(int courseNumber) throws Exception {
		
		return session.selectOne(namespace + ".courseReadName", courseNumber);
	}

	@Override
	public List<Integer> noUploadCourseNumber(int userNumber) throws Exception {
		
		return session.selectList(namespace + ".noUploadCourseNumber", userNumber);
	}

	@Override
	public List<Integer> uploadCourseNumber(int userNumber) throws Exception {
		
		return session.selectList(namespace + ".uploadCourseNumber", userNumber);
	}
	
	@Override
	public void update(CourseVO vo) throws Exception {
		
		session.update(namespace + ".update", vo);
	}
	
	@Override
	public void delete(int courseNumber) throws Exception {
		
		session.delete(namespace + ".delete", courseNumber);
	}
	
	@Override
	public List<CourseVO> simpleViewAll(int userNumber) throws Exception {
		
		return session.selectList(namespace + ".simpleViewAll", userNumber);
	}
}
