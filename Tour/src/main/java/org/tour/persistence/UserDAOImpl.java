package org.tour.persistence;

import java.util.HashMap;
import java.util.List;

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

	@Override
	public int exist(String email) {
		return session.selectOne(namespace + ".exist", email);
	}

	@Override
	public List<Integer> search(String keyword) throws Exception {
		
		return session.selectList(namespace + ".search", keyword);
	}

	@Override
	public void updatePWD(String email, String pwd) {
		
		HashMap<String,String> hash = new HashMap<String,String>();
		hash.put("email", email);
		hash.put("pwd", pwd);
		System.out.println(email+":"+pwd);
		System.out.println(hash);
		session.update(namespace + ".update", hash);
		
		
	}

	@Override
	public void updateUser(HashMap<String, Object> updateUser) throws Exception {
		
		session.update(namespace + ".updateUser", updateUser);
	}

	@Override
	public void deleteAll(int userNumber) throws Exception {
		
		session.delete(namespace + ".deleteAll", userNumber);
	}
}
