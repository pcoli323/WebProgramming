package org.tour.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.CourseInfoVO;
import org.tour.dto.CourseInfoDTO;
import org.tour.persistence.ColorDAO;
import org.tour.persistence.CourseInfoDAO;

@Service
public class PlanServiceImpl implements PlanService{

	@Inject
	private CourseInfoDAO courseInfoDao;
	@Inject
	private ColorDAO colorDao;
	
	@Override
	public Map<String, List<CourseInfoDTO>> gotoListAccordingToDate(int courseNumber) throws Exception {
		Map<String, List<CourseInfoDTO>> plan = new LinkedHashMap<String, List<CourseInfoDTO>>();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		
		List<Date> dates = courseInfoDao.dates(courseNumber);
		List<Map<String, Integer>> regionList = courseInfoDao.regionList(courseNumber);
		List<Map<String, Object>> colorList = getColorList(regionList);
		
		for(int i=0; i<dates.size(); i++) {
			Date gotoDate = dates.get(i);
			HashMap<String, Object> courseNumberAndDate = new HashMap<String, Object>();
			courseNumberAndDate.put("courseNumber", courseNumber);
			courseNumberAndDate.put("gotoDate", gotoDate);
			List<CourseInfoVO> gotoList = courseInfoDao.readAccordingToDate(courseNumberAndDate);
			
			List<CourseInfoDTO> courseInfoList = new ArrayList<CourseInfoDTO>();
			for(int j=0; j<gotoList.size(); j++) {
				CourseInfoDTO courseInfoDto = new CourseInfoDTO();
				courseInfoDto.setGotoNumber(gotoList.get(j).getGotoNumber());
				courseInfoDto.setGotoName(gotoList.get(j).getGotoTitle());
				courseInfoDto.setLocationX(gotoList.get(j).getGotoLocationX());
				courseInfoDto.setLocationY(gotoList.get(j).getGotoLocationY());
				courseInfoDto.setGotoOrder(gotoList.get(j).getGotoOrder());
				/*
				String gotoImage = gotoList.get(j).getGotoImageThum();
				if(gotoImage == "" || gotoImage == null) {
					gotoImage = gotoList.get(j).getGotoImageReal();
				}
				*/
				courseInfoDto.setGotoImage(gotoList.get(j).getGotoImageReal());
				courseInfoDto.setIsRepresented(gotoList.get(j).getIsRepresented());
				courseInfoDto.setRepresentedOrder(gotoList.get(j).getRepresentedOrder());
				courseInfoDto.setTel(gotoList.get(j).getGotoTel());
				courseInfoDto.setAddress(gotoList.get(j).getGotoAddr1());
				courseInfoDto.setColor(searchColor(gotoList.get(j).getGotoAreaCode(), gotoList.get(j).getGotoSigunguCode(), colorList));
				courseInfoList.add(courseInfoDto);
			}
			String gotoDateForm = dateFormat.format(gotoDate);
			plan.put(gotoDateForm, courseInfoList);
		}
		
		return plan;
	}
	private List<Map<String, Object>> getColorList(List<Map<String, Integer>> regionList) throws Exception{
		
		List<Map<String, Object>> colorList = new ArrayList<Map<String, Object>>();
		
		try {
			List<Map<String, Integer>> arrangeRegionList = new ArrayList<Map<String, Integer>>();
			List<Integer> areaCodes = new ArrayList<Integer>();
			
			// 지역 하나만 있도록 arrange
			for(int i=0; i<regionList.size(); i++) {
				Map<String, Integer> region = new HashMap<String, Integer>();
				int areaCode = regionList.get(i).get("areaCode");
				region.put("areaCode", areaCode);
				if(areaCode < 9) {
					region.put("sigunguCode", 0);
					if(areaCodes.contains(areaCode) == false) {
						areaCodes.add(areaCode);
						arrangeRegionList.add(region);
					}
				}
				else {
					int sigunguCode = regionList.get(i).get("sigunguCode");
					region.put("sigunguCode", sigunguCode);
					arrangeRegionList.add(region);
				}
			}
			
			// 지역별로 color주기
			for(int i=0; i<arrangeRegionList.size(); i++) {
				Map<String, Integer> region = arrangeRegionList.get(i);
				String color = colorDao.color(i+1);
				Map<String, Object> regionColor = new HashMap<String, Object>();
				regionColor.put("region", region);
				regionColor.put("color", color);
				
				colorList.add(regionColor);
			}
			
		}catch(Exception e) {
			System.out.println("colorMake");
			e.printStackTrace();
		}
		
		return colorList;
	}
	private String searchColor(int areaCode, int sigunguCode, List<Map<String, Object>> colorList) {
		String color = "";
		Map<String, Integer> compareRegion = new HashMap<String, Integer>();
		compareRegion.put("areaCode", areaCode);
		if(areaCode < 9) {
			compareRegion.put("sigunguCode", 0);
		}
		else {
			compareRegion.put("sigunguCode", sigunguCode);
		}
		
		for(int i=0; i<colorList.size(); i++) {
			if(compareRegion.equals(colorList.get(i).get("region"))) {
				color = (String)colorList.get(i).get("color");
			}
		}
		
		return color;
	}
}