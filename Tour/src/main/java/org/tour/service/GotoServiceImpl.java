package org.tour.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.tour.domain.CourseInfoVO;
import org.tour.persistence.GotoDAO;

@Service
public class GotoServiceImpl implements GotoService {

	@Inject
	private GotoDAO dao;
	
	@Override
	public List<String> readRepresentativeNames(List<CourseInfoVO> representatives) throws Exception {
		
		List<String> representativeNames = new ArrayList<String>();
		
		for(int i=0; i<representatives.size(); i++) {
			representativeNames.add(dao.readName(representatives.get(i).getGotoCode()));
		}
		
		return representativeNames;
	}

}
