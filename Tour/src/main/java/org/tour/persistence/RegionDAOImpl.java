package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

public class RegionDAOImpl implements RegionDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.RegionMapper";
	
}
