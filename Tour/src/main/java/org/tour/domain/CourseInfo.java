package org.tour.domain;

import java.util.Date;

public class CourseInfo {

	private int gotoNumber;
	private int courseNumber;
	private Date gotoDate;
	private String regionCode;
	private String gotoCode;
	private String gotoImage;
	private String gotoLocation;
	private boolean isRepresented;
	private int representedOrder;
	
	public int getGotoNumber() {
		return gotoNumber;
	}
	public void setGotoNumber(int gotoNumber) {
		this.gotoNumber = gotoNumber;
	}
	public int getCourseNumber() {
		return courseNumber;
	}
	public void setCourseNumber(int courseNumber) {
		this.courseNumber = courseNumber;
	}
	public Date getGotoDate() {
		return gotoDate;
	}
	public void setGotoDate(Date gotoDate) {
		this.gotoDate = gotoDate;
	}
	public String getRegionCode() {
		return regionCode;
	}
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	public String getGotoCode() {
		return gotoCode;
	}
	public void setGotoCode(String gotoCode) {
		this.gotoCode = gotoCode;
	}
	public String getGotoImage() {
		return gotoImage;
	}
	public void setGotoImage(String gotoImage) {
		this.gotoImage = gotoImage;
	}
	public String getGotoLocation() {
		return gotoLocation;
	}
	public void setGotoLocation(String gotoLocation) {
		this.gotoLocation = gotoLocation;
	}
	public boolean isRepresented() {
		return isRepresented;
	}
	public void setRepresented(boolean isRepresented) {
		this.isRepresented = isRepresented;
	}
	public int getRepresentedOrder() {
		return representedOrder;
	}
	public void setRepresentedOrder(int representedOrder) {
		this.representedOrder = representedOrder;
	}
	
}
