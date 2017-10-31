package org.tour.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.tour.domain.UserVO;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object userVO = modelMap.get("userVO");
		if(userVO!=null) {
			session.setAttribute("login", userVO);
			session.setAttribute("UN", ((UserVO)userVO).getUserNumber());
		}
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("login")!=null) {
			session.removeAttribute("login");
			session.setAttribute("UN", -1);
			
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
		}
		return super.preHandle(request, response, handler);
	}

}
