package org.tour.persistence;

import org.tour.domain.ImageVO;

public interface ImageDAO {

	public void create(ImageVO vo) throws Exception;
	
	public Object getRealImage(int imageNumber);

	public Object getThumImage(int imageNumber);
	
	public String getType(int imageNumber);
	
	//public void delete(int imageNumber);
}
