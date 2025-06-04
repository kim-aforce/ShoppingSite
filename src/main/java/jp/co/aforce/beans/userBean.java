package jp.co.aforce.beans;

import java.io.Serializable;

public class userBean implements Serializable {
	private String member_Id;
	private String password;
	private String last_name;

	private String firstname;
	private String address;
	private String mailAddress;


	/*================================================
	 *----------------------------------- GET------------------------------------------
	 *================================================*/

	public String getMemberId() {
		return member_Id;
	}
	public String getPassword() {
		return password;
	}
	public String getLastname() {
		return last_name;
	}
	public String getFirstname() {
		return firstname;
	}
	public String getAddress() {
		return address;
	}
	public String getMailAddress() {
		return mailAddress;
	}

	/*================================================
	 *----------------------------------- SET------------------------------------------
	 *================================================*/

	public void setMemberId(String member_Id) {
		this.member_Id = member_Id;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setLastname(String last_name) {
		this.last_name = last_name;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}

}
