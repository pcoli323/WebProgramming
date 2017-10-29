package org.tour.persistence;

import java.util.List;

public interface ColorDAO {

	public String color(int colorNumber) throws Exception;

	public List<String> colors() throws Exception;
}
