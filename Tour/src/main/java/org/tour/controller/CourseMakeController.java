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
import org.tour.domain.CourseInfoSimpleVO;
import org.tour.domain.CourseInfoVO;
import org.tour.domain.CourseVO;
import org.tour.domain.UserVO;
import org.tour.dto.AreaDTO;
import org.tour.dto.SelectedAreaDTO;
import org.tour.service.AreaService;
import org.tour.service.CourseInfoService;
import org.tour.service.CourseInfoSimpleService;
import org.tour.service.CourseService;
import org.tour.service.SigunguService;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

@Controller
public class CourseMakeController {

	@Inject
	private AreaService areaService;
	@Inject
	private SigunguService sigunguService;
	@Inject
	private CourseService courseService;
	@Inject
	private CourseInfoService courseInfoService;
	@Inject
	private CourseInfoSimpleService courseInfoSimpleService;
	
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
		session.setAttribute("idList", jsonarray);
		//System.out.println(jsonarray);
	}
	
	@RequestMapping(value = "/course/make/add2", method = RequestMethod.GET)
	public void add2(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		session.setAttribute("serviceKey", "ZMWqGPxD2Y1ds3Sr4PJcz62ZsAzs3Wwu2%2FIWwyGFvbQXC0wCQQHcyaYY%2B6H8LDIVst1GREAN9DNoE2mUHU2%2Ffg%3D%3D");
	}
	
	@RequestMapping(value = "/course/make/add2/save", method = RequestMethod.POST)
	public void add2Save(HttpServletRequest request, @RequestBody String data) throws ParseException {
		
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( data );
		JSONArray jsonarray = (JSONArray)obj;
		
		HttpSession session = request.getSession();
		session.setAttribute("list", jsonarray);
		//System.out.println(jsonarray);
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
		
		String data = "[{\"areaCode\":\"1\",\"areaName\":\"서울\",\"endDate\":\"09\\/23\\/2017\",\"sigunguName\":\"전체\",\"sigunguCode\":\"0\",\"startDate\":\"09\\/21\\/2017\"}]";
		JsonParser jsonParser = new JsonParser();
		JsonArray jsonArray = (JsonArray) jsonParser.parse(data);
		//System.out.println(jsonArray);
		session.setAttribute("idList", jsonArray);
		
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
	
	@RequestMapping(value = "/course/make/modify/save", method = RequestMethod.POST)
	public ResponseEntity<Integer> modifySave(HttpServletRequest request, @RequestBody String jspData) throws ParseException {

		ResponseEntity<Integer> entity = null;
		
		try {
			HttpSession session = request.getSession();
			
			JSONParser parser = new JSONParser();
			Object obj = parser.parse( jspData );
			JSONArray jsonarray = (JSONArray)obj;
			
			session.setAttribute("idList", jsonarray);
			System.out.println(jsonarray);
	
			entity = new ResponseEntity<Integer>(1, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
		
		// <Session> idList, list, name(?)
		// idList : areaCode, sigunguCode, areaName, sigunguName, startDate, endDate
		/*
		list			내용			DB(tbl_CourseInfo)
		------------------------------------------------
		addr1			주소			gotoAddr1
		addr2			상세주소		gotoAddr2	
		areacode		지역코드		gotoAreaCode
		contentid		콘텐츠		gotoContentId
		contenttypeid	관광타입		gotoContentTypeId
		createtime		등록일		gotoCreateTime
		firstimage		원본			gotoImageReal
		firstimage2		썸네일		gotoImageThum
		mapx			GPS X		gotoLocationX
		mapy			GPS Y		gotoLocationY
		modifiedtime	수정일		gotoModifiedTime
		readcount		조회수		gotoReadCount
		sigungucode		시군구코드		gotoSigunguCode
		tel				전화번호		gotoTel
		title			제목			gotoTitle
		
		date(?)			여행날짜		gotoDate
		order(?)		날짜별순서		gotoOrder
		*/
		// name : courseName
		
		
		// 1. tbl_Course에 코스 추가
		/*
		try {
			courseService.courseAdd(new CourseVO().setCourseName((String)session.getAttribute("name")).setUserNumber(((UserVO)session.getAttribute("login")).getUserNumber()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		int courseNumber = -1;
		try {
			courseNumber = courseService.courseNumberRead(((UserVO)session.getAttribute("login")).getUserNumber());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 2. tbl_CourseInfo에 코스정보 추가
		JSONArray data = (JSONArray) session.getAttribute("list");
		for(int i=0; i<data.size(); i++) {
			JSONObject json = (JSONObject) data.get(i);
			try {
				courseInfoService.courseInfoAdd(new CourseInfoVO().setCourseNumber(courseNumber)
						.setGotoAddr1((String)json.get("addr1"))
						.setGotoAddr2((String)json.get("addr2"))
						.setGotoAreaCode((int)json.get("areacode"))
						.setGotoContentID((int)json.get("contentid"))
						.setGotoContentTypeID((int)json.get("contenttypeid"))
						.setGotoCreateTime(new SimpleDateFormat("dd/MM/yyyy").parse((String) json.get("createtime")))
						.setGotoImageReal((String)json.get("firstimage"))
						.setGotoImageThum((String)json.get("firstimage2"))
						.setGotoLocationX((String)json.get("mapx"))
						.setGotoLocationY((String)json.get("mapy"))
						.setGotoModifiedTime(new SimpleDateFormat("dd/MM/yyyy").parse((String) json.get("modifiedtime")))
						.setGotoReadCount((int)json.get("readcount"))
						.setGotoSigunguCode((int)json.get("sigungucode"))
						.setGotoTel((String)json.get("tel"))
						.setGotoTitle((String)json.get("title"))
						.setGotoDate(new SimpleDateFormat("dd/MM/yyyy").parse((String) json.get("date")))	// ?
						.setGotoOrder((int)json.get("order"))	// ?
						);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 3. tbl_CourseInfoSimple에 코스정보2 추가
		data = (JSONArray) session.getAttribute("idList");
		for(int i=0; i<data.size(); i++) {
			JSONObject json = (JSONObject) data.get(i);
			try {
				courseInfoSimpleService.courseInfoSimpleAdd(new CourseInfoSimpleVO().setCourseNumber(courseNumber)
						.setAreaCode((int)json.get("areaCode"))
						.setSigunguCode((int)json.get("sigunguCode"))
						.setStartDate(new SimpleDateFormat("dd/MM/yyyy").parse((String) json.get("startDate")))
						.setEndDate(new SimpleDateFormat("dd/MM/yyyy").parse((String) json.get("endDate")))
						);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 4. 세션에서 idList, list, name 삭제
		removeAttributes(request);
		*/
	}
	
	@RequestMapping(value = "/course/make/cancel", method = RequestMethod.GET)
	public void cancel(HttpServletRequest request) throws ParseException {
		
		removeAttributes(request);
		
	}
	
	public void removeAttributes(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("idList")!=null) {
			session.removeAttribute("idList");
		}
		if(session.getAttribute("list")!=null) {
			session.removeAttribute("list");
		}
		if(session.getAttribute("name")!=null) {
			session.removeAttribute("name");
		}
	}	
}

