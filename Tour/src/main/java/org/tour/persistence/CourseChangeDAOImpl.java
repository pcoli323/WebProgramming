package org.tour.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.CourseInfoVO;
import org.tour.domain.CourseVO;
import org.tour.dto.CourseIDDTO;

@Repository
public class CourseChangeDAOImpl implements CourseChangeDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.CourseChangeMapper";

	@Override
	public List<CourseIDDTO> getCourseIDList(int courseNumber) throws Exception {

		return session.selectList(namespace + ".courseid", courseNumber);
	}

	@Override
	public List<CourseInfoVO> getCoursesList(int courseNumber) throws Exception {

		return session.selectList(namespace + ".courses", courseNumber);
	}
	
}
