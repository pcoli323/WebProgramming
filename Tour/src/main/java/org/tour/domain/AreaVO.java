package org.tour.domain;

public class AreaVO {

	private int areaCode;
	private String areaName;
	private boolean isServiced;
	private boolean isServicedAll;
	
	public int getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(int areaCode) {
		this.areaCode = areaCode;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public boolean isServiced() {
		return isServiced;
	}
	public void setServiced(boolean isServiced) {
		this.isServiced = isServiced;
	}
	public boolean isServicedAll() {
		return isServicedAll;
	}
	public void setServicedAll(boolean isServicedAll) {
		this.isServicedAll = isServicedAll;
	}
	
}
