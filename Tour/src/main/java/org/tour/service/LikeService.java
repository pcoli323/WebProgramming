package org.tour.service;

import org.tour.domain.LikeVO;

public interface LikeService {

	public void add(LikeVO vo) throws Exception;
	
	public int count(int courseNumber) throws Exception;
}