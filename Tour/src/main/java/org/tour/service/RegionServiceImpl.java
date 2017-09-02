package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.RegionDAO;

@Service
public class RegionServiceImpl implements RegionService {

	@Inject
	private RegionDAO dao;
	
}
