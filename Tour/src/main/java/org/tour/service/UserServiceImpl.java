package org.tour.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;
import org.tour.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;
	
	@Override
	public void register(UserVO user) throws Exception {
		dao.create(user);
	}
	
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return dao.login(dto);
	}
	
	@Override
	public UserVO read(int userNumber) throws Exception {
		
		return dao.read(userNumber);
	}

	@Override
	public int exist(String email) throws Exception {
		return dao.exist(email);
	}

	@Override
	public List<Integer> search(String keyword) throws Exception {
		
		return dao.search(keyword);
	}

	@Override
	public void updatePWD(String email, String pwd) {

		dao.updatePWD(email, pwd);
		
	}
}
