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
	
}
