package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.UserMapper";

	@Override
	public void create(UserVO vo) throws Exception {
		session.insert(namespace+".create",vo);
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return session.selectOne(namespace+".login",dto);
	}
	
	@Override
	public UserVO read(int userNumber) throws Exception {
		
		return session.selectOne(namespace + ".read", userNumber);
	}
}
