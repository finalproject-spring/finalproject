package com.spring.recycle.model.dto;

import java.util.Date;

public class GroupDto {
	/*BOARD_NO NUMBER PRIMARY KEY,
    BOARD_CATEGORY VARCHAR2(30) NOT NULL CHECK (BOARD_CATEGORY IN ('정보안내', '소모임', '공지문의', '상품판매', '상품후기')),
    BOARD_ID VARCHAR2(20) NOT NULL,
    BOARD_TITLE VARCHAR2(50) NOT NULL,
    BOARD_CONTENT LONG NOT NULL,
    BOARD_DATE DATE NOT NULL,
    BOARD_VIEWS NUMBER,
    BOARD_SECRET VARCHAR2(10),
    BOARD_INTEREST VARCHAR2(20),
    BOARD_PRODUCT VARCHAR2(20),
    BOARD_PRICE NUMBER,
    BOARD_PRODNO NUMBER,
    BOARD_GROUPNO NUMBER,
    BOARD_GROUP NUMBER,
    BOARD_CNUM VARCHAR2(20) NOT NULL,
    MEMBER_NO NUMBER NOT NULL,
    CONSTRAINT BOARD_FK FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE
	\
	 */
	private int board_no;
	private String board_id;
	private String board_title;
	private String board_content;
	private Date board_date;
	private Integer board_views;
	private String board_filter;
	
	public GroupDto() {
		super();
	}
	public GroupDto(int board_no, String board_id, String board_title, String board_content, Date board_date,
			Integer board_views, String board_filter) {
		super();
		this.board_no = board_no;
		this.board_id = board_id;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_date = board_date;
		this.board_views = board_views;
		this.board_filter = board_filter;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
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
	public Integer getBoard_views() {
		return board_views;
	}
	public void setBoard_views(Integer board_views) {
		this.board_views = board_views;
	}
	public String getBoard_filter() {
		return board_filter;
	}
	public void setBoard_filter(String board_filter) {
		this.board_filter = board_filter;
	}
	@Override
	public String toString() {
		return "GroupDto [board_no=" + board_no + ", board_id=" + board_id + ", board_title=" + board_title
				+ ", board_content=" + board_content + ", board_date=" + board_date + ", board_views=" + board_views
				+ ", board_filter=" + board_filter + "]";
	}

}
