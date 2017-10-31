package org.tour.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CourseMakeInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("idList")!=null) {
			session.removeAttribute("idList");
		}
		if(session.getAttribute("list")!=null) {
			session.removeAttribute("list");
		}
		if(session.getAttribute("listO")!=null) {
			session.removeAttribute("listO");
		}
		if(session.getAttribute("listU")!=null) {
			session.removeAttribute("listU");
		}
		if(session.getAttribute("name")!=null) {
			session.removeAttribute("name");
		}
		if(session.getAttribute("courseInfo")!=null) {
			session.removeAttribute("courseInfo");
		}
		
		return super.preHandle(request, response, handler);
	}
}
