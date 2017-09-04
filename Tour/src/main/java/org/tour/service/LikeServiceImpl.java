package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.LikeDAO;

@Service
public class LikeServiceImpl implements LikeServie {

	@Inject
	private LikeDAO dao;
	
}
