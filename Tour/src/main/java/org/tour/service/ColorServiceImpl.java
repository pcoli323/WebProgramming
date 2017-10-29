package org.tour.service;

import java.util.List;

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

	@Override
	public List<String> colors() throws Exception {

		return dao.colors();
	}
}
