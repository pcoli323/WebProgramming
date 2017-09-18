package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.AreaVO;
import org.tour.persistence.AreaDAO;

@Service
public class AreaServiceImpl implements AreaService {

	@Inject
	private AreaDAO dao;

	@Override
	public void add(AreaVO vo) throws Exception {

		dao.add(vo);
		
	}
	
}
