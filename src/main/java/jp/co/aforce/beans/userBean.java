package jp.co.aforce.beans;

import java.io.Serializable;

public class userBean implements Serializable {
	private String memberId;
	private String password;
	private String lastname;
	private String firstname;
	private String address;
	private String mailAddress;

	/*================================================
	 *----------------------------------- GET------------------------------------------
	 *================================================*/
	public String getMemberId() 		{return memberId;}
	
	public String getPassword() 		{return password;}
	
	public String getLastname() 		{return lastname;}
	
	public String getFirstname() 		{return firstname;}
	
	public String getAddress() 			{return address;}
	
	public String getMailAddress() 	{return mailAddress;}

	/*================================================
	 *----------------------------------- SET------------------------------------------
	 *================================================*/
	public void setMemberId(String memberId) 		{this.memberId = memberId;}
	
	public void setPassword(String password) 			{this.password = password;}
	
	public void setLastname(String lastname) 			{this.lastname = lastname;}
	
	public void setFirstname(String firstname) 			{this.firstname = firstname;}
	
	public void setAddress(String address) 				{this.address = address;}
	
	public void setMailAddress(String mailAddress) 	{this.mailAddress = mailAddress;}

}
