package com.spring.recycle.model.dto;

import java.util.Date;

public class DealBoardDto {

	private int board_no;
	private String board_category;
	private String board_id;
	private String board_title;
	private String board_content;
	private Date board_date;
	private String board_views;
	private String board_secret;
	private int board_price;
	private int board_prodno;
	private int board_groupno;
	private int board_group;
	private int member_no;
	private String board_filter;
	
	public DealBoardDto() {}

	public DealBoardDto(int board_no, String board_category, String board_id, String board_title, String board_content, 
				   Date board_date, String board_views, String board_secret, int board_price, int board_prodno, 
				   int board_groupno, int board_group, int member_no, String board_filter) {
		this.board_no = board_no;
		this.board_category = board_category;
		this.board_id = board_id;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_date = board_date;
		this.board_views = board_views;
		this.board_secret = board_secret;
		this.board_price = board_price;
		this.board_prodno = board_prodno;
		this.board_groupno = board_groupno;
		this.board_group = board_group;
		this.member_no = member_no;
		this.board_filter = board_filter;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getBoard_category() {
		return board_category;
	}

	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}

	public String getBoard_id() {
		return board_id;
	}

	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public Date getBoard_date() {
		return board_date;
	}

	public void setBoard_date(Date board_date) {
		this.board_date = board_date;
	}

	public String getBoard_views() {
		return board_views;
	}

	public void setBoard_views(String board_views) {
		this.board_views = board_views;
	}

	public String getBoard_secret() {
		return board_secret;
	}

	public void setBoard_secret(String board_secret) {
		this.board_secret = board_secret;
	}

	public int getBoard_price() {
		return board_price;
	}

	public void setBoard_price(int board_price) {
		this.board_price = board_price;
	}

	public int getBoard_prodno() {
		return board_prodno;
	}

	public void setBoard_prodno(int board_prodno) {
		this.board_prodno = board_prodno;
	}

	public int getBoard_groupno() {
		return board_groupno;
	}

	public void setBoard_groupno(int board_groupno) {
		this.board_groupno = board_groupno;
	}

	public int getBoard_group() {
		return board_group;
	}

	public void setBoard_group(int board_group) {
		this.board_group = board_group;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
	public String getboard_filter() {
		return board_filter;
	}

	public void setboard_filter(String board_filter) {
		this.board_filter = board_filter;
	}
	
}
