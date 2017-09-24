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
import org.tour.persistence.CourseInfoDAO;
import org.tour.persistence.GotoDAO;

@Service
public class PlanServiceImpl implements PlanService{

	@Inject
	private CourseInfoDAO courseInfoDao;
	@Inject
	private GotoDAO gotoDao;
	
	@Override
	public Map<String, List<CourseInfoDTO>> gotoListAccordingToDate(int courseNumber) throws Exception {
		Map<String, List<CourseInfoDTO>> plan = new LinkedHashMap<String, List<CourseInfoDTO>>();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		
		List<Date> dates = courseInfoDao.dates(courseNumber);
		
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
				courseInfoDto.setGotoName(gotoDao.readName(gotoList.get(j).getGotoCode()));
				courseInfoDto.setLocationX(gotoList.get(j).getGotoLocationX());
				courseInfoDto.setLocationY(gotoList.get(j).getGotoLocationY());
				String gotoImage = gotoList.get(j).getGotoImageThum();
				if(gotoImage == "" || gotoImage == null) {
					gotoImage = gotoList.get(j).getGotoImageReal();
				}
				courseInfoDto.setGotoImage(gotoImage);
				courseInfoList.add(courseInfoDto);
			}
			String gotoDateForm = dateFormat.format(gotoDate);
			plan.put(gotoDateForm, courseInfoList);
		}
		
		return plan;
	}

}