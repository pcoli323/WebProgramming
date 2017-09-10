package org.tour.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tour.domain.UserVO;
import org.tour.dto.LoginDTO;
import org.tour.service.UserService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private UserService service;
	
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
			//System.out.println(user.getEmail());
			//System.out.println(user.getPwd());
			//System.out.println(user.getUserName());
			service.register(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/main";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(LoginDTO dto, Model model) {
		try {
			System.out.println(dto.getEmail());
			System.out.println(dto.getPwd());
			
			UserVO vo = service.login(dto);
			if(vo==null)
				return "/login/loginFalse";
			model.addAttribute("userVO",vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/main";
	}
}
