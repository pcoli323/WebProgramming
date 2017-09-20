package org.tour.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.tour.domain.CourseInfoVO;
import org.tour.domain.CourseVO;
import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;
import org.tour.service.CourseInfoService;
import org.tour.service.CourseService;
import org.tour.service.DateService;
import org.tour.service.GotoService;
import org.tour.service.ImageService;
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
	@Inject
	private GotoService gotoService;
	@Inject
	private DateService dateService;
	@Inject
	private ImageService imageService;
	
	@RequestMapping(value = "/simple", method = RequestMethod.GET)
	public void readSimple(HttpServletRequest request, @RequestParam("courseNumber") int courseNumber, Model model) throws Exception {
		
		try {
			/* ������ login ���� */
			LoginDTO loginDto = new LoginDTO();
			loginDto.setEmail("user01@bbb.com");
			loginDto.setPwd("user01");
			UserVO loginUser = userService.login(loginDto);
			HttpSession	session = request.getSession();
			session.setAttribute("login", loginUser);
			
			CourseVO courseVO = courseService.read(courseNumber);
			UserVO userVO = userService.read(courseVO.getUserNumber());
			List<CourseInfoVO> representatives = courseInfoService.representatives(courseNumber);
			List<String> representativeNames = gotoService.readRepresentativeNames(representatives);
			
			model.addAttribute("courseNumber", courseNumber);
			model.addAttribute("courseVO", courseVO);
			model.addAttribute("userVO", userVO);
			model.addAttribute("representatives", representatives);
			model.addAttribute("representativeNames", representativeNames);
			
		} catch(Exception e) {
			logger.info("readSimple");
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/getByteImage", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getByteImage(@RequestParam("title") String title) throws Exception{
		Object image = imageService.getImage(title);
		byte[] imageContent = (byte[]) image;
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_PNG);
		return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
	}
	@RequestMapping(value = "/getRealImage", method = RequestMethod.GET)
	public ResponseEntity<String> getRealImage(@RequestParam("gotoNumber") int gotoNumber) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			String realImage = courseInfoService.getRealImage(gotoNumber);
			entity = new ResponseEntity<String>(realImage, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public void readDetail(@RequestParam("courseNumber") int courseNumber, Model model) throws Exception {
		
		try {
			CourseVO courseVO = courseService.read(courseNumber);
			UserVO userVO = userService.read(courseVO.getUserNumber());
			Map<String, List<String>> plan = dateService.gotoListAccordingToDate(courseNumber);
			
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