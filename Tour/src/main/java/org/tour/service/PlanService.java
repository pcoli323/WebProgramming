package org.tour.service;

import java.util.List;
import java.util.Map;

import org.tour.dto.CourseInfoDTO;

public interface PlanService {

	public Map<String,List<CourseInfoDTO>> gotoListAccordingToDate(int courseNumber) throws Exception;
}