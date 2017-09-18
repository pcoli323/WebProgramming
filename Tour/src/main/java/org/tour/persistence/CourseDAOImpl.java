package org.tour.persistence;

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
	
}
