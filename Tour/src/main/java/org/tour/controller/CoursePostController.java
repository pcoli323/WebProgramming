package org.tour.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.tour.domain.CourseVO;
import org.tour.domain.UserVO;
import org.tour.dto.CourseInfoDTO;
import org.tour.service.CourseService;
import org.tour.service.PlanService;

@Controller
@RequestMapping("/mypage/upload/*")
public class CoursePostController {
	
	@Inject
	private CourseService courseService;
	@Inject
	private PlanService planService;
	

	@RequestMapping(value = "", method = RequestMethod.GET)
	public void coursePost(HttpServletRequest request, @RequestParam("courseNumber") int courseNumber, Model model) throws Exception{
		
		try {
			HttpSession	session = request.getSession();
			UserVO loginUser = new UserVO();;
			if(session.getAttribute("login") == null) {
				model.addAttribute("loginCheck", false);
				loginUser.setUserNumber(-1);
				loginUser.setEmail(null);
				loginUser.setPwd(null);
				loginUser.setUserName(null);
				
				CourseVO courseVO = courseService.read(courseNumber);
				Map<String, List<CourseInfoDTO>> plan = planService.gotoListAccordingToDate(courseNumber);
				
				
				model.addAttribute("loginUser", loginUser);
				model.addAttribute("courseNumber", courseNumber);
				model.addAttribute("courseVO", courseVO);
				model.addAttribute("plan", plan);
			}
			else {
				model.addAttribute("loginCheck", true);
				loginUser = (UserVO) session.getAttribute("login");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
