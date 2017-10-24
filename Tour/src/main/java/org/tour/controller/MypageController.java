package org.tour.controller;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
	
	
	//mypage view 넘어갈때 최대 값 주기
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
	
	// 업로드 되지 않은 view 처리
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
			
			//이름으로 불러오는 것들을 courseNumber로 불러오는 것으로 변경
			List<Integer> noUploadCourseNumber = courseService.noUploadCourseNumber(courseVO.getUserNumber());
			
			ArrayList<String> courseNameByNum = new ArrayList<String>();
			for(int i=0; i<noUploadCourseNumber.size(); i++) {
				String test = courseService.courseReadName(noUploadCourseNumber.get(i));
				test = "'" + test + "'";
				courseNameByNum.add(i, test);
			}
			System.out.println(plan);

			session.setAttribute("courseNumByName", noUploadCourseNumber);
			model.addAttribute("courseName", courseNameByNum);
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
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(HttpServletRequest request, Model model) {
		
		return "mypage/noneView";
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
	
	// 업로드 된 뷰 관리
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
			
			List<Integer> uploadCourseNumber = courseService.uploadCourseNumber(loginUser.getUserNumber());
			List<CourseVO> simpleViewAll = courseService.simpleViewAll(loginUser.getUserNumber());
			UserVO userVO = userService.read(loginUser.getUserNumber());
			
			Map<String, List<CourseInfoVO>> representatives = new HashMap<String, List<CourseInfoVO>>();
			
			ArrayList<String> courseNameByNum = new ArrayList<String>();
			for(int i=0; i<uploadCourseNumber.size(); i++) {
				String test = courseService.courseReadName(uploadCourseNumber.get(i));
				test = "'" + test + "'";
				courseNameByNum.add(i, test);
			}
			
			for(int i=0; i<uploadCourseNumber.size(); i++) {
				representatives.put(courseNameByNum.get(i), courseInfoService.representatives(uploadCourseNumber.get(i)));
			}

			model.addAttribute("courseName", courseNameByNum);
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("courseNumber", uploadCourseNumber);
			model.addAttribute("courseVO", simpleViewAll);
			model.addAttribute("userVO", userVO);
			model.addAttribute("representatives", representatives);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "mypage/uploadCourse";
	}

	
	@RequestMapping(value = "/uploadMypage/delete/{courseNumber}", method = RequestMethod.POST)
	public ResponseEntity<Integer> uploadDelete(HttpServletRequest request, @PathVariable("courseNumber") int courseNumber){
		
		ResponseEntity<Integer> entity = null;
		try {
			CourseVO courseVO = new CourseVO();
			courseVO.setStory(null);
			courseVO.setPosted(false);
			
			CourseInfoVO courseInfoVO = new CourseInfoVO();
			courseInfoVO.setIsRepresented(false);
			courseInfoVO.setRepresentedOrder(0);
			
			courseService.deletePost(courseVO);
			
			
			
			entity = new ResponseEntity<Integer>(1, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}