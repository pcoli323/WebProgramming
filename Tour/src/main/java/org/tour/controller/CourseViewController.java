package org.tour.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.tour.domain.CourseInfoVO;
import org.tour.domain.CourseVO;
import org.tour.domain.UserVO;
import org.tour.dto.CourseInfoDTO;
import org.tour.dto.SimpleViewDTO;
import org.tour.service.CourseInfoService;
import org.tour.service.CourseService;
import org.tour.service.PlanService;
import org.tour.service.UserService;

import com.google.gson.Gson;

@Controller
@RequestMapping("/course/view/*")
public class CourseViewController {

	private static final Logger logger = LoggerFactory.getLogger(CourseViewController.class);
	
	@Inject
	private CourseService courseService;
	@Inject
	private UserService userService;
	@Inject
	private CourseInfoService courseInfoService;
	/*
	@Inject
	private GotoService gotoService;*/
	@Inject
	private PlanService planService;
	
	@RequestMapping(value = "/simple", method = RequestMethod.GET)
	public void readSimple(HttpServletRequest request, @RequestParam("courseNumber") int courseNumber, Model model) throws Exception {
		
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
			
			CourseVO courseVO = courseService.read(courseNumber);
			UserVO userVO = userService.read(courseVO.getUserNumber());
			List<CourseInfoVO> representatives = courseInfoService.representatives(courseNumber);
			//List<String> representativeNames = gotoService.readRepresentativeNames(representatives);
			
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("courseNumber", courseNumber);
			model.addAttribute("courseVO", courseVO);
			model.addAttribute("userVO", userVO);
			model.addAttribute("representatives", representatives);
			//model.addAttribute("representativeNames", representativeNames);
			
		} catch(Exception e) {
			logger.info("readSimple");
			e.printStackTrace();
		}
	}
	
	// test
	@RequestMapping(value = "/simple_2", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public ResponseEntity<String> readSimple_2(@RequestBody String data) throws Exception {
		
		ResponseEntity<String> entity = null;
		try {
			JSONParser parser = new JSONParser();
			JSONObject object = (JSONObject)parser.parse(data);
			JSONArray array = (JSONArray) object.get("list");
			//System.out.println(courseNumberList);
			List<SimpleViewDTO> courseList = new ArrayList<SimpleViewDTO>();
			for(int i=0; i<array.size(); i++) {
				int courseNumber = (int)(long)array.get(i);
				CourseVO courseVO = courseService.read(courseNumber);
				UserVO userVO = userService.read(courseVO.getUserNumber());
				List<CourseInfoVO> representatives = courseInfoService.representatives(courseNumber);
				SimpleViewDTO simpleViewDTO = new SimpleViewDTO();
				simpleViewDTO.setCourseNumber(courseVO.getCourseNumber());
				simpleViewDTO.setCourseName(courseVO.getCourseName());
				simpleViewDTO.setUserNumber(userVO.getUserNumber());
				simpleViewDTO.setUserName(userVO.getUserName());
				simpleViewDTO.setRepresentatives(representatives);
				courseList.add(simpleViewDTO);
			}
			Gson gson = new Gson();
			entity = new ResponseEntity<String>(gson.toJson(courseList), HttpStatus.OK);
			
		} catch(Exception e) {
			/*
			logger.info(e.toString());
			logger.info("simple_2");
			*/
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public void readDetail(HttpServletRequest request, @RequestParam("courseNumber") int courseNumber, Model model) throws Exception {
		
		try {
			/*
			LoginDTO loginDto = new LoginDTO();
			loginDto.setEmail("user00@aaa.com");
			loginDto.setPwd("user00");
			UserVO loginUserCheck = userService.login(loginDto);
			HttpSession	session = request.getSession();
			session.setAttribute("login", loginUserCheck);
			*/
			
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
			
			CourseVO courseVO = courseService.read(courseNumber);
			UserVO userVO = userService.read(courseVO.getUserNumber());
			Map<String, List<CourseInfoDTO>> plan = planService.gotoListAccordingToDate(courseNumber);
			
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("courseNumber", courseNumber);
			model.addAttribute("courseVO", courseVO);
			model.addAttribute("userVO", userVO);
			model.addAttribute("plan", plan);
			
		} catch(Exception e) {
			logger.info("readDetail");
			e.printStackTrace();
		}
	}

}
