package org.tour.persistence;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.CourseInfoVO;

@Repository
public class CourseInfoDAOImpl implements CourseInfoDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "org.tour.mapper.CourseInfoMapper";

	@Override
	public List<CourseInfoVO> representatives(int courseNumber) throws Exception {
		
		return session.selectList(namespace + ".representatives", courseNumber);
	}
	
	@Override
	public List<Date> dates(int courseNumber) throws Exception {
		
		return session.selectList(namespace + ".dates", courseNumber);
	}

	@Override
	public List<String> gotoCodes(Date gotoDate) throws Exception {
		
		return session.selectList(namespace + ".gotoCodes", gotoDate);
	}
	
}
