package org.tour.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.tour.domain.CourseInfoVO;
import org.tour.domain.CourseVO;
import org.tour.service.CourseInfoService;
import org.tour.service.CourseService;

@RestController
@RequestMapping("/get")
public class GetCourseController {

	@Inject
	private CourseService courseService;
	@Inject
	private CourseInfoService courseInfoService;
	
	@RequestMapping(value = "/course", method = RequestMethod.POST)
	public ResponseEntity<String> get (@RequestBody CourseVO courseVO){
		
		ResponseEntity<String> entity = null;
		try {
			int prevCourseNumber = courseVO.getCourseNumber();
			courseVO.setCourseNumber(0);
			courseVO.setGotten(true);
			courseService.add(courseVO);
			int newCourseNumber = courseService.newCourseNumber(courseVO.getUserNumber());
			List<CourseInfoVO> courseInfoList = courseInfoService.readAll(prevCourseNumber);
			for(int i = 0; i<courseInfoList.size(); i++) {
				CourseInfoVO courseInfoVO = courseInfoList.get(i);
				courseInfoVO.setCourseNumber(newCourseNumber);
				courseInfoService.add(courseInfoVO);
			}
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
