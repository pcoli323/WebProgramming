package org.tour.controller;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Locale;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CourseMakeController {

	@RequestMapping(value = "/course/make/add2", method = RequestMethod.GET)
	public void add2(Locale locale, Model model) {
		
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

			//System.out.println(jsonObject);
			
			
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
			}
			
			//model.addAttribute("jsonDataList", memberArray);
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
