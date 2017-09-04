package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.ShareDAO;

@Service
public class ShareServiceImpl implements ShareService {

	@Inject
	private ShareDAO dao;
	
}
