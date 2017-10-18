package org.tour.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.SigunguVO;

@Repository
public class SigunguDAOImpl implements SigunguDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.SigunguMapper";

	@Override
	public void add(SigunguVO vo) throws Exception {

		session.insert(namespace + ".add", vo);
		
	}

	@Override
	public List<SigunguVO> selectAll() throws Exception {
		
		return session.selectList(namespace + ".selectAll");
	}

	@Override
	public List<Map<String, Integer>> search(String keyword) throws Exception {
		
		return session.selectList(namespace + ".search", keyword);
	}
	
}
