package org.tour.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.CourseInfoVO;

@Repository
public class CourseInfoDAOImpl implements CourseInfoDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.CourseInfoMapper";

	@Override
	public List<CourseInfoVO> representatives(int courseNumber) throws Exception {
		
		return session.selectList(namespace + ".representatives", courseNumber);
	}

	@Override
	public String getRealImage(int gotoNumber) throws Exception {
		
		return session.selectOne(namespace + ".getRealImage", gotoNumber);
	}
	
	@Override
	public List<Date> dates(int courseNumber) throws Exception {
		
		return session.selectList(namespace + ".dates", courseNumber);
	}

	@Override
	public List<CourseInfoVO> readAccordingToDate(HashMap<String, Object> courseNumberAndDate) throws Exception {
		
		return session.selectList(namespace + ".readAccordingToDate", courseNumberAndDate);
	}
	
	@Override
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception {
		
		return session.selectList(namespace + ".readAll", courseNumber);
	}

	@Override
	public void add(CourseInfoVO vo) throws Exception {
		
		session.insert(namespace + ".add", vo);
	}

	@Override
	public void courseInfoAdd(CourseInfoVO vo) throws Exception {
		session.insert(namespace + ".courseInfoAdd", vo);
		//int courseNumber, CourseInfoVO vo
	}

	@Override
	public void changeImage(HashMap<String, Object> data) throws Exception {
		
		session.update(namespace + ".changeImage", data);
	}

	@Override
	public void deleteImage(int gotoNumber) throws Exception {

		session.update(namespace + ".deleteImage", gotoNumber);
	}

	@Override
	public void representativeMark(HashMap<String, Object> data) throws Exception {

		session.update(namespace + ".representativeMark", data);
	}

}
