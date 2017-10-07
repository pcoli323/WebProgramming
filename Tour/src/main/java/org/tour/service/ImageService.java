package org.tour.service;

import org.tour.domain.ImageVO;

public interface ImageService {

	public void insertImage(ImageVO vo) throws Exception;
	
	public Object getRealImage(int ImageNumber) throws Exception;

	public Object getThumImage(int imageNumber) throws Exception;
	
	public String getType(int imageNumber) throws Exception;
	
	//public void deleteIamge(int imageNumber) throws Exception;
}
