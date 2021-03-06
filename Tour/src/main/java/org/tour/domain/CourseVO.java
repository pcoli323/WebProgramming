package org.tour.domain;

import java.util.Date;

public class CourseVO {

	private int courseNumber;
	private String courseName;
	private int userNumber;
	private Date regDate;
	private Date updateDate;
	private boolean isPosted;
	private boolean isGotten;
	private String story;
	private int readCount;
	
	public int getCourseNumber() {
		return courseNumber;
	}
	public CourseVO setCourseNumber(int courseNumber) {
		this.courseNumber = courseNumber;
		return this;
	}
	public String getCourseName() {
		return courseName;
	}
	public CourseVO setCourseName(String courseName) {
		this.courseName = courseName;
		return this;
	}
	public int getUserNumber() {
		return userNumber;
	}
	public CourseVO setUserNumber(int userNumber) {
		this.userNumber = userNumber;
		return this;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public boolean isPosted() {
		return isPosted;
	}
	public void setPosted(boolean isPosted) {
		this.isPosted = isPosted;
	}
	public boolean isGotten() {
		return isGotten;
	}
	public void setGotten(boolean isGotten) {
		this.isGotten = isGotten;
	}
	public String getStory() {
		return story;
	}
	public void setStory(String story) {
		this.story = story;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
}
