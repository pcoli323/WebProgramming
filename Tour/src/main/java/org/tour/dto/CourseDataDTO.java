package org.tour.dto;

import java.util.Date;

public class CourseDataDTO {

	private String areaname;		// 지역명
	private String sigunguname;		// 시군구명
	private Long areacode;			// 지역코드
	private Long sigungucode;		// 시군구코드
	private Date startdate;			// 여행 시작 날짜
	private Date enddate;			// 여행 종료 날짜
	
	private String addr1;			// 주소
	private String addr2;			// 상세주소
	private boolean booktour;		// 교과서 속 여행지 여부
	private Long cat1;				// 대분류 코드
	private Long cat2;				// 중분류 코드
	private Long cat3;				// 소분류 코드
	private Long contentid;			// 콘텐츠 아이디
	private Long contenttypeid;		// 콘텐츠 타입 아이디
	private Long createdtime;		// 콘텐츠 최초 등록일
	private String firstimage;		// 원본 대표 이미지 (약 500*333)
	private String firstimage2;		// 썸네일 대표 이미지 (약 150*100)
	private Object mapx;			// GPS X좌표
	private Object mapy;			// GPS Y좌표
	private String mlevel;			// Map Level 응답
	private Long modifiedtime;		// 콘텐츠 수정일
	private Long readcount;			// 콘텐츠 조회수
	private String tel;				// 전화번호
	private String title;			// 콘텐츠 제목
	
	private Date specificDate;		// 여행 예정 날짜
	
	
	
	public String getAreaname() {
		return areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public String getSigunguname() {
		return sigunguname;
	}

	public void setSigunguname(String sigunguname) {
		this.sigunguname = sigunguname;
	}

	public Long getAreacode() {
		return areacode;
	}

	public void setAreacode(Long areacode) {
		this.areacode = areacode;
	}

	public Long getSigungucode() {
		return sigungucode;
	}

	public void setSigungucode(Long sigungucode) {
		this.sigungucode = sigungucode;
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

	public boolean isBooktour() {
		return booktour;
	}

	public void setBooktour(boolean booktour) {
		this.booktour = booktour;
	}

	public Long getCat1() {
		return cat1;
	}

	public void setCat1(Long cat1) {
		this.cat1 = cat1;
	}

	public Long getCat2() {
		return cat2;
	}

	public void setCat2(Long cat2) {
		this.cat2 = cat2;
	}

	public Long getCat3() {
		return cat3;
	}

	public void setCat3(Long cat3) {
		this.cat3 = cat3;
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

	public String getMlevel() {
		return mlevel;
	}

	public void setMlevel(String mlevel) {
		this.mlevel = mlevel;
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

	public Date getSpecificDate() {
		return specificDate;
	}

	public void setSpecificDate(Date specificDate) {
		this.specificDate = specificDate;
	}

}
