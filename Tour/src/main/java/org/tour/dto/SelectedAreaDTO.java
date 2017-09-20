package org.tour.dto;

import java.util.ArrayList;
import java.util.List;

public class SelectedAreaDTO {
	
	String areaname;			// ������
	String areacode;			// �����ڵ�
	List<Sigungu> sigungulist;	// �ñ����� �� �ñ����ڵ�
	String startdate;			// ���� ���� ��¥
	String enddate;				// ���� ���� ��¥
	
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
