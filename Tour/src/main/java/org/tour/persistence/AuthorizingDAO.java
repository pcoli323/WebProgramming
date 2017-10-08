package org.tour.persistence;

import org.tour.domain.AuthorizingVO;

public interface AuthorizingDAO {

	public int exist(String email);

	public void add(AuthorizingVO authorizingVO);

	public void update(AuthorizingVO authorizingVO);

	public int check(AuthorizingVO authorizingVO);

	public void delete(String email);
}
