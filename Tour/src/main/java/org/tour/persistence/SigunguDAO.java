package org.tour.persistence;

import java.util.List;

import org.tour.domain.SigunguVO;

public interface SigunguDAO {

	public void add(SigunguVO vo) throws Exception;
	public List<SigunguVO> selectAll() throws Exception;
	
}
