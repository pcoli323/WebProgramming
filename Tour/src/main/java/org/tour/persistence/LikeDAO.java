package org.tour.persistence;

import org.tour.domain.LikeVO;

public interface LikeDAO {

	public void add(LikeVO vo) throws Exception;
	
	public int count(int courseNumber) throws Exception;
}
