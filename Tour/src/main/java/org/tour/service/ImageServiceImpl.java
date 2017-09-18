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
	public Object getImage(String title) throws Exception {
		
		return dao.get(title);
	}

}
