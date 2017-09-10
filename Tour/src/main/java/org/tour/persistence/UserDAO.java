package org.tour.persistence;

import org.tour.domain.UserVO;

public interface UserDAO {
	public void create(UserVO vo) throws Exception;
}
