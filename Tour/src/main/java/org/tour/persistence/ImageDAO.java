package org.tour.persistence;

import org.tour.domain.ImageVO;

public interface ImageDAO {

	public void create(ImageVO vo) throws Exception;
	
	public Object get(String title) throws Exception;
}
