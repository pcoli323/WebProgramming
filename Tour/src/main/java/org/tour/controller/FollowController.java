package org.tour.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.tour.domain.FollowVO;
import org.tour.service.FollowService;

@RestController
@RequestMapping("/follow")
public class FollowController {

	@Inject
	private FollowService service;
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseEntity<String> add(@RequestBody FollowVO vo){
		
		ResponseEntity<String> entity = null;
		try {
			service.add(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public ResponseEntity<Integer> check(@RequestBody FollowVO vo){
		
		ResponseEntity<Integer> entity = null;
		try {
			entity = new ResponseEntity<Integer>(service.check(vo), HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	public ResponseEntity<String> delete(@RequestBody FollowVO vo){
		
		ResponseEntity<String> entity = null;
		try {
			service.delete(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
