package org.tour.controller;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tour.dto.CourseMakeDTO;

@Controller
public class CourseMakeController {

	@RequestMapping(value = "/course/make/add1", method = RequestMethod.GET)
	public void add1(Locale locale, Model model) {
		
	}
	
	@RequestMapping(value = "/course/make/add2", method = RequestMethod.GET)
	public void add2(HttpServletRequest request, Model model) {
		
		String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
		String serviceKey = "?serviceKey=DHcqBxhjFPm%2FJrVtRuH0NExGuA9SrbZWeSAm6Dklg0o69DTFZh1rfrb3OFWZ7qt%2F9k4dxzTbPMax5VQvU0Tocw%3D%3D";
		String parameter = "";
		String type = "&_type=json";
		
		parameter = parameter + "&" + "MobileOS=ETC";
		parameter = parameter + "&" + "MobileApp=Tour";
		parameter = parameter + "&" + "contentTypeId=39"; // 음식
		parameter = parameter + "&" + "areaCode=1"; // 서울
		
		addr = addr + serviceKey + parameter + type;
		
		try {
			URL url = new URL(addr);
			InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
			JSONObject jsonObject = (JSONObject)JSONValue.parse(isr);

			//System.out.println(url);
			
			
			JSONObject dataObject = (JSONObject) jsonObject.get("response");
			JSONObject dataObject2 = (JSONObject) dataObject.get("body");
			JSONObject dataObject3 = (JSONObject) dataObject2.get("items");
			JSONArray memberArray = (JSONArray) dataObject3.get("item");
			
			for(int i=0; i<1; i++){
			//for(int i=0; i<memberArray.size(); i++){
				JSONObject data = (JSONObject)memberArray.get(i);
				//System.out.println(data.get("title"));
				//System.out.println(data.get("firstimage"));
				model.addAttribute("jsonDataList", data.get("firstimage"));
				//System.out.println(data.get("firstimage2"));
				model.addAttribute("jsonDataList2", data.get("firstimage2"));
				/*
				System.out.println(data.get("areaname"));
				System.out.println(data.get("areacode"));
				System.out.println(data.get("addr1"));
				System.out.println(data.get("addr2"));
				System.out.println(data.get("contentid"));
				System.out.println(data.get("contenttypeid"));
				System.out.println(data.get("createdtime"));
				System.out.println(data.get("firstimage"));
				System.out.println(data.get("firstimage2"));
				System.out.println(data.get("mapx"));
				System.out.println(data.get("mapy"));
				System.out.println(data.get("modifiedtime"));
				System.out.println(data.get("readcount"));
				System.out.println(data.get("tel"));
				System.out.println(data.get("title"));
				*/
			}
			
			List<CourseMakeDTO> list = new ArrayList<CourseMakeDTO>();
			for(int i=0; i<10; i++){
				JSONObject data = (JSONObject)memberArray.get(i);
				Calendar cal = new GregorianCalendar();
			    cal.add(Calendar.DATE, i);
				Date date = cal.getTime();
				CourseMakeDTO dto = new CourseMakeDTO("Test",
						(Long)data.get("areacode"),date,date,
						(String)data.get("addr1"),
						(String)data.get("addr2"),
						(Long)data.get("contentid"),
						(Long)data.get("contenttypeid"),
						(Long)data.get("createdtime"),
						(String)data.get("firstimage"),
						(String)data.get("firstimage2"),
						data.get("mapx"),
						data.get("mapy"),
						(Long)data.get("modifiedtime"),
						(Long)data.get("readcount"),
						(String)data.get("tel"),
						(String)data.get("title"));	
				list.add(dto);			
			}
			HttpSession session = request.getSession();
			session.setAttribute("lists", list);
			//model.addAttribute("lists",list);
			
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value = "/course/make/modify", method = RequestMethod.GET)
	public void modify(Locale locale, Model model) {
		
	}
}
