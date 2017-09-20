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
		// ����Ű //
		// ZMWqGPxD2Y1ds3Sr4PJcz62ZsAzs3Wwu2%2FIWwyGFvbQXC0wCQQHcyaYY%2B6H8LDIVst1GREAN9DNoE2mUHU2%2Ffg%3D%3D
		// 3H9Tndrczl9HltLWVxpLZUzyt0qDtJrURqSVeTESEU6zynlniIm5SUbflTYaV9bbs6ZEW31Dk3t2s9WSGmOjgQ%3D%3D
		// PsYIjFoWi0Uurp5lB%2BBF18%2BVI1IT391RgIRMaAyYriZeIgTyKC9hHF7BmUpFDPNc7l6GH3tnhL4qH4Q5pR6%2BZA%3D%3D		
		String parameter = "";
		String type = "&_type=json";		
		parameter = parameter + "&" + "MobileOS=ETC";
		parameter = parameter + "&" + "MobileApp=Tour";
		parameter = parameter + "&" + "numOfRows=" + maxArea;
		
		// 1. ������ �� �ڵ� ��ȸ
		String addr = startURL + serviceKey + parameter + type;
		URL url = new URL(addr);
		System.out.println("���� ��ȸ API ȣ�� URL : " + url);
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject jsonObject = (JSONObject)JSONValue.parse(isr);		
		JSONObject dataObject = (JSONObject) jsonObject.get("response");
		JSONObject dataObject2 = (JSONObject) dataObject.get("body");
		JSONObject dataObject3 = (JSONObject) dataObject2.get("items");
		JSONArray memberArray = (JSONArray) dataObject3.get("item");
			
		for(int i=0; i<memberArray.size(); i++){
			JSONObject data = (JSONObject)memberArray.get(i);
				
			// DB�� ������ �� �ڵ� ������Ʈ
			// ����� �߰��� ����, ���Ŀ� DB�� ����Ǿ� �ִ��� �˻��� �� ���� �͸� �߰��ϴ� �ڵ� �߰�
			AreaVO avo = new AreaVO();
			avo.setAreaCode(((Long)data.get("code")).intValue());
			avo.setAreaName((String)data.get("name"));
			areaService.add(avo);
				
			// 2. �ñ����� �� �ڵ� ��ȸ
			String addr2 = startURL + serviceKey+ "&areaCode=" + data.get("code").toString() + parameter + type;
			URL url2 = new URL(addr2);
			System.out.println("�ñ��� ��ȸ API ȣ�� URL : " + url2);
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
						
					// DB�� �ñ����� �� �ڵ�, �����ڵ� ����
					// ����� �߰��� ����, ���Ŀ� DB�� ����Ǿ� �ִ��� �˻��� �� ���� �͸� �߰��ϴ� �ڵ� �߰�
					SigunguVO svo = new SigunguVO();
					svo.setAreaCode(((Long)data.get("code")).intValue());
					svo.setSigunguCode(((Long)sdata.get("code")).intValue());
					svo.setSigunguName((String)sdata.get("name"));
					sigunguService.add(svo);
				}
			}
		}
		
		model.addAttribute("msg", "������ �Է� �Ϸ�! ���̺��� Ȯ�����ּ���.");
		return "/admin/main";
	}
	
	@RequestMapping(value="/updateServiceArea", method = RequestMethod.GET)
	public String updateServiceArea(Model model) throws Exception {

		// DB�� ������,�ñ����� ���� ���� ���� ������Ʈ
		// ����� �Ŵ���� ����, ���Ŀ� �ڵ� �߰�
		
		model.addAttribute("msg", "������ ���� �Ϸ�! ���̺��� Ȯ�����ּ���.");
		return "/admin/main";
	} 
}
