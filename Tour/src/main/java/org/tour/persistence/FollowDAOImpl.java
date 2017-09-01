package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

public class FollowDAOImpl implements FollowDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.FollowMapper";
	
}
