package org.tour.service;

import java.util.List;
import java.util.Map;

import org.tour.domain.SigunguVO;

public interface SigunguService {

	public void add(SigunguVO vo) throws Exception;
	public List<SigunguVO> selectAll() throws Exception;
	
	public List<Map<String, Integer>> search(String keyword) throws Exception;
}
