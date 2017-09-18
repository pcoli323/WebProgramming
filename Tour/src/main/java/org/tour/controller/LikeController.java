package org.tour.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.tour.domain.LikeVO;
import org.tour.service.LikeService;

@RestController
@RequestMapping("/like")
public class LikeController {

	@Inject
	private LikeService service;
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseEntity<String> add(@RequestBody LikeVO vo){
		
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
	
	@RequestMapping(value = "/count/{courseNumber}", method = RequestMethod.GET)
	public ResponseEntity<Integer> count(@PathVariable("courseNumber") int courseNumber){
		
		ResponseEntity<Integer> entity = null;
		try {
			entity = new ResponseEntity<Integer>(service.count(courseNumber), HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public ResponseEntity<Integer> check(@RequestBody LikeVO vo){
		
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
	public ResponseEntity<String> delete(@RequestBody LikeVO vo){
		
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
