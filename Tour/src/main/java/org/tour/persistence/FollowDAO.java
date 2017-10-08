package org.tour.persistence;

import org.tour.domain.FollowVO;

public interface FollowDAO {

	public void add(FollowVO vo) throws Exception;
	
	public int check(FollowVO vo) throws Exception;
	
	public void delete(FollowVO vo) throws Exception;
	
}
