package org.tour.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.CourseInfoDAO;
import org.tour.persistence.GotoDAO;

@Service
public class DateServiceImpl implements DateService {

	@Inject
	private CourseInfoDAO courseInfoDao;
	@Inject
	private GotoDAO gotoDao;
	
	@Override
	public Map<String, List<String>> gotoListAccordingToDate(int courseNumber) throws Exception {
		
		Map<String, List<String>> plan = new LinkedHashMap<String, List<String>>();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		
		List<Date> dates = courseInfoDao.dates(courseNumber);
		
		for(int i=0; i<dates.size(); i++) {
			Date gotoDate = dates.get(i);
			List<String> gotoCodes = courseInfoDao.gotoCodes(gotoDate);
			
			List<String> gotoNames = new ArrayList<String>();
			for(int j=0; j<gotoCodes.size(); j++) {
				gotoNames.add(gotoDao.readName(gotoCodes.get(j)));
			}
			
			String gotoDateForm = dateFormat.format(gotoDate);
			plan.put(gotoDateForm, gotoNames);
		}
		
		return plan;
	}

	
}
