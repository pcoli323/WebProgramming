package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.AuthorizingVO;

@Repository
public class AuthorizingDAOImpl implements AuthorizingDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.AuthorizingMapper";

	@Override
	public int exist(String email) {
		return session.selectOne(namespace + ".exist", email);
	}

	@Override
	public void add(AuthorizingVO authorizingVO) {
		session.insert(namespace + ".add", authorizingVO);
	}

	@Override
	public void update(AuthorizingVO authorizingVO) {
		session.update(namespace + ".update", authorizingVO);
	}

	@Override
	public int check(AuthorizingVO authorizingVO) {
		return session.selectOne(namespace + ".check", authorizingVO);
	}

	@Override
	public void delete(String email) {
		session.delete(namespace + ".delete", email);
	}
}
