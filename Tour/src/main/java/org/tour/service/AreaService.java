package org.tour.service;

import java.util.List;
import java.util.Map;

import org.tour.domain.AreaVO;

public interface AreaService {

	public void add(AreaVO vo) throws Exception;
	public List<AreaVO> selectAll() throws Exception;
	
	public List<Map<String, Integer>> search(String keyword) throws Exception;
}
