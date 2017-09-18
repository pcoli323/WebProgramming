package org.tour.service;

import java.util.List;

import org.tour.domain.Criteria;

import org.tour.domain.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> list(int courseNumber, Criteria cri) throws Exception;
	
	public int count(int courseNumber) throws Exception;
	
	public void addReply(ReplyVO vo) throws Exception;
	
	public void modifyReply(ReplyVO vo) throws Exception;
	
	public void deleteReply(int replyNumber) throws Exception;
}
