package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.GotoDAO;

@Service
public class GotoServiceImpl implements GotoService {

	@Inject
	private GotoDAO dao;
	
}
