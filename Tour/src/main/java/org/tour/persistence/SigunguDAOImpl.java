package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.SigunguVO;

@Repository
public class SigunguDAOImpl implements SigunguDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.SigunguMapper";

	@Override
	public void add(SigunguVO vo) throws Exception {

		session.insert(namespace + ".add", vo);
		
	}
	
}
