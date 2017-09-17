package org.tour.dto;

import java.util.ArrayList;
import java.util.List;

public class AreaDTO {
	
	String areaName;
	Long areaCode;
	int sAreaNum;
	List<InArea> sAreaList;
	
	public AreaDTO () {
		sAreaList = new ArrayList<InArea>();
	}
	
	public void addSArea(String sAreaName, Long sAreaCode) {
		InArea inArea = new InArea(sAreaName, sAreaCode);
		sAreaList.add(inArea);
	}
	
	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public Long getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(Long areaCode) {
		this.areaCode = areaCode;
	}

	public int getsAreaNum() {
		return sAreaNum;
	}

	public void setsAreaNum(int sAreaNum) {
		this.sAreaNum = sAreaNum;
	}

	public List<InArea> getsAreaList() {
		return sAreaList;
	}

	public void setsAreaList(List<InArea> sAreaList) {
		this.sAreaList = sAreaList;
	}
}
