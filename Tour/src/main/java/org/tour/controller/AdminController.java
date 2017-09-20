package org.tour.controller;

import java.io.InputStreamReader;
import java.net.URL;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tour.domain.AreaVO;
import org.tour.domain.SigunguVO;
import org.tour.service.AreaService;
import org.tour.service.SigunguService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Inject
	private AreaService areaService;
	@Inject
	private SigunguService sigunguService;
	
	@RequestMapping(value="/updateArea", method = RequestMethod.GET)
	public String updateArea(Model model) throws Exception {
		
		int maxArea = 100;	
		String startURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode";
		String serviceKey = "?ServiceKey=" + "ZMWqGPxD2Y1ds3Sr4PJcz62ZsAzs3Wwu2%2FIWwyGFvbQXC0wCQQHcyaYY%2B6H8LDIVst1GREAN9DNoE2mUHU2%2Ffg%3D%3D";		
		// 서비스키 //
		// ZMWqGPxD2Y1ds3Sr4PJcz62ZsAzs3Wwu2%2FIWwyGFvbQXC0wCQQHcyaYY%2B6H8LDIVst1GREAN9DNoE2mUHU2%2Ffg%3D%3D
		// 3H9Tndrczl9HltLWVxpLZUzyt0qDtJrURqSVeTESEU6zynlniIm5SUbflTYaV9bbs6ZEW31Dk3t2s9WSGmOjgQ%3D%3D
		// PsYIjFoWi0Uurp5lB%2BBF18%2BVI1IT391RgIRMaAyYriZeIgTyKC9hHF7BmUpFDPNc7l6GH3tnhL4qH4Q5pR6%2BZA%3D%3D		
		String parameter = "";
		String type = "&_type=json";		
		parameter = parameter + "&" + "MobileOS=ETC";
		parameter = parameter + "&" + "MobileApp=Tour";
		parameter = parameter + "&" + "numOfRows=" + maxArea;
		
		// 1. 지역명 및 코드 조회
		String addr = startURL + serviceKey + parameter + type;
		URL url = new URL(addr);
		System.out.println("지역 조회 API 호출 URL : " + url);
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject jsonObject = (JSONObject)JSONValue.parse(isr);		
		JSONObject dataObject = (JSONObject) jsonObject.get("response");
		JSONObject dataObject2 = (JSONObject) dataObject.get("body");
		JSONObject dataObject3 = (JSONObject) dataObject2.get("items");
		JSONArray memberArray = (JSONArray) dataObject3.get("item");
			
		for(int i=0; i<memberArray.size(); i++){
			JSONObject data = (JSONObject)memberArray.get(i);
				
			// DB에 지역명 및 코드 업데이트
			// 현재는 추가만 구현, 추후에 DB에 저장되어 있는지 검사한 후 없는 것만 추가하는 코드 추가
			AreaVO avo = new AreaVO();
			avo.setAreaCode(((Long)data.get("code")).intValue());
			avo.setAreaName((String)data.get("name"));
			areaService.add(avo);
				
			// 2. 시군구명 및 코드 조회
			String addr2 = startURL + serviceKey+ "&areaCode=" + data.get("code").toString() + parameter + type;
			URL url2 = new URL(addr2);
			System.out.println("시군구 조회 API 호출 URL : " + url2);
			InputStreamReader isr2 = new InputStreamReader(url2.openConnection().getInputStream(), "UTF-8");
			JSONObject jsonObject2 = (JSONObject)JSONValue.parse(isr2);
				
			JSONObject sdataObject = (JSONObject) jsonObject2.get("response");
			JSONObject sdataObject2 = (JSONObject) sdataObject.get("body");
			JSONObject sdataObject3 = (JSONObject) sdataObject2.get("items");
			JSONArray smemberArray;
				
			if(sdataObject3.get("item") instanceof JSONArray) {
				smemberArray = (JSONArray) sdataObject3.get("item");
				for(int j=0; j<smemberArray.size(); j++){
					JSONObject sdata = (JSONObject)smemberArray.get(j);
						
					// DB에 시군구명 및 코드, 지역코드 저장
					// 현재는 추가만 구현, 추후에 DB에 저장되어 있는지 검사한 후 없는 것만 추가하는 코드 추가
					SigunguVO svo = new SigunguVO();
					svo.setAreaCode(((Long)data.get("code")).intValue());
					svo.setSigunguCode(((Long)sdata.get("code")).intValue());
					svo.setSigunguName((String)sdata.get("name"));
					sigunguService.add(svo);
				}
			}
		}
		
		model.addAttribute("msg", "데이터 입력 완료! 테이블을 확인해주세요.");
		return "/admin/main";
	}
	
	@RequestMapping(value="/updateServiceArea", method = RequestMethod.GET)
	public String updateServiceArea(Model model) throws Exception {

		// DB에 지역별,시군구별 서비스 여부 설정 업데이트
		// 현재는 매뉴얼로 진행, 추후에 코드 추가
		
		model.addAttribute("msg", "데이터 수정 완료! 테이블을 확인해주세요.");
		return "/admin/main";
	} 
}
