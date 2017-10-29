package org.tour.controller;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tour.domain.UserVO;
import org.tour.service.UserService;

@Controller
public class UserInfoController {
	
	@Inject
	private UserService userService;
	
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
			System.out.println(user.getPwd());
			System.out.println(password);
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
	
}
