package org.tour.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.persistence.CourseInfoDAO;

@Service
public class CourseInfoServiceImpl implements CourseInfoService {

	@Inject
	private CourseInfoDAO dao;
	
}
