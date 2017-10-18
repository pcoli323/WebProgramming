package org.tour.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.tour.service.AreaService;
import org.tour.service.CourseInfoService;
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
	private CourseInfoService courseInfoService;
	@Inject
	private UserService userService;
	@Inject
	private CourseService courseService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String search() throws Exception{
		
		return "/main/search";
	}
	
	@RequestMapping(value = "/keyword", method = RequestMethod.GET)
	public ResponseEntity<List<Integer>> searchKeyword(@RequestParam("searchType") String searchType, @RequestParam("keyword") String keyword){
		
		ResponseEntity<List<Integer>> entity = null;
		List<Integer> result = new ArrayList<Integer>();
		//System.out.println(searchType);
		//System.out.println(keyword);
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
			
			for(int i=0; i<result.size(); i++) {
				System.out.println(result.get(i));
			}
			
			entity = new ResponseEntity<List<Integer>>(result, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Integer>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	private List<Integer> searchRegion(String keyword){
		List<Integer> result = new ArrayList<Integer>();
		try {
			// 서울, 광역시 6개, 세종 검색
			List<Integer> areaCodes = areaService.search(keyword);
			for(int i=0; i<areaCodes.size(); i++) {
				int areaCode = areaCodes.get(i);
				result.addAll(courseInfoService.searchAccordingToAreaCode(areaCode));
			}
			
			// 시, 군 검색
			List<Map<String, Integer>> areaAndSigunguCodes = sigunguService.search(keyword);
			for(int i=0; i<areaAndSigunguCodes.size(); i++) {
				Map<String, Integer> areaAndSigunguCode = areaAndSigunguCodes.get(i);
				//System.out.println("areaCode : " + areaAndSigunguCode.get("areaCode") + " sigunguCode : " + areaAndSigunguCode.get("sigunguCode"));
				result.addAll(courseInfoService.searchAccordingToAreaAndSigunguCode(areaAndSigunguCode));
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
