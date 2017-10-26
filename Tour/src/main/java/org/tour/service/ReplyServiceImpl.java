package org.tour.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.Criteria;
import org.tour.domain.ReplyVO;
import org.tour.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO dao;
	@Inject
	private UserService userService;
	
	@Override
	public List<ReplyVO> list(int courseNumber, Criteria cri) throws Exception {
		
		List<ReplyVO> replyVOs = dao.list(courseNumber, cri);
		for(int i=0; i<replyVOs.size(); i++) {
			ReplyVO replyVO = replyVOs.get(i);
			replyVO.setReplyerName(userService.read(replyVO.getReplyer()).getUserName());
		}
		return replyVOs;
	}

	@Override
	public int count(int courseNumber) throws Exception {
		
		return dao.count(courseNumber);
	}
	
	@Override
	public void add(ReplyVO vo) throws Exception {
		
		dao.create(vo);
	}

	@Override
	public void modify(ReplyVO vo) throws Exception {
		
		dao.update(vo);
	}

	@Override
	public void delete(int replyNumber) throws Exception {
		
		dao.delete(replyNumber);
	}
	
	@Override
	public void deletePost(int courseNumber) throws Exception {
		
		dao.deletePost(courseNumber);
	}
}
