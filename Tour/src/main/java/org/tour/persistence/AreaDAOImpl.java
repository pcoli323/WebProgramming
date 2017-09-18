package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.AreaVO;

@Repository
public class AreaDAOImpl implements AreaDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.AreaMapper";

	@Override
	public void add(AreaVO vo) throws Exception {

		session.insert(namespace + ".add", vo);
		
	}
	
}
