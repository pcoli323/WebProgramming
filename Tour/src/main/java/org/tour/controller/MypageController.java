package org.tour.controller;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.tour.domain.CourseInfoSimpleVO;
import org.tour.domain.CourseInfoVO;
import org.tour.domain.CourseVO;
import org.tour.domain.UserVO;
import org.tour.dto.AreaDTO;
import org.tour.dto.CourseInfoDTO;
import org.tour.dto.LoginDTO;
import org.tour.dto.SelectedAreaDTO;
import org.tour.service.AreaService;
import org.tour.service.CourseInfoService;
import org.tour.service.CourseInfoSimpleService;
import org.tour.service.CourseService;
import org.tour.service.PlanService;
import org.tour.service.SigunguService;
import org.tour.service.UserService;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

@Controller
public class MypageController {
	
	
	@Inject
	private CourseService courseService;
	@Inject
	private UserService userService;
	@Inject
	private CourseInfoService courseInfoService;
	@Inject
	private PlanService planService;
	@Inject
	private CourseInfoSimpleService courseInfoSimpleService;
	
	
	@RequestMapping(value="/mypageNum", method = RequestMethod.POST)
	public ResponseEntity<Integer> mypageNum(HttpServletRequest request, Model model){
		
		ResponseEntity<Integer> entity = null;
		try {
			
			HttpSession	session = request.getSession();
			
			UserVO loginUser = new UserVO();
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
			
			int maxCourseNum = courseService.courseNumberRead(loginUser.getUserNumber());
			
			entity = new ResponseEntity<Integer>(maxCourseNum, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/mypage/{courseNumber}", method = RequestMethod.GET)
	public String numMypage(HttpServletRequest request, @PathVariable("courseNumber") int courseNumber, Model model) {
		try {
			
			HttpSession	session = request.getSession();
			
			UserVO loginUser = new UserVO();
			if(session.getAttribute("login") == null) {
				model.addAttribute("loginCheck", false);
				loginUser.setUserNumber(-1);
				loginUser.setEmail(null);
				loginUser.setPwd(null);
				loginUser.setUserName(null);
			}
			else {
//				System.out.println("login완료");
				model.addAttribute("loginCheck", true);
				loginUser = (UserVO) session.getAttribute("login");
			}
			
			CourseVO courseVO = courseService.read(courseNumber);
			UserVO userVO = userService.read(courseVO.getUserNumber());
			Map<String, List<CourseInfoDTO>> plan = planService.gotoListAccordingToDate(courseNumber);
			List<String> courseName = courseService.courseNameRead(courseVO.getUserNumber());			
			
			ArrayList<Integer> courseNumByName = new ArrayList<Integer>();
			System.out.println(courseName.size());
			for(int i=0; i<courseName.size(); i++) {
				int test = courseService.courseNumByName(courseName.get(i));
				courseName.set(i, "'" + courseName.get(i) + "'");
				courseNumByName.add(i, test);
			}
			System.out.println(plan);

			session.setAttribute("courseNumByName", courseNumByName);
			model.addAttribute("courseName", courseName);
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("courseNumber", courseNumber);
			model.addAttribute("courseVO", courseVO);
			session.setAttribute("userVO", userVO);
			model.addAttribute("plan", plan);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "mypage/noUploadCourse";
	}
	
	@RequestMapping(value = "/mypage/delete/{courseNumber}", method = RequestMethod.POST)
	public ResponseEntity<Integer> remove(HttpServletRequest request, @PathVariable("courseNumber") int courseNumber){
		
		ResponseEntity<Integer> entity = null;
		try {

			//courseinfoSimple mapper에서 삭제
			courseInfoSimpleService.delete(courseNumber);
			//courseinfo mapper에서 삭제
			courseInfoService.delete(courseNumber);
			//course mapper에서 삭제
			courseService.delete(courseNumber);
			
			HttpSession session = request.getSession();
			ArrayList<Integer> courseNumByName = (ArrayList<Integer>) session.getAttribute("courseNumByName");
			for(int i=0; i<courseNumByName.size(); i++) {
				if(courseNumByName.get(i) == courseNumber)
					courseNumByName.remove(i);
			}
			
			UserVO userVO = (UserVO) session.getAttribute("userVO");
			int maxCourseNum = courseService.courseNumberRead(userVO.getUserNumber());
			
			entity = new ResponseEntity<Integer>(maxCourseNum, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/mypage/modify/{courseNumber}", method = RequestMethod.POST)
	public ResponseEntity<Integer> modify(HttpServletRequest request, @PathVariable("courseNumber") int courseNumber){
		
		ResponseEntity<Integer> entity = null;
		try {
			//jsonArray에 집어넣고 add1으로 가면 됨... ㅋ키키키키ㅣㅣㅣ 하기 싫당~
			
			entity = new ResponseEntity<Integer>(1, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/uploadMypage", method = RequestMethod.GET)
	public String uploadMypage(HttpServletRequest request, Model model) {
		try {
			HttpSession	session = request.getSession();
			
			UserVO loginUser = new UserVO();
			if(session.getAttribute("login") == null) {
				model.addAttribute("loginCheck", false);
				loginUser.setUserNumber(-1);
				loginUser.setEmail(null);
				loginUser.setPwd(null);
				loginUser.setUserName(null);
			}
			else {
	//			System.out.println("login완료");
				model.addAttribute("loginCheck", true);
				loginUser = (UserVO) session.getAttribute("login");
			}
			
			System.out.println(loginUser.getUserNumber());
			
			List<String> courseUploadName = courseService.courseUploadNameRead(loginUser.getUserNumber());			
			
			ArrayList<Integer> courseUploadNumByName = new ArrayList<Integer>();
			System.out.println(courseUploadName.size());
			for(int i=0; i<courseUploadName.size(); i++) {
				System.out.println("오류 찾기~ for문 진입");
				int test = courseService.courseNumByName(courseUploadName.get(i));
				courseUploadName.set(i, "'" + courseUploadName.get(i) + "'");
				courseUploadNumByName.add(i, test);
			}

			session.setAttribute("courseNumByName", courseUploadNumByName);
			model.addAttribute("courseName", courseUploadName);
			model.addAttribute("loginUser", loginUser);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "mypage/mypage";
	}
	
	@RequestMapping(value = "/uploadMypage/{courseNumber}", method = RequestMethod.GET)
	public String uploadNumMypage(HttpServletRequest request, @PathVariable("courseNumber") int courseNumber, Model model) {
		try {
			
			HttpSession	session = request.getSession();
			
			UserVO loginUser = new UserVO();
			if(session.getAttribute("login") == null) {
				model.addAttribute("loginCheck", false);
				loginUser.setUserNumber(-1);
				loginUser.setEmail(null);
				loginUser.setPwd(null);
				loginUser.setUserName(null);
			}
			else {
//				System.out.println("login완료");
				model.addAttribute("loginCheck", true);
				loginUser = (UserVO) session.getAttribute("login");
			}
			
			CourseVO courseVO = courseService.read(courseNumber);
			UserVO userVO = userService.read(courseVO.getUserNumber());
			Map<String, List<CourseInfoDTO>> plan = planService.gotoListAccordingToDate(courseNumber);			
			List<String> courseUploadName = courseService.courseUploadNameRead(courseVO.getUserNumber());			
			
			ArrayList<Integer> courseUploadNumByName = new ArrayList<Integer>();
			System.out.println(courseUploadName.size());
			for(int i=0; i<courseUploadName.size(); i++) {
				int test = courseService.courseNumByName(courseUploadName.get(i));
				courseUploadName.set(i, "'" + courseUploadName.get(i) + "'");
				courseUploadNumByName.add(i, test);
			}
			System.out.println(plan);

			session.setAttribute("courseNumByName", courseUploadNumByName);
			model.addAttribute("courseName", courseUploadName);
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("courseNumber", courseNumber);
			model.addAttribute("courseVO", courseVO);
			model.addAttribute("userVO", userVO);
			model.addAttribute("plan", plan);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "mypage/uploadNumMypage";
	}
}