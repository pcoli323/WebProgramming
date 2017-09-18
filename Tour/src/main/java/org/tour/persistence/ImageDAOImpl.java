package org.tour.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.tour.domain.ImageVO;

@Repository
public class ImageDAOImpl implements ImageDAO{

	@Inject
	private SqlSession session;

	private static String namespace = "org.zerock.mapper.ImageMapper";
	
	public void create(ImageVO vo) throws Exception {
		try {
		session.insert(namespace + ".create", vo);
		}catch(Exception e) {
			System.out.println("error in ImageDAO");
		}
	}

	@Override
	public Object get(String title) throws Exception {
		
		return session.selectOne(namespace + ".getImage", title);
	}
}
