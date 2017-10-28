package org.tour.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.tour.domain.UserVO;
import org.tour.service.AreaService;
import org.tour.service.CourseService;
import org.tour.service.SigunguService;
import org.tour.service.UserService;

@Controller
@RequestMapping("/search")
public class MainController {

	@Inject
	private AreaService areaService;
	@Inject
	private SigunguService sigunguService;
	@Inject
	private UserService userService;
	@Inject
	private CourseService courseService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String search(HttpServletRequest request, Model model) throws Exception{
		
		try {
			HttpSession	session = request.getSession();
			UserVO loginUser = new UserVO();;
			if(session.getAttribute("login") == null) {
				model.addAttribute("loginCheck", false);
				loginUser.setUserNumber(-1);
				loginUser.setEmail(null);
				loginUser.setPwd(null);
				loginUser.setUserName(null);
			}
			else {
				model.addAttribute("loginCheck", true);
				loginUser = (UserVO) session.getAttribute("login");
			}
			model.addAttribute("loginUser", loginUser);
			
		}catch(Exception e) {
			System.out.println("SearchMain");
			e.printStackTrace();
		}
		return "/main/search";
	}
	
	@RequestMapping(value = "/keyword", method = RequestMethod.GET)
	public ResponseEntity<List<Integer>> searchKeyword(@RequestParam("searchType") String searchType, @RequestParam("keyword") String keyword){
		
		ResponseEntity<List<Integer>> entity = null;
		List<Integer> result = new ArrayList<Integer>();
		try {
			if(searchType.equals("region") == true) {
				result = searchRegion(keyword);
			}
			else if(searchType.equals("user") == true) {
				result = searchUser(keyword);
			}
			else {
				System.out.println("오류!");
			}
			System.out.println(result.toString());
			
			entity = new ResponseEntity<List<Integer>>(result, HttpStatus.OK);
			
		}catch(Exception e) {
			System.out.println("search");
			e.printStackTrace();
			entity = new ResponseEntity<List<Integer>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	private List<Integer> searchRegion(String keyword){
		List<Integer> result = new ArrayList<Integer>();
		try {
			// 서울, 광역시, 세종
			List<Map<String, Integer>> areaAndSigunguCodes = areaService.search(keyword);
			// 시군구
			if(areaAndSigunguCodes.size() == 0 || areaAndSigunguCodes.get(0).get("areaCode") == 5) {
				areaAndSigunguCodes.addAll(sigunguService.search(keyword));
			}
			for(int i=0; i<areaAndSigunguCodes.size(); i++) {
				System.out.println("area : " + areaAndSigunguCodes.get(i).get("areaCode") + " sigungu : " + areaAndSigunguCodes.get(i).get("sigunguCode"));
			}
			// courseNumber로 읽기
			if(areaAndSigunguCodes.size() != 0) {
				result.addAll(courseService.searchAccordingToAreaAndSigunguCode(areaAndSigunguCodes));
			}
		}catch(Exception e) {
			System.out.println("searchRegionError");
			e.printStackTrace();
		}
		
		return result;
	}
	private List<Integer> searchUser(String keyword){
		List<Integer> result = new ArrayList<Integer>();
		try {
			List<Integer> userNumbers = userService.search(keyword);
			for(int i=0; i<userNumbers.size(); i++) {
				int userNumber = userNumbers.get(i);
				result.addAll(courseService.searchAccordingToUserNumber(userNumber));
			}
		}catch(Exception e) {
			System.out.println("searchUserError");
			e.printStackTrace();
		}
		
		return result;
	}
}
