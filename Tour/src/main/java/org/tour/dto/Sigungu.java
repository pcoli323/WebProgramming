package org.tour.dto;

public class Sigungu {
	String sigunguname;
	String sugungucode;
	
	public Sigungu(String sigunguname, String sugungucode) {
		this.sigunguname = sigunguname;
		this.sugungucode = sugungucode;
	}
	
	public String getSigunguname() {
		return sigunguname;
	}
	public void setSigunguname(String sigunguname) {
		this.sigunguname = sigunguname;
	}
	public String getSugungucode() {
		return sugungucode;
	}
	public void setSugungucode(String sugungucode) {
		this.sugungucode = sugungucode;
	}
	
}
