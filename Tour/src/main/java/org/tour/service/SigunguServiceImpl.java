package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.SigunguVO;
import org.tour.persistence.SigunguDAO;

@Service
public class SigunguServiceImpl implements SigunguService {

	@Inject
	private SigunguDAO dao;

	@Override
	public void add(SigunguVO vo) throws Exception {

		dao.add(vo);
		
	}
	
}
