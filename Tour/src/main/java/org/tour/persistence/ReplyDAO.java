package org.tour.persistence;

import java.util.List;

import org.tour.domain.Criteria;
import org.tour.domain.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> list(int courseNumber, Criteria cri) throws Exception;
	
	public int count(int courseNumber) throws Exception;
	
	public void create(ReplyVO vo) throws Exception;
	
	public void update(ReplyVO vo) throws Exception;
	
	public void delete(int replyNumber) throws Exception;
	
	public void deletePost(int courseNumber) throws Exception;
	
	public void deleteAll(int userNumber) throws Exception;
}