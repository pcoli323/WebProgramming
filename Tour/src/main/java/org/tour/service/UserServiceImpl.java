package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;
	
}
