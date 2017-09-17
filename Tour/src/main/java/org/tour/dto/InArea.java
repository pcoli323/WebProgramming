package org.tour.dto;

public class InArea {
	String sAreaName;
	Long sAreaCode;
	
	public InArea(String sAreaName, Long sAreaCode) {
		this.sAreaName = sAreaName;
		this.sAreaCode = sAreaCode;
	}
	
	public String getsAreaName() {
		return sAreaName;
	}
	public void setsAreaName(String sAreaName) {
		this.sAreaName = sAreaName;
	}
	public Long getsAreaCode() {
		return sAreaCode;
	}
	public void setsAreaCode(Long sAreaCode) {
		this.sAreaCode = sAreaCode;
	}
}
