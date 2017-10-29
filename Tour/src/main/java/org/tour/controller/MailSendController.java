package org.tour.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.tour.domain.AuthorizingVO;
import org.tour.domain.FollowVO;
import org.tour.domain.UserVO;
import org.tour.service.AreaService;
import org.tour.service.AuthorizingService;
import org.tour.service.MailService;
import org.tour.service.UserService;

@RestController
public class MailSendController {
	
	@Inject
	private MailService mailSender;

	@Inject
	private UserService userService;
	@Inject
	private AuthorizingService authorizingService;
	
	@RequestMapping(value = "/mail", method = RequestMethod.POST)
	public ResponseEntity<String> mail(@RequestBody String email) {
		
		ResponseEntity<String> entity = null;
		
		try{
			//System.out.println(email);
			JSONParser parser = new JSONParser();
			Object obj = parser.parse( email );
			JSONArray jsonArray = (JSONArray)obj;
			JSONObject jsonData = (JSONObject) jsonArray.get(0);
			String em = (String) jsonData.get("email");
			//System.out.println(em);
			
			// ���� �ϴ��� Ȯ��
			// �̸��� ����
			int isExist = userService.exist(em);
			//System.out.println(isExist);
			if(isExist!=0) {
				String str = "0";
				entity = new ResponseEntity<String>(str, HttpStatus.OK);
			}
			// �̸��� �������� ����(����)
			else {
				// ���� ��ȣ ����
				int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
				String joinCode = String.valueOf(ran);
				
				// ������ȣ ��� ����
				// ����
				if(authorizingService.exist(em)!=0) {
					authorizingService.update(new AuthorizingVO(em,joinCode));
				}
				
				// �������� ����
				else {
					authorizingService.add(new AuthorizingVO(em,joinCode));
				}
				
				// �̸��� ������	
				SimpleMailMessage message = new SimpleMailMessage();
				message.setTo(em);
				message.setSubject("Memcox ���� ����");
				message.setText("���� �ڵ� : "+joinCode);		
				mailSender.send(message);
				
				entity = new ResponseEntity<String>("1", HttpStatus.OK);
			}	
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/checkAuthCode", method = RequestMethod.POST)
	public ResponseEntity<String> checkAuthCode(@RequestBody String data) {
		
		ResponseEntity<String> entity = null;
		try {
			JSONParser parser = new JSONParser();
			Object obj = parser.parse( data );
			JSONArray jsonArray = (JSONArray)obj;
			JSONObject jsonData = (JSONObject) jsonArray.get(0);
			String email = (String) jsonData.get("email");
			String authCode = (String) jsonData.get("authCode");
			String pwd = (String) jsonData.get("pwd");
			String name = (String) jsonData.get("name");
			
			//System.out.println(email+":"+authCode);
			
			int check = authorizingService.check(new AuthorizingVO(email,authCode));
			if(check==0) {
				entity = new ResponseEntity<String>("0", HttpStatus.OK);
			}
			else {
				userService.register(new UserVO(email,pwd,name));
				entity = new ResponseEntity<String>("1", HttpStatus.OK);
				authorizingService.delete(email);
			}
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
	@RequestMapping(value = "/mailForPWD", method = RequestMethod.POST)
	public ResponseEntity<String> mailForPWD(@RequestBody String email) {
		
		ResponseEntity<String> entity = null;
		
		try{
			//System.out.println(email);
			JSONParser parser = new JSONParser();
			Object obj = parser.parse( email );
			JSONArray jsonArray = (JSONArray)obj;
			JSONObject jsonData = (JSONObject) jsonArray.get(0);
			String em = (String) jsonData.get("email");
			//System.out.println(em);
			
			// ���� �ϴ��� Ȯ��
			// �̸��� �������� ���� : ����
			int isExist = userService.exist(em);
			//System.out.println(isExist);
			if(isExist!=1) {
				String str = "0";
				entity = new ResponseEntity<String>(str, HttpStatus.OK);
			}
			// �̸��� ���� (����)
			else {
				// �ӽ� ��й�ȣ  ����
				int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
				String joinCode = String.valueOf(ran);
				
				// ��й�ȣ ������Ʈ
				System.out.println(em +":"+joinCode);
				userService.updatePWD(em,joinCode);
				
				// �̸��� ������	
				SimpleMailMessage message = new SimpleMailMessage();
				message.setTo(em);
				message.setSubject("Memcox �ӽ� ��й�ȣ �߼� ����");
				message.setText("�ӽ� ��й�ȣ : "+joinCode+"\n�α��� �� ��й�ȣ�� �������ּ���.");		
				mailSender.send(message);
				
				entity = new ResponseEntity<String>("1", HttpStatus.OK);
			}	
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}
