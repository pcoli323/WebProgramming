package org.tour.service;

import org.tour.domain.ImageVO;

public interface ImageService {

	public void insertImage(ImageVO vo) throws Exception;
	
	public Object getImage(String title) throws Exception;
}
