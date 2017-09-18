package org.tour.domain;

public class ImageVO {

	private String title;
	
	private byte[] realfile;
	
	public byte[] getRealfile() {
		return realfile;
	}
	public void setRealfile(byte[] realfile) {
		this.realfile = realfile;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Override
	public String toString() {
		return "title : " + title + "  realfile : " + realfile;
	}
}
