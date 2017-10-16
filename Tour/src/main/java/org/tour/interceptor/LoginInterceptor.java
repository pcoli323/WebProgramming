package org.tour.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object userVO = modelMap.get("userVO");
		if(userVO!=null) {
			session.setAttribute("login", userVO);
			//response.sendRedirect("/main");
		}
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("login")!=null) {
			session.removeAttribute("login");
			
			if(session.getAttribute("idList")!=null) {
				session.removeAttribute("idList");
			}
			if(session.getAttribute("list")!=null) {
				session.removeAttribute("list");
			}
			if(session.getAttribute("name")!=null) {
				session.removeAttribute("name");
			}
		}
		return super.preHandle(request, response, handler);
	}

}
