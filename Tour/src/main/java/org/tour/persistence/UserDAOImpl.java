package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.UserMapper";

	@Override
	public void create(UserVO vo) throws Exception {
		session.insert(namespace+".create",vo);
	}
	
}
