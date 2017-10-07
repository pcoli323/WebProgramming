package org.tour.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.CourseInfoVO;
import org.tour.persistence.CourseInfoDAO;

@Service
public class CourseInfoServiceImpl implements CourseInfoService {

	@Inject
	private CourseInfoDAO dao;
	
	@Override
	public List<CourseInfoVO> representatives(int courseNumber) throws Exception {
		
		return dao.representatives(courseNumber);
	}

	@Override
	public String getRealImage(int gotoNumber) throws Exception {
		
		return dao.getRealImage(gotoNumber);
	}

	@Override
	public List<CourseInfoVO> readAll(int courseNumber) throws Exception {
		
		return dao.readAll(courseNumber);
	}

	@Override
	public void add(CourseInfoVO vo) throws Exception {

		dao.add(vo);
	}

	@Override
	public void courseInfoAdd(CourseInfoVO vo) throws Exception {
		
		dao.courseInfoAdd(vo);		
	}

	@Override
	public void changeImage(int gotoNumber, int imageNumber) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("gotoNumber", gotoNumber);
		String gotoImageReal = "/getRealImage?imageNumber=" + imageNumber;
		String gotoImageThum = "/getThumImage?imageNumber=" + imageNumber;
		data.put("gotoImageReal", gotoImageReal);
		data.put("gotoImageThum", gotoImageThum);
		
		dao.changeImage(data);
	}

	@Override
	public void deleteImage(int gotoNumber) throws Exception {

		dao.deleteImage(gotoNumber);
	}

	@Override
	public void representativeMark(int gotoNumber, int representedOrder) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("gotoNumber", gotoNumber);
		data.put("representedOrder", representedOrder);
		
		dao.representativeMark(data);
	}
	
}
