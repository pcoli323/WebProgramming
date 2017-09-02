package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.FollowDAO;

@Service
public class FollowServiceImpl implements FollowService {

	@Inject
	private FollowDAO dao;
	
}
