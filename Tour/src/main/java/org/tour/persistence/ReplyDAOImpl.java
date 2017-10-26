package org.tour.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.Criteria;
import org.tour.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.ReplyMapper";
	
	@Override
	public List<ReplyVO> list(int courseNumber, Criteria cri) throws Exception {
		
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("courseNumber", courseNumber);
		paramMap.put("cri", cri);
		
		return session.selectList(namespace + ".list", paramMap);
	}

	@Override
	public int count(int courseNumber) throws Exception {
		
		return session.selectOne(namespace + ".count", courseNumber);
	}
	
	@Override
	public void create(ReplyVO vo) throws Exception {
		
		session.insert(namespace + ".create", vo);
	}

	@Override
	public void update(ReplyVO vo) throws Exception {
		
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(int replyNumber) throws Exception {
		
		session.delete(namespace + ".delete", replyNumber);
	}
	
	@Override
	public void deletePost(int courseNumber) throws Exception {
		
		session.delete(namespace + ".deletePost", courseNumber);
	}
}
