package org.tour.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tour.service.MailService;
import org.tour.service.UserService;

@Controller
public class MailSendController {

	//@Inject
	//private UserService userService;
	//private MailService mailService;
	
	//@Autowired
	//private JavaMailSender mailSender;
	
	@Autowired
	private JavaMailSender mailSender; // xml에 등록한 bean autowired
	
	/*
	// 회원가입 이메일 인증
	@RequestMapping(value="/sendMail/auth", method = RequestMethod.POST)
	public String home(Locale locale, Model model) {
		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
        model.addAttribute("joinCode", joinCode);
        String subject = "회원가입 인증 코드 발급 안내 입니다.";
        StringBuilder sb = new StringBuilder();
        sb.append("귀하의 인증 코드는 " + joinCode + " 입니다.");
        return mailService.send(subject, sb.toString(), "아이디@gmail.com", email, null);
	}
	*/
	
	@RequestMapping(value = "/mail", method = RequestMethod.GET)
	  public String mailForm() {
		
			 try{
			  SimpleMailMessage message = new SimpleMailMessage();
			 
			  message.setFrom("tourwebsite0@gmail.com");
			  message.setTo("pcoli323@gmail.com");
			  message.setSubject("Test");
			  message.setText("Test");
			   
			  mailSender.send(message);
			 
			 }catch(Exception e){
			  e.printStackTrace();
			 }   
			 
		
		
	    return "home";
	  }  
	
	/*
	@RequestMapping(value = "/mail/mailSending")
	 public String mailSending(HttpServletRequest request) {
		   
		    String setfrom = "tourwebsite0@gmail.com";
		    String tomail  = "pcoli323@gmail.com";
		    String title   = "Test";
		    String content = "Story";
		   
		    try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
		      messageHelper.setTo(tomail);     // 받는사람 이메일
		      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
		      messageHelper.setText(content);  // 메일 내용
		     
		      mailSender.send(message);
		    } catch(Exception e){
		      System.out.println(e);
		    }
		   
		    return "redirect:/main";
		  }*/
}
