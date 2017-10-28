package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.ColorDAO;

@Service
public class ColorServiceImpl implements ColorService {

	@Inject
	private ColorDAO dao;

	@Override
	public String color(int colorNumber) throws Exception {
		
		return dao.color(colorNumber);
	}
}
