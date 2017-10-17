package org.tour.dto;

import java.util.Date;

public class CourseIDDTO {

	private int areaCode;
	private int sigunguCode;
	private String areaName;
	private String sigunguName;
	private Date startDate;
	private Date endDate;
	
	public int getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(int areaCode) {
		this.areaCode = areaCode;
	}
	public int getSigunguCode() {
		return sigunguCode;
	}
	public void setSigunguCode(int sigunguCode) {
		this.sigunguCode = sigunguCode;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getSigunguName() {
		return sigunguName;
	}
	public void setSigunguName(String sigunguName) {
		this.sigunguName = sigunguName;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
}
