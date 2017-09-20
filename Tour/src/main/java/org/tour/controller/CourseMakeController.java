package org.tour.controller;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

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
import org.tour.dto.AreaDTO;
import org.tour.dto.SelectedAreaDTO;
import org.tour.service.AreaService;
import org.tour.service.SigunguService;

import com.google.gson.Gson;

@Controller
public class CourseMakeController {

	@Inject
	private AreaService areaService;
	@Inject
	private SigunguService sigunguService;
	
	@RequestMapping(value = "/course/make/add1", method = RequestMethod.GET)
	public void add1(Locale locale, Model model) throws Exception {
		
		Gson gson = new Gson();
		model.addAttribute("areaList", gson.toJson(areaService.selectAll()));
		model.addAttribute("sigunguList", gson.toJson(sigunguService.selectAll()));

	}
	
	@RequestMapping(value = "/course/make/add1/save", method = RequestMethod.POST)
	public void add1Save(HttpServletRequest request, @RequestBody String data) throws ParseException {
		
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( data );
		JSONArray jsonarray = (JSONArray)obj;
		
		HttpSession session = request.getSession();
		session.setAttribute("idlist", jsonarray);
		
	}
	
	@RequestMapping(value = "/course/make/add2", method = RequestMethod.GET)
	public void add2(HttpServletRequest request, Model model) {

	}
		
	@RequestMapping(value = "/course/make/test", method = RequestMethod.GET)
	public void test(HttpServletRequest request, Locale locale, Model model) throws UnsupportedEncodingException, IOException {
		
		String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
		String serviceKey = "?serviceKey=ZMWqGPxD2Y1ds3Sr4PJcz62ZsAzs3Wwu2%2FIWwyGFvbQXC0wCQQHcyaYY%2B6H8LDIVst1GREAN9DNoE2mUHU2%2Ffg%3D%3D";
		String parameter = "";
		String type = "&_type=json";
		
		parameter += "&MobileOS=ETC";
		parameter += "&MobileApp=Tour";
		parameter += "&arrange=B";
		parameter += "&areaCode=1";
		
		addr += serviceKey + parameter + type;
		
		URL url = new URL(addr);
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject jsonObject = (JSONObject)JSONValue.parse(isr);
		JSONObject dataObject = (JSONObject) jsonObject.get("response");
		JSONObject dataObject2 = (JSONObject) dataObject.get("body");
		JSONObject dataObject3 = (JSONObject) dataObject2.get("items");
		JSONArray memberArray = (JSONArray) dataObject3.get("item");
		
		HttpSession session = request.getSession();
		session.setAttribute("list", memberArray);
		
	}
	
	@RequestMapping(value = "/course/make/modify", method = RequestMethod.GET)
	public String modify(Locale locale, Model model) {
		return "course/make/modify";
	}
	@RequestMapping(value = "/course/make/modify/remove/{Status}", method = RequestMethod.POST)
	public ResponseEntity<Integer> remove(HttpServletRequest request, @PathVariable("Status") int Status){
		
		ResponseEntity<Integer> entity = null;
		try {
			HttpSession session = request.getSession();
			JSONArray list = (JSONArray)session.getAttribute("list");
			
			list.remove(Status);
			
			entity = new ResponseEntity<Integer>(1, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}

