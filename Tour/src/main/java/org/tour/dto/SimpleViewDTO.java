package org.tour.dto;

import java.util.List;

import org.tour.domain.CourseInfoVO;

public class SimpleViewDTO {

	private int courseNumber;
	private String courseName;
	private int userNumber;
	private String userName;
	private List<CourseInfoVO> representatives;
	
	public int getCourseNumber() {
		return courseNumber;
	}
	public void setCourseNumber(int courseNumber) {
		this.courseNumber = courseNumber;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public int getUserNumber() {
		return userNumber;
	}
	public void setUserNumber(int userNumber) {
		this.userNumber = userNumber;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public List<CourseInfoVO> getRepresentatives() {
		return representatives;
	}
	public void setRepresentatives(List<CourseInfoVO> representatives) {
		this.representatives = representatives;
	}
}
