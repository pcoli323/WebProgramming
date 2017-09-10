package org.tour.service;

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
	
}
