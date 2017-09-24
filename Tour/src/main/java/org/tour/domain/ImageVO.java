package org.tour.domain;

public class ImageVO {

	private int imageNumber;
	private byte[] readfile;
	private byte[] thumfile;
	
	public int getImageNumber() {
		return imageNumber;
	}
	public void setImageNumber(int imageNumber) {
		this.imageNumber = imageNumber;
	}
	public byte[] getReadfile() {
		return readfile;
	}
	public void setReadfile(byte[] readfile) {
		this.readfile = readfile;
	}
	public byte[] getThumfile() {
		return thumfile;
	}
	public void setThumfile(byte[] thumfile) {
		this.thumfile = thumfile;
	}
	
	
}
