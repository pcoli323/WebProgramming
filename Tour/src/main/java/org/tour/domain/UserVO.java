package org.tour.domain;

import java.sql.Timestamp;
import java.util.Date;

public class UserVO {

	private int userNumber;
	private String email;
	private String pwd;
	private String userName;
	private Date regDate;
	private Date updateDate;
	
	public UserVO(String email, String pwd, String userName) {
		this.email = email;
		this.pwd = pwd;
		this.userName = userName;
	}
	public UserVO(Integer userNumber, String email, String pwd, String userName, Timestamp regDate, Timestamp updateDate) {
		this.userNumber = userNumber;
		this.email = email;
		this.pwd = pwd;
		this.userName = userName;
		this.regDate = regDate;
		this.updateDate = updateDate;
	}
	
	public int getUserNumber() {
		return userNumber;
	}
	public void setUserNumber(int userNumber) {
		this.userNumber = userNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
}
