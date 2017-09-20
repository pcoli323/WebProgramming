package org.tour.service;

import java.util.List;

import org.tour.domain.SigunguVO;

public interface SigunguService {

	public void add(SigunguVO vo) throws Exception;
	public List<SigunguVO> selectAll() throws Exception;
}
