package org.tour.dto;

public class CourseInfoDTO {

	private int gotoNumber;
	private String gotoName;
	private String locationX;
	private String locationY;
	private String gotoImage;
	private boolean isRepresented;
	private int representedOrder;
	
	public int getGotoNumber() {
		return gotoNumber;
	}
	public void setGotoNumber(int gotoNumber) {
		this.gotoNumber = gotoNumber;
	}
	public String getGotoName() {
		return gotoName;
	}
	public void setGotoName(String gotoName) {
		this.gotoName = gotoName;
	}
	public String getLocationX() {
		return locationX;
	}
	public void setLocationX(String locationX) {
		this.locationX = locationX;
	}
	public String getLocationY() {
		return locationY;
	}
	public void setLocationY(String locationY) {
		this.locationY = locationY;
	}
	public String getGotoImage() {
		return gotoImage;
	}
	public void setGotoImage(String gotoImage) {
		this.gotoImage = gotoImage;
	}
	public boolean getIsRepresented() {
		return isRepresented;
	}
	public void setIsRepresented(boolean isRepresented) {
		this.isRepresented = isRepresented;
	}
	public int getRepresentedOrder() {
		return representedOrder;
	}
	public void setRepresentedOrder(int representedOrder) {
		this.representedOrder = representedOrder;
	}
}
