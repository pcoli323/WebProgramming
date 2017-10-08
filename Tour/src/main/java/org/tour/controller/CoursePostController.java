package org.tour.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.tour.domain.CourseVO;
import org.tour.domain.UserVO;
import org.tour.dto.CourseInfoDTO;
import org.tour.service.CourseInfoService;
import org.tour.service.CourseService;
import org.tour.service.PlanService;

@Controller
@RequestMapping("/mypage/*")
public class CoursePostController {
	
	@Inject
	private CourseService courseService;
	@Inject
	private PlanService planService;
	@Inject
	private CourseInfoService courseInfoService;
	

	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public void coursePost(HttpServletRequest request, @RequestParam("courseNumber") int courseNumber, Model model) throws Exception{
		
		try {
			HttpSession	session = request.getSession();
			UserVO loginUser = new UserVO();;
			if(session.getAttribute("login") == null) {
				model.addAttribute("loginCheck", false);
				loginUser.setUserNumber(-1);
				loginUser.setEmail(null);
				loginUser.setPwd(null);
				loginUser.setUserName(null);
			}
			else {
				model.addAttribute("loginCheck", true);
				loginUser = (UserVO) session.getAttribute("login");
			}
			//test
			loginUser.setUserNumber(1);
			loginUser.setEmail("user00@aaa.com");
			loginUser.setPwd("user00");
			loginUser.setUserName("user00");
			model.addAttribute("loginCheck", true);
			
			CourseVO courseVO = courseService.read(courseNumber);
			Map<String, List<CourseInfoDTO>> plan = planService.gotoListAccordingToDate(courseNumber);
			
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("courseNumber", courseNumber);
			model.addAttribute("courseVO", courseVO);
			model.addAttribute("plan", plan);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/updateCourse", method = RequestMethod.POST)
	public ResponseEntity<String> updateCourse(@RequestBody String courseData) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			JSONParser parser = new JSONParser();
			JSONObject object = (JSONObject)parser.parse(courseData);
			CourseVO courseVO = new CourseVO();
			courseVO.setCourseNumber((int)(long)object.get("courseNumber"));
			courseVO.setCourseName((String)object.get("courseName"));
			courseVO.setStory((String)object.get("story"));
			courseService.update(courseVO);
			entity = new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String> (e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/representativeMark", method = RequestMethod.POST)
	public ResponseEntity<String> representativeMark(@RequestBody String representativeData) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			JSONParser parser = new JSONParser();
			JSONObject object = (JSONObject)parser.parse(representativeData);
			int courseNumber = (int)(long)object.get("courseNumber");
			courseInfoService.initialRepresented(courseNumber);
			JSONArray representatives = (JSONArray)object.get("representatives");
			for(int i = 0; i<representatives.size(); i++) {
				courseInfoService.representativeMark(Integer.parseInt((String)representatives.get(i)), i+1);
			}
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
