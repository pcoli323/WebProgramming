package org.tour.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.LikeVO;

@Repository
public class LikeDAOImpl implements LikeDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.LikeMapper";

	@Override
	public void add(LikeVO vo) throws Exception {

		session.insert(namespace + ".add", vo);
	}

	@Override
	public int count(int courseNumber) throws Exception {
		
		return session.selectOne(namespace + ".count", courseNumber);
	}

	@Override
	public int check(LikeVO vo) throws Exception {
		
		return session.selectOne(namespace + ".check", vo);
	}

	@Override
	public void delete(LikeVO vo) throws Exception {

		session.delete(namespace + ".delete", vo);
	}

	@Override
	public List<Integer> getTop3() throws Exception {
		return session.selectList(namespace + ".top3");
	}
	
	@Override
	public void deletePost(int courseNumber) throws Exception {
		
		session.delete(namespace + ".deletePost", courseNumber);
	}
}
