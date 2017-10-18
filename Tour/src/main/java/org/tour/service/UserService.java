package org.tour.service;

import java.util.List;

import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;

public interface UserService {
	
	public void register(UserVO user) throws Exception;
	
	public UserVO login(LoginDTO loginDto) throws Exception;
	
	public UserVO read(int userNumber) throws Exception;
	
	public int exist(String email) throws Exception;
	
	public List<Integer> search(String keyword) throws Exception;
}
