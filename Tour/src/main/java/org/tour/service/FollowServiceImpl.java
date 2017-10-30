package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.FollowVO;
import org.tour.persistence.FollowDAO;

@Service
public class FollowServiceImpl implements FollowService {

	@Inject
	private FollowDAO dao;

	@Override
	public void add(FollowVO vo) throws Exception {
		
		dao.add(vo);
	}
	
	@Override
	public int check(FollowVO vo) throws Exception {
		
		return dao.check(vo);
	}
	
	@Override
	public void delete(FollowVO vo) throws Exception {
		
		dao.delete(vo);
	}

	@Override
	public void deleteAll(int userNumber) throws Exception {
		
		dao.deleteAll(userNumber);
	}
}
