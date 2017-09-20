package org.tour.service;

import java.util.List;

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

	@Override
	public List<SigunguVO> selectAll() throws Exception {

		return dao.selectAll();
	}
	
}
