package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

public class CourseInfoDAOImpl implements CourseInfoDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.CourseInfoMapper";
	
}
