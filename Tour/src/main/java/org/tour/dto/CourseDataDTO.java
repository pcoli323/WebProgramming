package org.tour.dto;

import java.util.Date;

public class CourseDataDTO {

	private String areaname;		// ������
	private String sigunguname;		// �ñ�����
	private Long areacode;			// �����ڵ�
	private Long sigungucode;		// �ñ����ڵ�
	private Date startdate;			// ���� ���� ��¥
	private Date enddate;			// ���� ���� ��¥
	
	private String addr1;			// �ּ�
	private String addr2;			// ���ּ�
	private boolean booktour;		// ������ �� ������ ����
	private Long cat1;				// ��з� �ڵ�
	private Long cat2;				// �ߺз� �ڵ�
	private Long cat3;				// �Һз� �ڵ�
	private Long contentid;			// ������ ���̵�
	private Long contenttypeid;		// ������ Ÿ�� ���̵�
	private Long createdtime;		// ������ ���� �����
	private String firstimage;		// ���� ��ǥ �̹��� (�� 500*333)
	private String firstimage2;		// ����� ��ǥ �̹��� (�� 150*100)
	private Object mapx;			// GPS X��ǥ
	private Object mapy;			// GPS Y��ǥ
	private String mlevel;			// Map Level ����
	private Long modifiedtime;		// ������ ������
	private Long readcount;			// ������ ��ȸ��
	private String tel;				// ��ȭ��ȣ
	private String title;			// ������ ����
	
	private Date specificDate;		// ���� ���� ��¥
	
	
	
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
