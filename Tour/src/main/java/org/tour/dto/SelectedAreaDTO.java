package org.tour.dto;

import java.util.ArrayList;
import java.util.List;

public class SelectedAreaDTO {
	
	String areaname;			// 지역명
	String areacode;			// 지역코드
	List<Sigungu> sigungulist;	// 시군구명 및 시군구코드
	String startdate;			// 여행 시작 날짜
	String enddate;				// 여행 종료 날짜
	
	public SelectedAreaDTO () {
		sigungulist = new ArrayList<Sigungu>();
	}
	
	public void addSigungu(String sigunguname, String sugungucode) {
		Sigungu sigungu = new Sigungu(sigunguname, sugungucode);
		sigungulist.add(sigungu);
	}
	
	public String getAreaname() {
		return areaname;
	}
	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
}
