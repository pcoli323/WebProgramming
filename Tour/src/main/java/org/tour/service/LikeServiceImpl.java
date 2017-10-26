package org.tour.service;

import java.util.List;

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

	@Override
	public int check(LikeVO vo) throws Exception {
		
		return dao.check(vo);
	}

	@Override
	public void delete(LikeVO vo) throws Exception {
		
		dao.delete(vo);
	}

	@Override
	public List<Integer> getTop3() throws Exception {
		return dao.getTop3();
	}
	
	@Override
	public void deletePost(int courseNumber) throws Exception {
		
		dao.deletePost(courseNumber);
	}
}