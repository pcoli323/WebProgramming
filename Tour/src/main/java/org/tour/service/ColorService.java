package org.tour.service;

import java.util.List;

public interface ColorService {

	public String color(int colorNumber) throws Exception;
	
	public List<String> colors() throws Exception;
}
