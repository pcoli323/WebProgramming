package org.tour.domain;

import java.util.Date;

public class CourseInfoSimpleVO {

	private int courseNumber;
	private int areaCode;
	private int sigunguCode;
	private Date startDate;
	private Date endDate;
	
	public int getCourseNumber() {
		return courseNumber;
	}
	public CourseInfoSimpleVO setCourseNumber(int courseNumber) {
		this.courseNumber = courseNumber;
		return this;
	}
	public int getAreaCode() {
		return areaCode;
	}
	public CourseInfoSimpleVO setAreaCode(int areaCode) {
		this.areaCode = areaCode;
		return this;
	}
	public int getSigunguCode() {
		return sigunguCode;
	}
	public CourseInfoSimpleVO setSigunguCode(int sigunguCode) {
		this.sigunguCode = sigunguCode;
		return this;
	}
	public Date getStartDate() {
		return startDate;
	}
	public CourseInfoSimpleVO setStartDate(Date startDate) {
		this.startDate = startDate;
		return this;
	}
	public Date getEndDate() {
		return endDate;
	}
	public CourseInfoSimpleVO setEndDate(Date endDate) {
		this.endDate = endDate;
		return this;
	}
	
}
