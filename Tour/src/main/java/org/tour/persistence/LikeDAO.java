package org.tour.persistence;

import java.util.List;

import org.tour.domain.LikeVO;

public interface LikeDAO {

	public void add(LikeVO vo) throws Exception;
	
	public int count(int courseNumber) throws Exception;
	
	public int check(LikeVO vo) throws Exception;
	
	public void delete(LikeVO vo) throws Exception;

	public List<Integer> getTop3() throws Exception;
}
