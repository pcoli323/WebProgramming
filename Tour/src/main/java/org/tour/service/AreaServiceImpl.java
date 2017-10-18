package org.tour.service;

import java.util.List;

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

	@Override
	public List<AreaVO> selectAll() throws Exception {

		return dao.selectAll();
		
	}

	@Override
	public List<Integer> search(String keyword) throws Exception {
		
		return dao.search(keyword);
	}
	
}
