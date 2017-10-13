package org.tour.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.tour.domain.CourseInfoVO;
import org.tour.domain.CourseVO;
import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;
import org.tour.dto.CourseInfoDTO;
import org.tour.service.CourseInfoService;
import org.tour.service.CourseService;
import org.tour.service.PlanService;
//import org.tour.service.GotoService;
import org.tour.service.UserService;

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
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public void readDetail(HttpServletRequest request, @RequestParam("courseNumber") int courseNumber, Model model) throws Exception {
		
		try {
			LoginDTO loginDto = new LoginDTO();
			loginDto.setEmail("user00@aaa.com");
			loginDto.setPwd("user00");
			UserVO loginUserCheck = userService.login(loginDto);
			HttpSession	session = request.getSession();
			session.setAttribute("login", loginUserCheck);
			
			//HttpSession	session = request.getSession();
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
