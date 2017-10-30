package org.tour.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tour.domain.AreaVO;
import org.tour.domain.CourseInfoVO;
import org.tour.domain.LikeVO;
import org.tour.domain.SigunguVO;
import org.tour.domain.UserVO;
import org.tour.dto.CourseIDDTO;
import org.tour.dto.LoginDTO;
import org.tour.service.AreaService;
import org.tour.service.CourseChangeService;
import org.tour.service.LikeService;
import org.tour.service.SigunguService;
import org.tour.service.UserService;

import com.google.gson.Gson;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private UserService service;
	
	@Inject
	private LikeService likeService;
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		return "home";
	}
	
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String register(UserVO user, Model model) {
		try {
			((UserService) service).register(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "home";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(LoginDTO dto, Model model) throws IOException {
		try {
			UserVO vo = service.login(dto);
			if(vo!=null) {
				model.addAttribute("userVO",vo);
				model.addAttribute("loginSuccess","1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "home";
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout() {
		return "home";
	}
	
	@RequestMapping(value = "/call", method = RequestMethod.POST)
	public ResponseEntity<List<Integer>> call(){
		
		ResponseEntity<List<Integer>> entity = null;
		try {

			List<Integer> top3List = likeService.getTop3();
			//System.out.println(top3List);
			entity = new ResponseEntity<List<Integer>>(top3List, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Integer>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
	@Inject
	private CourseChangeService courseChangeService;
	@Inject
	private AreaService areaService;
	@Inject
	private SigunguService sigunguService;
	
	@RequestMapping(value="/test", method = RequestMethod.GET)
	public String test(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		// idList Parsing
		List<CourseIDDTO> courseIdList = courseChangeService.getCourseIDList(23);
		List<AreaVO> areaList = areaService.selectAll();
		List<SigunguVO> sigunguList = sigunguService.selectAll();
		
		for(int i=0; i<courseIdList.size(); i++) {
			for(int j=0; j<areaList.size(); j++) {
				if(areaList.get(j).getAreaCode()==courseIdList.get(i).getAreaCode()) {
					courseIdList.get(i).setAreaName(areaList.get(j).getAreaName());
					break;
				}
			}
			for(int j=0; j<sigunguList.size(); j++) {
				if(sigunguList.get(j).getAreaCode()==courseIdList.get(i).getAreaCode() && sigunguList.get(j).getSigunguCode()==courseIdList.get(i).getSigunguCode()) {
					courseIdList.get(i).setSigunguName(sigunguList.get(j).getSigunguName());
					break;
				}
			}
		}
		Gson gson = new Gson();
		session.setAttribute("idList", gson.toJson(courseIdList));
		
		// list, listU parsing
		List<CourseInfoVO> coursesList = courseChangeService.getCoursesList(23);
		List<CourseInfoVO> list = new LinkedList<CourseInfoVO>();
		List<CourseInfoVO> listU = new LinkedList<CourseInfoVO>();
		
		for(int i=0; i<coursesList.size(); i++) {
			if(coursesList.get(i).getIsNew()) {
				listU.add(coursesList.get(i));
			}
			else {
				list.add(coursesList.get(i));
			}
		}
		session.setAttribute("list", gson.toJson(list));
		session.setAttribute("listU", gson.toJson(listU));
		
		return "test";
	}
}
