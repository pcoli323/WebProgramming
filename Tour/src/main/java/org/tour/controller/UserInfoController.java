package org.tour.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tour.domain.UserVO;
import org.tour.service.CourseInfoService;
import org.tour.service.CourseInfoSimpleService;
import org.tour.service.CourseService;
import org.tour.service.FollowService;
import org.tour.service.ImageService;
import org.tour.service.LikeService;
import org.tour.service.ReplyService;
import org.tour.service.UserService;

@Controller
public class UserInfoController {
	
	@Inject
	private UserService userService;
	@Inject
	private LikeService likeService;
	@Inject
	private ReplyService replyService;
	@Inject
	private FollowService followService;
	@Inject
	private ImageService imageService;
	@Inject
	private CourseInfoSimpleService courseInfoSimpleService;
	@Inject
	private CourseInfoService courseInfoService;
	@Inject
	private CourseService courseService;
	
	@RequestMapping(value = "/mypage/userInfo", method = RequestMethod.GET)
	public String userInfo(HttpServletRequest request, Locale locale, Model model) throws Exception {
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
				model.addAttribute("user", loginUser);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "mypage/userInfo";
	}
	
	@RequestMapping(value = "/mypage/checkPassword/{password}", method = RequestMethod.POST)
	public ResponseEntity<Integer> checkPassword(HttpServletRequest request, @PathVariable("password") String password, Model model) throws Exception {

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
				model.addAttribute("user", loginUser);
			}
			UserVO user = (UserVO)session.getAttribute("login");
			if(user.getPwd().equals(password) == false) {
				throw new Exception();
			}

			entity = new ResponseEntity<Integer>(1, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/mypage/modify", method = RequestMethod.POST)
	public ResponseEntity<Integer> userInfoModify(HttpServletRequest request, @RequestBody String data) throws Exception {

		ResponseEntity<Integer> entity = null;
		
		try {
			HttpSession	session = request.getSession();
			
			String[] splitData = data.split("/");
			System.out.println("data : " + data);
			String email = splitData[0];
			String pwd = splitData[1];
			String name = splitData[2];
			
			HashMap<String, Object> updateUser = new HashMap<String, Object>();
			updateUser.put("email", email);
			updateUser.put("pwd", pwd);
			updateUser.put("name", name);
			System.out.println("updateUser : " + updateUser);
			
			userService.updateUser(updateUser);

			UserVO loginUser = (UserVO) session.getAttribute("login");
			UserVO modifyUser = userService.read(loginUser.getUserNumber());
			session.setAttribute("login", modifyUser);
			
			entity = new ResponseEntity<Integer>(1, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	

	
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public ResponseEntity<Integer> userDelete(HttpServletRequest request) throws Exception {

		ResponseEntity<Integer> entity = null;
		
		try {
			HttpSession	session = request.getSession();

			UserVO loginUser = (UserVO) session.getAttribute("login");
			int userNumber = loginUser.getUserNumber();
			// tbl_like delete
			likeService.deleteAll(userNumber);
			// tbl_reply delete
			replyService.deleteAll(userNumber);
			// tbl_image delete
			imageService.deleteAll(userNumber);
			// tbl_follow delete
			followService.deleteAll(userNumber);
			
			// delete courseNumber read
			List<Integer> courseNumbers = new ArrayList<Integer>();
			courseNumbers = courseService.deleteCourseRead(userNumber);
			System.out.println("courseNumbers : " + courseNumbers.size());
			if(courseNumbers.size() != 0) {
				for(int i=0; i<courseNumbers.size(); i++) {
					// tbl_courseinfoSimple delete
					courseInfoSimpleService.delete(courseNumbers.get(i));
					// tbl_courseinfo delete
					courseInfoService.delete(courseNumbers.get(i));
				}
				// tbl_course delete
				courseService.deleteAll(userNumber);
			}
			// tbl_user delete
			userService.deleteAll(userNumber);
			
			session.removeAttribute("login");
			
			entity = new ResponseEntity<Integer>(1, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}
