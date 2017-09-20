package org.tour.persistence;

import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;

public interface UserDAO {
	
	public void create(UserVO user) throws Exception;
	
	public UserVO login(LoginDTO dto) throws Exception;
	
	public UserVO read(int userNumber) throws Exception;

}
