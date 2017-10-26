package org.tour.service;

import org.tour.domain.LikeVO;

public interface LikeService {

	public void add(LikeVO vo) throws Exception;
	
	public int count(int courseNumber) throws Exception;
	
	public int check(LikeVO vo) throws Exception;
	
	public void delete(LikeVO vo) throws Exception;
	
	public void deletePost(int courseNumber) throws Exception;
}