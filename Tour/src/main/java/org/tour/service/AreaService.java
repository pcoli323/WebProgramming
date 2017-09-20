package org.tour.service;

import java.util.List;

import org.tour.domain.AreaVO;

public interface AreaService {

	public void add(AreaVO vo) throws Exception;
	public List<AreaVO> selectAll() throws Exception;
}
