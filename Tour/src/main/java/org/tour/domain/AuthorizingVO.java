package org.tour.domain;

public class AuthorizingVO {
	private String email;
	private String authCode;
	
	public AuthorizingVO(String email, String authCode) {
		this.email = email;
		this.authCode = authCode;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
}
