package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.LikeVO;
import org.tour.persistence.LikeDAO;

@Service
public class LikeServiceImpl implements LikeService {

	@Inject
	private LikeDAO dao;

	@Override
	public void add(LikeVO vo) throws Exception {
		
		dao.add(vo);
	}

	@Override
	public int count(int courseNumber) throws Exception {
		
		return dao.count(courseNumber);
	}
	
}