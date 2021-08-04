package com.spring.recycle.model.dto;

public class InfoDto {
	
	private int info_no;
	private String info_pic;
	private String info_title;
	private String info_content;
	private String info_start;
	private String info_end;
	
	public InfoDto() {
		
	}

	public InfoDto(int info_no, String info_pic, String info_title, String info_content, String info_start,
			String info_end) {
		super();
		this.info_no = info_no;
		this.info_pic = info_pic;
		this.info_title = info_title;
		this.info_content = info_content;
		this.info_start = info_start;
		this.info_end = info_end;
	}

	public int getInfo_no() {
		return info_no;
	}

	public void setInfo_no(int info_no) {
		this.info_no = info_no;
	}

	public String getInfo_pic() {
		return info_pic;
	}

	public void setInfo_pic(String info_pic) {
		this.info_pic = info_pic;
	}

	public String getInfo_title() {
		return info_title;
	}

	public void setInfo_title(String info_title) {
		this.info_title = info_title;
	}

	public String getInfo_content() {
		return info_content;
	}

	public void setInfo_content(String info_content) {
		this.info_content = info_content;
	}

	public String getInfo_start() {
		return info_start;
	}

	public void setInfo_start(String info_start) {
		this.info_start = info_start;
	}

	public String getInfo_end() {
		return info_end;
	}

	public void setInfo_end(String info_end) {
		this.info_end = info_end;
	}
	
	

}
