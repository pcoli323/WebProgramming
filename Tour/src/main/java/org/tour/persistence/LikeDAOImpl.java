package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.LikeVO;

@Repository
public class LikeDAOImpl implements LikeDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.LikeMapper";

	@Override
	public void add(LikeVO vo) throws Exception {

		session.insert(namespace + ".add", vo);
	}
	
}
