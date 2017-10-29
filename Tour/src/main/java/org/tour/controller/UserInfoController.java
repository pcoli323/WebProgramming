package org.tour.controller;

import java.util.Locale;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tour.service.UserService;

@Controller
public class UserInfoController {
	
	@Inject
	private UserService userService;
	
	@RequestMapping(value = "/mypage/userInfo", method = RequestMethod.POST)
	public String userInfo(Locale locale, Model model) throws Exception {
		try {
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "mypage/userInfo";
	}
	
}
