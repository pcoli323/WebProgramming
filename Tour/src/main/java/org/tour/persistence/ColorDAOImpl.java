package org.tour.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ColorDAOImpl implements ColorDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.ColorMapper";

	@Override
	public String color(int colorNumber) throws Exception {
		
		return session.selectOne(namespace + ".color", colorNumber);
	}

	@Override
	public List<String> colors() throws Exception {

		return session.selectList(namespace + ".colors");
	}
}
