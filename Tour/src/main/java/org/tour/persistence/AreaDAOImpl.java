package org.tour.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.AreaVO;

@Repository
public class AreaDAOImpl implements AreaDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.AreaMapper";

	@Override
	public void add(AreaVO vo) throws Exception {

		session.insert(namespace + ".add", vo);
		
	}

	@Override
	public List<AreaVO> selectAll() throws Exception {
		
		return session.selectList(namespace + ".selectAll");
	}

	@Override
	public List<Integer> search(String keyword) throws Exception {
		
		return session.selectList(namespace + ".search", keyword);
	}
	
}
