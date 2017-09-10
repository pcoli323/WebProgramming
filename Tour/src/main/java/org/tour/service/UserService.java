package org.tour.service;

import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;

public interface UserService {
	public void register(UserVO user) throws Exception;
	public UserVO login(LoginDTO dto) throws Exception;
}
