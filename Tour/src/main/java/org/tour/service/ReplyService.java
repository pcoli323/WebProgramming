package org.tour.service;

import java.util.List;

import org.tour.domain.Criteria;

import org.tour.domain.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> list(int courseNumber, Criteria cri) throws Exception;
	
	public int count(int courseNumber) throws Exception;
	
	public void add(ReplyVO vo) throws Exception;
	
	public void modify(ReplyVO vo) throws Exception;
	
	public void delete(int replyNumber) throws Exception;
	
	public void deletePost(int courseNumber) throws Exception;
}
