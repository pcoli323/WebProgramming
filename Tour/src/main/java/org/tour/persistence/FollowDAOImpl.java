package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.FollowVO;

@Repository
public class FollowDAOImpl implements FollowDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.FollowMapper";

	@Override
	public void add(FollowVO vo) throws Exception {
		
		session.insert(namespace + ".add", vo);
	}
	
}
