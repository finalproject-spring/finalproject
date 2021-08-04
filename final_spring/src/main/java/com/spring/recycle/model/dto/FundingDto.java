package com.spring.recycle.model.dto;

public class FundingDto {
	
	private int funding_no;
	private String funding_pic;
	private String funding_title;
	private String funding_content;
	private String funding_filter;
	private String funding_start;
	private String funding_end;
	private int funding_ta;
	private int funding_ca;
	private String funding_pay;
	private String funding_paydesc;

	public FundingDto() {
	
	}

	public FundingDto(int funding_no, String funding_pic, String funding_title, String funding_content,
			String funding_filter, String funding_start, String funding_end, int funding_ta, int funding_ca,
			String funding_pay, String funding_paydesc) {
		this.funding_no = funding_no;
		this.funding_pic = funding_pic;
		this.funding_title = funding_title;
		this.funding_content = funding_content;
		this.funding_filter = funding_filter;
		this.funding_start = funding_start;
		this.funding_end = funding_end;
		this.funding_ta = funding_ta;
		this.funding_ca = funding_ca;
		this.funding_pay = funding_pay;
		this.funding_paydesc = funding_paydesc;
	}

	public int getFunding_no() {
		return funding_no;
	}

	public void setFunding_no(int funding_no) {
		this.funding_no = funding_no;
	}

	public String getFunding_pic() {
		return funding_pic;
	}

	public void setFunding_pic(String funding_pic) {
		this.funding_pic = funding_pic;
	}

	public String getFunding_title() {
		return funding_title;
	}

	public void setFunding_title(String funding_title) {
		this.funding_title = funding_title;
	}

	public String getFunding_content() {
		return funding_content;
	}

	public void setFunding_content(String funding_content) {
		this.funding_content = funding_content;
	}

	public String getFunding_filter() {
		return funding_filter;
	}

	public void setFunding_filter(String funding_filter) {
		this.funding_filter = funding_filter;
	}

	public String getFunding_start() {
		return funding_start;
	}

	public void setFunding_start(String funding_start) {
		this.funding_start = funding_start;
	}

	public String getFunding_end() {
		return funding_end;
	}

	public void setFunding_end(String funding_end) {
		this.funding_end = funding_end;
	}

	public int getFunding_ta() {
		return funding_ta;
	}

	public void setFunding_ta(int funding_ta) {
		this.funding_ta = funding_ta;
	}

	public int getFunding_ca() {
		return funding_ca;
	}

	public void setFunding_ca(int funding_ca) {
		this.funding_ca = funding_ca;
	}

	public String getFunding_pay() {
		return funding_pay;
	}

	public void setFunding_pay(String funding_pay) {
		this.funding_pay = funding_pay;
	}

	public String getFunding_paydesc() {
		return funding_paydesc;
	}

	public void setFunding_paydesc(String funding_paydesc) {
		this.funding_paydesc = funding_paydesc;
	}

	@Override
	public String toString() {
		return "FundingDto [funding_no=" + funding_no + ", funding_pic=" + funding_pic + ", funding_title="
				+ funding_title + ", funding_content=" + funding_content + ", funding_filter=" + funding_filter
				+ ", funding_start=" + funding_start + ", funding_end=" + funding_end + ", funding_ta=" + funding_ta
				+ ", funding_ca=" + funding_ca + ", funding_pay=" + funding_pay + ", funding_paydesc=" + funding_paydesc
				+ "]";
	}
	
	
}
