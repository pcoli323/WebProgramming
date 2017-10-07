package org.tour.domain;

public class ImageVO {

	private int imageNumber;
	private int userNumber;
	private byte[] realfile;
	private byte[] thumfile;
	private String type;
	
	public int getImageNumber() {
		return imageNumber;
	}
	public void setImageNumber(int imageNumber) {
		this.imageNumber = imageNumber;
	}
	public int getUserNumber() {
		return userNumber;
	}
	public void setUserNumber(int userNumber) {
		this.userNumber = userNumber;
	}
	public byte[] getReadfile() {
		return realfile;
	}
	public void setRealfile(byte[] realfile) {
		this.realfile = realfile;
	}
	public byte[] getThumfile() {
		return thumfile;
	}
	public void setThumfile(byte[] thumfile) {
		this.thumfile = thumfile;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
