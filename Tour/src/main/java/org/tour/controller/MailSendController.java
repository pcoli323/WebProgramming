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
	private JavaMailSender mailSender; // xml�� ����� bean autowired
	
	/*
	// ȸ������ �̸��� ����
	@RequestMapping(value="/sendMail/auth", method = RequestMethod.POST)
	public String home(Locale locale, Model model) {
		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
        model.addAttribute("joinCode", joinCode);
        String subject = "ȸ������ ���� �ڵ� �߱� �ȳ� �Դϴ�.";
        StringBuilder sb = new StringBuilder();
        sb.append("������ ���� �ڵ�� " + joinCode + " �Դϴ�.");
        return mailService.send(subject, sb.toString(), "���̵�@gmail.com", email, null);
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
		 
		      messageHelper.setFrom(setfrom);  // �����»�� �����ϰų� �ϸ� �����۵��� ����
		      messageHelper.setTo(tomail);     // �޴»�� �̸���
		      messageHelper.setSubject(title); // ���������� ������ �����ϴ�
		      messageHelper.setText(content);  // ���� ����
		     
		      mailSender.send(message);
		    } catch(Exception e){
		      System.out.println(e);
		    }
		   
		    return "redirect:/main";
		  }*/
}
