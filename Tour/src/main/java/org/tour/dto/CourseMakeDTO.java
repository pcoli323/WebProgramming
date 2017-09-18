package org.tour.dto;

import java.util.Date;

public class CourseMakeDTO {
	private String areaname;
	private Long areacode;	//
	private Date startdate;	//
	private Date enddate;	//
	private String addr1;
	private String addr2;
	private Long contentid;
	private Long contenttypeid;
	private Long createdtime;
	private String firstimage;
	private String firstimage2;
	private Object mapx;
	private Object mapy;
	private Long modifiedtime;
	private Long readcount;
	private String tel;
	private String title;
	
	public CourseMakeDTO(String areaname, Long areacode, Date startdate, Date enddate, String addr1, String addr2, Long contentid, Long contenttypeid,
			Long createdtime, String firstimage, String firstimage2, Object mapx, Object mapy, Long modifiedtime, Long readcount, String tel, String title) {
		this.areaname = areaname; this.areacode = areacode; this.startdate = startdate; this.enddate = enddate; this.addr1 = addr1; this.addr2 = addr2;
		this.contentid = contentid; this.contenttypeid = contenttypeid; this.createdtime = createdtime; this.firstimage = firstimage; this.firstimage2 = firstimage2;
		this.mapx = mapx; this.mapy = mapy; this.modifiedtime = modifiedtime; this.readcount = readcount; this.tel = tel; this.title = title;
	}

	public String getAreaname() {
		return areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public Long getAreacode() {
		return areacode;
	}

	public void setAreacode(Long areacode) {
		this.areacode = areacode;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public Long getContentid() {
		return contentid;
	}

	public void setContentid(Long contentid) {
		this.contentid = contentid;
	}

	public Long getContenttypeid() {
		return contenttypeid;
	}

	public void setContenttypeid(Long contenttypeid) {
		this.contenttypeid = contenttypeid;
	}

	public Long getCreatedtime() {
		return createdtime;
	}

	public void setCreatedtime(Long createdtime) {
		this.createdtime = createdtime;
	}

	public String getFirstimage() {
		return firstimage;
	}

	public void setFirstimage(String firstimage) {
		this.firstimage = firstimage;
	}

	public String getFirstimage2() {
		return firstimage2;
	}

	public void setFirstimage2(String firstimage2) {
		this.firstimage2 = firstimage2;
	}

	public Object getMapx() {
		return mapx;
	}

	public void setMapx(Object mapx) {
		this.mapx = mapx;
	}

	public Object getMapy() {
		return mapy;
	}

	public void setMapy(Object mapy) {
		this.mapy = mapy;
	}

	public Long getModifiedtime() {
		return modifiedtime;
	}

	public void setModifiedtime(Long modifiedtime) {
		this.modifiedtime = modifiedtime;
	}

	public Long getReadcount() {
		return readcount;
	}

	public void setReadcount(Long readcount) {
		this.readcount = readcount;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
