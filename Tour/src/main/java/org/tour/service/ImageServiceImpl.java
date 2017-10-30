package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.ImageVO;
import org.tour.persistence.ImageDAO;

@Service
public class ImageServiceImpl implements ImageService {

	@Inject
	private ImageDAO dao;
	
	@Override
	public void insertImage(ImageVO vo) throws Exception {
		
		try {
			dao.create(vo);
		}catch(Exception e) {
			System.out.println("error in ImageService");
		}
	}

	@Override
	public Object getRealImage(int ImageNumber) throws Exception {
		
		return dao.getRealImage(ImageNumber);
	}

	@Override
	public Object getThumImage(int imageNumber) throws Exception {
		
		return dao.getThumImage(imageNumber);
	}
	
	@Override
	public String getType(int imageNumber) throws Exception {
		
		return dao.getType(imageNumber);
	}
/*
	@Override
	public void deleteIamge(int imageNumber) throws Exception {
		
		dao.delete(imageNumber);
	}
	*/

	@Override
	public void deleteAll(int userNumber) throws Exception {
	
		dao.deleteAll(userNumber);
	}
}
