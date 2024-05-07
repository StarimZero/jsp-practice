package model;

import java.sql.*;
import java.util.Date;

public class JusoVO {
	private int uid;
	private String uname;
	private String add1;
	private String add2;
	private String phone;
	private String photo;
	private Date jdate;
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getAdd1() {
		return add1;
	}
	public void setAdd1(String add1) {
		this.add1 = add1;
	}
	public String getAdd2() {
		return add2;
	}
	public void setAdd2(String add2) {
		this.add2 = add2;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public Date getJdate() {
		return jdate;
	}
	public void setJdate(Date jdate) {
		this.jdate = jdate;
	}
	@Override
	public String toString() {
		return "JusoVO [uid=" + uid + ", uname=" + uname + ", add1=" + add1 + ", add2=" + add2 + ", phone=" + phone
				+ ", photo=" + photo + ", jdate=" + jdate + "]";
	}
	
	
}
