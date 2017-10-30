package org.tour.service;

import java.util.List;

import org.tour.domain.FollowVO;

public interface FollowService {

	public void add(FollowVO vo) throws Exception;
	
	public int check(FollowVO vo) throws Exception;
	
	public void delete(FollowVO vo) throws Exception;
	
	public void deleteAll(int userNumber) throws Exception;
	
	public List<Integer> read (int userNumber) throws Exception;
}
