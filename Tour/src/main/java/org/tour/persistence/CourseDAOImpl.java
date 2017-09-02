package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CourseDAOImpl implements CourseDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.CourseMapper";
	
}
