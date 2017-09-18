package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class GotoDAOImpl implements GotoDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.GotoMapper";

	@Override
	public String readName(String gotoCode) throws Exception {
		
		return session.selectOne(namespace + ".readName", gotoCode);
	}
}
