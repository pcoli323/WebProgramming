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
	private ReplyDAO replyDAO;
	@Inject
	private UserService userService;
	
	@Override
	public List<ReplyVO> list(int courseNumber, Criteria cri) throws Exception {
		
		List<ReplyVO> replyVOs = replyDAO.list(courseNumber, cri);
		for(int i=0; i<replyVOs.size(); i++) {
			ReplyVO replyVO = replyVOs.get(i);
			replyVO.setReplyerName(userService.readName(replyVO.getReplyer()));
		}
		return replyVOs;
	}

	@Override
	public int count(int courseNumber) throws Exception {
		
		return replyDAO.count(courseNumber);
	}
	
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		
		replyDAO.create(vo);
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		
		replyDAO.update(vo);
	}

	@Override
	public void deleteReply(int replyNumber) throws Exception {
		
		replyDAO.delete(replyNumber);
	}
}
