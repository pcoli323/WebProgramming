package org.tour.service;

import java.util.HashMap;
import java.util.List;

import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;

public interface UserService {
	
	public void register(UserVO user) throws Exception;
	
	public UserVO login(LoginDTO loginDto) throws Exception;
	
	public UserVO read(int userNumber) throws Exception;
	
	public int exist(String email) throws Exception;
	
	public List<Integer> search(String keyword) throws Exception;
	
	public void updatePWD(String email, String pwd);
	
	public void updateUser(HashMap<String, Object> updateUser) throws Exception;
	
	public void deleteAll(int userNumber) throws Exception;
}
