package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.AuthorizingVO;
import org.tour.persistence.AuthorizingDAO;

@Service
public class AuthorizingServiceImpl implements AuthorizingService {

	@Inject
	private AuthorizingDAO dao;

	@Override
	public int exist(String email) {
		return dao.exist(email);
	}

	@Override
	public void add(AuthorizingVO authorizingVO) {
		dao.add(authorizingVO);
		
	}

	@Override
	public void update(AuthorizingVO authorizingVO) {
		dao.update(authorizingVO);
	}

	@Override
	public int check(AuthorizingVO authorizingVO) {
		return dao.check(authorizingVO);
	}

	@Override
	public void delete(String email) {
		dao.delete(email);
	}
}
