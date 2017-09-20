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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String add1(Locale locale, Model model) throws Exception {
		
		/*
		// DB에서 지역, 시군구 데이터를 가져오는 부분
		model.addAttribute("areaList", areaService.selectAll());
		model.addAttribute("sigunguList", sigunguService.selectAll());
		
		return "/course/make/add1";
		*/
		Gson gson = new Gson();
		model.addAttribute("areaList", gson.toJson(areaService.selectAll()));
		model.addAttribute("sigunguList", gson.toJson(sigunguService.selectAll()));
		
		return "/course/make/newAdd1";
	}
	
	@RequestMapping(value = "/course/make/add2", method = RequestMethod.GET)
	public String add2(HttpServletRequest request, Model model) throws UnsupportedEncodingException, IOException {
		
		/*
		String idList = request.getParameter("idList");
		String[] idListValue = idList.split(",");
		for(int i=0; i<idListValue.length; i++) {
			System.out.println(idListValue[i]);
		}
		*/
		
		/*
		// /course/make/add1 과 연결되는 부분
		String arrCode = request.getParameter("arrCode");
		String arrName = request.getParameter("arrName");
		String arrName2 = request.getParameter("arrName2");
		String arrSDate = request.getParameter("arrSDate");
		String arrEDate = request.getParameter("arrEDate");
		
		String[] arrCodeValues = arrCode.split(",");
		String[] arrNameValues = arrName.split(",");
		String[] arrNameValues2 = arrName2.split(",");
		String[] arrSDateValues = arrSDate.split(",");
		String[] arrEDateValues = arrEDate.split(",");
		
		List<SelectedAreaDTO> selectedAreaDTO = new ArrayList<SelectedAreaDTO>();
		for(int i=0; i<arrCodeValues.length; i++) {
			SelectedAreaDTO tmp = new SelectedAreaDTO();
			String[] area = arrCodeValues[i].split("-");
			tmp.setAreacode(area[0]);
			tmp.setSigungucode(area[1]);
			tmp.setAreaname(arrNameValues[i]);
			tmp.setSigunguname(arrNameValues2[i]);
			tmp.setStartdate(arrSDateValues[i]);
			tmp.setEnddate(arrEDateValues[i]);
			
			selectedAreaDTO.add(tmp);
		}
		model.addAttribute("selectedAreaList", selectedAreaDTO);
		*/
		/*
		// /course/make/add2 테스트용 코드
		List<SelectedAreaDTO> selectedAreaDTO = new ArrayList<SelectedAreaDTO>();
		SelectedAreaDTO tmp = new SelectedAreaDTO();
		tmp.setAreacode("1");
		tmp.setAreaname("서울");
		tmp.addSigungu("강남구", "1");
		tmp.addSigungu("강동구", "2");
		tmp.setStartdate("2017/09/20");
		tmp.setEnddate("2017/09/21");
		selectedAreaDTO.add(tmp);
		SelectedAreaDTO tmp2 = new SelectedAreaDTO();
		tmp2.setAreacode("2");
		tmp2.setAreaname("인천");
		tmp.addSigungu("강화군", "1");
		tmp2.setStartdate("2017/09/21");
		tmp2.setEnddate("2017/09/22");
		selectedAreaDTO.add(tmp2);
		model.addAttribute("selectedAreaList", selectedAreaDTO);
		*/
		
		
		/*
		for(int i=0; i<arrCodeValues.length; i++) {
			System.out.println(arrCodeValues[i]);
			System.out.println(arrNameValues[i]);
			System.out.println(arrNameValues2[i]);
			System.out.println(arrSDateValues[i]);
			System.out.println(arrEDateValues[i]);
			System.out.println();
		}
		*/
		
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
		
		return "/course/make/test";
		
		/*
		String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
		String serviceKey = "?serviceKey=ZMWqGPxD2Y1ds3Sr4PJcz62ZsAzs3Wwu2%2FIWwyGFvbQXC0wCQQHcyaYY%2B6H8LDIVst1GREAN9DNoE2mUHU2%2Ffg%3D%3D";
		// ZMWqGPxD2Y1ds3Sr4PJcz62ZsAzs3Wwu2%2FIWwyGFvbQXC0wCQQHcyaYY%2B6H8LDIVst1GREAN9DNoE2mUHU2%2Ffg%3D%3D
		// 3H9Tndrczl9HltLWVxpLZUzyt0qDtJrURqSVeTESEU6zynlniIm5SUbflTYaV9bbs6ZEW31Dk3t2s9WSGmOjgQ%3D%3D
		// PsYIjFoWi0Uurp5lB%2BBF18%2BVI1IT391RgIRMaAyYriZeIgTyKC9hHF7BmUpFDPNc7l6GH3tnhL4qH4Q5pR6%2BZA%3D%3D
		
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
				
			}
			
			List<CourseMakeDTO> list = new ArrayList<CourseMakeDTO>();
			for(int i=0; i<10; i++){
				JSONObject data = (JSONObject)memberArray.get(i);
				Calendar cal = new GregorianCalendar();
			    cal.add(Calendar.DATE, i);
				Date date = cal.getTime();
				CourseMakeDTO dto = new CourseMakeDTO("Test","Test",
						(Long)data.get("areacode"),(Long)data.get("sigungucode"),date,date,
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
			
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
	}
	
	/*
	@RequestMapping(value = "/course/make/test2", method = RequestMethod.GET)
	public void test2(HttpServletRequest request, Locale locale, Model model) {
		HttpSession session = request.getSession();
		JSONArray jsonArr = (JSONArray) session.getAttribute("list");
		for(int i=0; i<jsonArr.size(); i++) {
			JSONObject data = (JSONObject)jsonArr.get(i);
			System.out.println(data.get("title"));
		}
	}
	*/
	
	@RequestMapping(value = "/course/make/modify", method = RequestMethod.GET)
	public void modify(Locale locale, Model model) {
	}
}
