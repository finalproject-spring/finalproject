package com.spring.recycle.model.dto;

import java.util.Date;

public class MemberDto {
	
	private int member_no;
	private String member_name;
	private String member_id;
	private String member_pw;
	private String member_email;
	private String member_phone;
	private String member_addr;
	private String member_pic;
	private int member_role ;
	private int member_delete;
	private String member_socialid;
	private String sessionid;
	private Date next;
	private boolean useCookie;
	
	
	
	public MemberDto() {
		super();
	}



	public MemberDto(int member_no, String member_name, String member_id, String member_pw, String member_email,
			String member_phone, String member_addr, String member_pic, int member_role, int member_delete,
			String member_socialid, String sessionid, Date next, boolean useCookie) {
		super();
		this.member_no = member_no;
		this.member_name = member_name;
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_email = member_email;
		this.member_phone = member_phone;
		this.member_addr = member_addr;
		this.member_pic = member_pic;
		this.member_role = member_role;
		this.member_delete = member_delete;
		this.member_socialid = member_socialid;
		this.sessionid = sessionid;
		this.next = next;
		this.useCookie = useCookie;
	}



	public int getMember_no() {
		return member_no;
	}



	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}



	public String getMember_name() {
		return member_name;
	}



	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}



	public String getMember_id() {
		return member_id;
	}



	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}



	public String getMember_pw() {
		return member_pw;
	}



	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}



	public String getMember_email() {
		return member_email;
	}



	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}



	public String getMember_phone() {
		return member_phone;
	}



	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}



	public String getMember_addr() {
		return member_addr;
	}



	public void setMember_addr(String member_addr) {
		this.member_addr = member_addr;
	}



	public String getMember_pic() {
		return member_pic;
	}



	public void setMember_pic(String member_pic) {
		this.member_pic = member_pic;
	}



	public int getMember_role() {
		return member_role;
	}



	public void setMember_role(int member_role) {
		this.member_role = member_role;
	}



	public int getMember_delete() {
		return member_delete;
	}



	public void setMember_delete(int member_delete) {
		this.member_delete = member_delete;
	}



	public String getMember_socialid() {
		return member_socialid;
	}



	public void setMember_socialid(String member_socialid) {
		this.member_socialid = member_socialid;
	}



	public String getSessionid() {
		return sessionid;
	}



	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}



	public Date getNext() {
		return next;
	}



	public void setNext(Date next) {
		this.next = next;
	}



	public boolean isUseCookie() {
		return useCookie;
	}



	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}



	@Override
	public String toString() {
		return "MemberDto [member_no=" + member_no + ", member_name=" + member_name + ", member_id=" + member_id
				+ ", member_pw=" + member_pw + ", member_email=" + member_email + ", member_phone=" + member_phone
				+ ", member_addr=" + member_addr + ", member_pic=" + member_pic + ", member_role=" + member_role
				+ ", member_delete=" + member_delete + ", member_socialid=" + member_socialid + ", sessionid="
				+ sessionid + ", next=" + next + ", useCookie=" + useCookie + "]";
	}
	
}
