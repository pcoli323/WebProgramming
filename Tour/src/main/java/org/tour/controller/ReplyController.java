package org.tour.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.tour.domain.Criteria;
import org.tour.domain.PageMaker;
import org.tour.domain.ReplyVO;
import org.tour.service.ReplyService;

@RestController
@RequestMapping("/replise")
public class ReplyController {
	
	@Inject
	private ReplyService service;
	
	@RequestMapping(value = "/list/{courseNumber}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("courseNumber") int courseNumber,
														@PathVariable("page") int page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<ReplyVO> list = service.list(courseNumber, cri);
			
			map.put("list", list);
			
			int replyCnt = service.count(courseNumber);
			pageMaker.setTotalCount(replyCnt);
			
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseEntity<String> add(@RequestBody ReplyVO vo){
		
		ResponseEntity<String> entity = null;
		try {
			if(vo.getReply().equals("")) {
				return entity;
			}
			service.add(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/modify/{replyNumber}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("replyNumber") int replyNumber, @RequestBody ReplyVO vo){
		
		ResponseEntity<String> entity = null;
		try {
			vo.setReplyNumber(replyNumber);
			service.modify(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/delete/{replyNumber}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("replyNumber") int replyNumber){
		
		ResponseEntity<String> entity = null;
		try {
			service.delete(replyNumber);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

}
