package org.tour.persistence;

import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;

public interface UserDAO {
	public void create(UserVO vo) throws Exception;
	public UserVO login(LoginDTO dto) throws Exception;
}
